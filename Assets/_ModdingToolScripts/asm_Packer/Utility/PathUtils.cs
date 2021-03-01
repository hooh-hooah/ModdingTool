using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using ModPackerModule.Structure;
using ModPackerModule.Structure.SideloaderMod;
using MyBox;
using UnityEditor;
using UnityEngine;
using Debug = UnityEngine.Debug;
using Object = UnityEngine.Object;

namespace ModPackerModule.Utility
{
    public static class PathUtils
    {
        private static readonly Regex badPathName = new Regex("[\\\\/:*?\\\"<>|]");

        private static readonly TextInfo textFormatObject = new CultureInfo("en-US", false).TextInfo;

        private static readonly Regex OnlyCharRegex = new Regex("[^A-z0-9]", RegexOptions.Compiled);

        public static string GetProjectPath()
        {
            try
            {
                var projectBrowserType = Type.GetType("UnityEditor.ProjectBrowser,UnityEditor");
                var projectBrowser = projectBrowserType?.GetField("s_LastInteractedProjectBrowser", BindingFlags.Static | BindingFlags.Public)?.GetValue(null);
                var invokeMethod = projectBrowserType?.GetMethod("GetActiveFolderPath", BindingFlags.NonPublic | BindingFlags.Instance);
                return (string) invokeMethod?.Invoke(projectBrowser, new object[] { });
            }
            catch (Exception exception)
            {
                Debug.LogWarning("Error while trying to get current project path.");
                Debug.LogWarning(exception.Message);
                return string.Empty;
            }
        }

        public static bool IsBadPath(this string path)
        {
            return badPathName.IsMatch(path);
        }
        
        public static string EscapePath(string path)
        {
            return badPathName.Replace(path, "");
        }

        public static string GetNiceObjectName(string value)
        {
            value = Regex.Replace(value, "([a-z])([A-Z])", "$1 $2");
            value = Regex.Replace(value, "([_-])", " ");
            value = textFormatObject.ToTitleCase(value);

            return value;
        }

        public static string ToUnixPath(this string value)
        {
            return value?.Replace("\\", "/");
        }

        public static string[] GetFiles(string path)
        {
            return GetFilesWithRegex(path);
        }

        public static string[] GetFilesWithRegex(string path, string regex = "", RegexOptions options = RegexOptions.IgnoreCase)
        {
            var files = Directory.GetFiles(path);
            if (regex.IsNullOrEmpty())
                return files.Where(file => !file.EndsWith(".meta")).Select(ToUnixPath).ToArray();

            var regexCmp = new Regex(regex, options);
            return files
                .Where(file => regexCmp.IsMatch(file) && !file.EndsWith(".meta"))
                .Select(ToUnixPath)
                .ToArray();
        }

        public static string SanitizeNameForGrouping(string assetName)
        {
            return Constants.RegexNumbers.Replace(
                Constants.RegexState.Replace(Path.GetFileNameWithoutExtension(assetName), Constants.Empty)
                , Constants.Empty);
        }

        public static T[] LoadAssetsFromDirectory<T>(string path, string regex) where T : Object
        {
            return GetFilesWithRegex(path, regex)
                .Select(AssetDatabase.LoadAssetAtPath<T>)
                .ToArray();
        }

        public static void OpenPath(string path)
        {
            if (!Directory.Exists(path)) return;

            var process = new Process();
            var startInfo = new ProcessStartInfo
            {
                WindowStyle = ProcessWindowStyle.Hidden, FileName = "cmd.exe", Arguments = $"/C start explorer.exe {path}"
            };
            process.StartInfo = startInfo;
            process.Start();
        }

        public static void CopyDirectory(string src, string target)
        {
            foreach (var dirPath in Directory.GetDirectories(src, "*",
                SearchOption.AllDirectories))
                Directory.CreateDirectory(dirPath.Replace(src, target));
            Directory.CreateDirectory(target);

            foreach (var newPath in Directory.GetFiles(src, "*.*",
                SearchOption.AllDirectories))
            {
                if (newPath.Contains(".meta")) continue;
                File.Copy(newPath, newPath.Replace(src, target), true);
            }
        }

        public static string SanitizeBadPath(this string path, string character = "_")
        {
            return string.Join(character, path.Split(Path.GetInvalidFileNameChars()));
        }

        public static string SanitizeNonCharacters(this string path, string character = "_")
        {
            return OnlyCharRegex.Replace(path, character);
        }

        public static string GetAbsolutePath(string path)
        {
            return Path.Combine(Directory.GetCurrentDirectory(), path).ToUnixPath();
        }

        public static Dictionary<T, SideloaderMod> GetAllNearestModData<T>(IEnumerable<T> lists) where T : Object
        {
            var sideloaderMods = lists.Select(x => Path.GetDirectoryName(AssetDatabase.GetAssetPath(x))).Distinct().ToDictionary(
                x => x,
                directory =>
                {
                    var currentDirectory = directory;
                    var failsafe = 100;
                    while (failsafe >= 0 || currentDirectory == "")
                    {
                        var xmlFilePath = GetFilesWithRegex(GetAbsolutePath(currentDirectory), @".*\.xml")
                            .Where(SideloaderMod.IsValidModXml)
                            .Select(path => path.Replace(Directory.GetCurrentDirectory().ToUnixPath(), "").Substring(1))
                            .FirstOrDefault();

                        if (!xmlFilePath.IsNullOrEmpty() && TryLoadAsset<TextAsset>(xmlFilePath, out var textAsset)) return new SideloaderMod(textAsset);

                        currentDirectory = currentDirectory == "Assets" ? "" : Path.GetDirectoryName(currentDirectory);
                        failsafe--;
                    }

                    return null;
                });

            return lists.Select(x => (x, dir: Path.GetDirectoryName(AssetDatabase.GetAssetPath(x)))).Distinct()
                .ToDictionary(x => x.x, x => sideloaderMods.TryGetValue(x.dir, out var mod) ? mod : null);
        }

        public static bool TryFindNearestModData<T>(this T data, out SideloaderMod result) where T : Object
        {
            result = null;
            var assetPath = AssetDatabase.GetAssetPath(data);
            var currentDirectory = Path.GetDirectoryName(assetPath);

            var failsafe = 100;
            while (failsafe >= 0 || currentDirectory == "")
            {
                var xmlFilePath = GetFilesWithRegex(GetAbsolutePath(currentDirectory), @".*\.xml")
                    .Where(SideloaderMod.IsValidModXml)
                    .Select(path => path.Replace(Directory.GetCurrentDirectory().ToUnixPath(), "").Substring(1))
                    .FirstOrDefault();

                if (!xmlFilePath.IsNullOrEmpty() && TryLoadAsset<TextAsset>(xmlFilePath, out var textAsset))
                {
                    result = new SideloaderMod(textAsset);
                    return true;
                }


                currentDirectory = currentDirectory == "Assets" ? "" : Path.GetDirectoryName(currentDirectory);
                failsafe--;
            }

            return false;
        }

        public static bool TryLoadAsset<T>(string path, out T asset) where T : Object
        {
            var loadedAsset = AssetDatabase.LoadAssetAtPath<T>(path);
            if (ReferenceEquals(null, loadedAsset))
            {
                asset = default;
                return false;
            }

            asset = loadedAsset;
            return true;
        }
    }
}