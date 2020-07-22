#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Media;
using System.Xml;
using System.Xml.Linq;
using Common;
using UnityEditor;
using UnityEngine;
using Debug = UnityEngine.Debug;

namespace ModPackerModule
{
    public static partial class ModPacker
    {
        public static void Announce(bool isSuccess = true, string message = "Please check the console the see error.")
        {
            if (isSuccess)
            {
                EditorApplication.Beep();
                if (EditorUtility.DisplayDialog("Alert", "Build Successful!", "Open Folder", "Okay"))
                    if (Directory.Exists(HoohTools.GameExportPath))
                    {
                        var process = new Process();
                        var startInfo = new ProcessStartInfo
                        {
                            WindowStyle = ProcessWindowStyle.Hidden, FileName = "cmd.exe", Arguments = $"/C start explorer.exe {HoohTools.GameExportPath}"
                        };
                        process.StartInfo = startInfo;
                        process.Start();
                    }
            }
            else
            {
                EditorUtility.DisplayDialog("FAILED!", message, "Dismiss");
            }
        }

        private static XDocument ParseModXML(TextAsset asset)
        {
            if (asset == null) return null;
            try
            {
                var modDocument = new XmlDocument();
                modDocument.LoadXml(asset.text);
                return XDocument.Parse(modDocument.OuterXml);
            }
            catch (Exception e)
            {
                EditorUtility.DisplayDialog("Error: Mod Packing",
                    "An Error occured while parsing xml data. please check if xml data is formatted correctly. check more detailed information in console", "OK");
                Debug.LogWarning(e);
                Debug.Log("Also you can validate your XML from here: https://www.xmlvalidation.com/");
            }

            return null;
        }

        public static TextAsset[] GetProjectDirectoryTextAssets()
        {
            return Directory.GetFiles(Utility.GetProjectPath())
                .Where(x => x.EndsWith(".xml"))
                .Select(x => AssetDatabase.LoadAssetAtPath<TextAsset>(x.Replace("\\", "/")))
                .ToArray();
        }

        public static void PackMod(TextAsset[] assets, string exportGamePath, bool doDeploy = true)
        {
            if (!Directory.Exists(exportGamePath))
            {
                EditorUtility.DisplayDialog("Error: Mod Packing",
                    "Target destination does not exists! Check if you provided valid target directory.", "Okay, I'll be more smart.");
                return;
            }

            if (assets == null || assets.Length <= 0)
            {
                Debug.LogWarning("Target is empty! Attempting to get all xml files from current project folder.");
                assets = GetProjectDirectoryTextAssets();
            }

            if (assets == null || assets.Length <= 0)
            {
                EditorUtility.DisplayDialog("Error: Mod Packing",
                    "There is no xml files to parse. Please add at least one file in mod builder.\nYou can manually drag and drop to targets or open a folder with .xml folders.",
                    "OK");
                return;
            }

            List<ModPackInfo> modPackInfos = null;

            try
            {
                modPackInfos = assets.Select(x => new ModPackInfo(ParseModXML(x), AssetDatabase.GetAssetPath(x))).ToList();
            }
            catch (Exception e)
            {
                SystemSounds.Exclamation.Play();
                EditorUtility.DisplayDialog("Error!", "Failed to parse bundle information.\nCheck console for more detailed information.", "YES");
                throw new Exception("Failed to parse bundles.");
            }

            modPackInfos.ForEach(modInfo =>
            {
                    modInfo.BuildAssetBundles();
                    modInfo.SwapMaterial();
                    modInfo.SetupModFolder();
                    if (doDeploy) modInfo.DeployZipMod(exportGamePath);
                try
                {
                }
                catch (Exception e)
                {
                    Debug.Log(e.StackTrace);
                    Debug.LogError(e);
                    SystemSounds.Exclamation.Play();
                    EditorUtility.DisplayDialog("Error!", "An error occured while the tool is building the mod.\nCheck console for more detailed information.", "Dismiss");
                    throw new Exception("Failed to build bundles.");
                }
            });

            if (doDeploy) Announce();
            else EditorApplication.Beep();
        }
    }
#endif
}