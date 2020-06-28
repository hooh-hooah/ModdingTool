#if UNITY_EDITOR
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Media;
using System.Reflection;
using System.Xml;
using System.Xml.Linq;
using UnityEditor;
using UnityEngine;
using Debug = UnityEngine.Debug;

public class ModPacker
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

    public static string GetProjectPath()
    {
        try
        {
            var projectBrowserType = Type.GetType("UnityEditor.ProjectBrowser,UnityEditor");
            var projectBrowser = projectBrowserType.GetField("s_LastInteractedProjectBrowser", BindingFlags.Static | BindingFlags.Public).GetValue(null);
            var invokeMethod = projectBrowserType.GetMethod("GetActiveFolderPath", BindingFlags.NonPublic | BindingFlags.Instance);
            return (string) invokeMethod.Invoke(projectBrowser, new object[] { });
        }
        catch (Exception exception)
        {
            Debug.LogWarning("Error while trying to get current project path.");
            Debug.LogWarning(exception.Message);
            return string.Empty;
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
        return Directory.GetFiles(GetProjectPath())
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

        foreach (var textAsset in assets)
        {
            var parsedModInfo = ParseModXML(textAsset);

            if (parsedModInfo != null)
            {
                try
                {
                    var modInfo = new ModPackInfo(parsedModInfo, AssetDatabase.GetAssetPath(textAsset));
                    modInfo.BuildAssetBundles();
                    modInfo.SwapMaterial();
                    modInfo.SetupModFolder();
                    if (doDeploy)
                    {
                        modInfo.DeployZipMod(exportGamePath);
                        Announce();
                    }
                    else
                    {
                        EditorApplication.Beep();
                    }
                }
                catch (Exception e)
                {
                    Debug.Log(e.StackTrace);
                    Debug.LogError(e);
                    SystemSounds.Exclamation.Play();
                    EditorUtility.DisplayDialog("Error!", "An error occured while the tool is building the mod.\nCheck console for more detailed information.", "Dismiss");
                    return;
                }
            }
            else
            {
                return;
            }
        }
    }

    public class ModPackInfo
    {
        public static string BundleCacheName = "_BundleCache/abdata";
        public static string BundleCachePath = Path.Combine(Directory.GetCurrentDirectory(), BundleCacheName).Replace("\\", "/");
        public static string AiBundlePath = Path.Combine(Directory.GetCurrentDirectory(), "_AIResources").Replace("\\", "/");
        public static string TempFolder = Path.Combine(Directory.GetCurrentDirectory(), "_Temporary").Replace("\\", "/");
        public string[] AssetBundleNames;
        public string[][] AssetNames;
        public CSVBuilder[] CsvBuilders;
        public string path;
        private readonly string _fileName;
        private readonly ManifestBuilder _manifestBuilder;
        private Dictionary<string, string>[] _matswapTargets;
        private readonly SBUScriptBuilder _sbuScriptBuilder;

        public ModPackInfo(XDocument documentInfo, string path)
        {
            this.path = System.IO.Path.GetDirectoryName(path);
            var currentDirectory = GetProjectPath().Replace("/", "\\");

            if (documentInfo != null)
            {
                #region Build AssetBundle Target Array

                var bundleTargets = documentInfo.Root.Element("bundles").Elements("bundle");
                AssetBundleNames = new string[bundleTargets.Count()];
                AssetNames = new string[bundleTargets.Count()][];

                var index = 0; // lmao

                foreach (var bundle in bundleTargets)
                {
                    var assets = bundle.Elements("asset");
                    var assetIndex = 0;

                    var assetArray = new string[assets.Count()];
                    foreach (var asset in assets)
                    {
                        assetArray[assetIndex] = Path.Combine(this.path, asset.Attribute("path").Value).Replace("\\", "/");
                        assetIndex++;
                    }

                    AssetBundleNames[index] = bundle.Attribute("path").Value;
                    AssetNames[index] = assetArray;

                    index++;
                }

                #endregion

                #region Build Material Swap Script

                if (documentInfo.Root.Element("matswap") != null)
                    _sbuScriptBuilder = new SBUScriptBuilder(documentInfo.Root.Element("matswap"));

                #endregion

                #region Build Manifest Buffer

                _fileName = documentInfo.Root.Element("build")?.Attribute("name")?.Value;
                _manifestBuilder = new ManifestBuilder(documentInfo);

                #endregion

                #region Build CSV Buffer

                var buildLists = documentInfo.Root.Element("build")?.Elements("list");
                CsvBuilders = new CSVBuilder[buildLists.Count()];
                var csvIndex = 0;
                foreach (var list in buildLists)
                {
                    var type = list.Attribute("type")?.Value;

                    if (CSVBuilder.listTypeInfo.ContainsKey(type))
                    {
                        if (CSVBuilder.listTypeInfo[type].isStudioMod)
                            CsvBuilders[csvIndex] = new CSVBuilder(type, list.Attribute("path")?.Value, this);
                        else
                            CsvBuilders[csvIndex] = new CSVBuilder(type, this);
                    }
                    else
                    {
                        Debug.LogError($"Type \"{type}\" is an invalid list category.");
                    }

                    CsvBuilders[csvIndex].Generate(list.Elements("item"));
                    csvIndex++;
                }

                #endregion
            }
            else
            {
                Debug.LogError("Invalid XML Document.");
            }
        }

        public void SwapMaterial()
        {
            _sbuScriptBuilder?.Execute();
        }

        public void SetupModFolder()
        {
            var zipPath = Path.Combine(TempFolder, _fileName).Replace("\\", "/");
            try {
                var info = new DirectoryInfo(zipPath);
                foreach (var subDirectory in info.GetDirectories())
                    subDirectory.Delete(true);
            }
            catch (DirectoryNotFoundException e) { }
            catch (Exception e){ Debug.Log(e); }
            finally { Directory.CreateDirectory(zipPath); }

            File.WriteAllText(Path.Combine(zipPath, "manifest.xml").Replace("\\", "/"), _manifestBuilder.Generate());

            foreach (var bundle in AssetBundleNames)
            {
                var source = Path.Combine(BundleCachePath, bundle).Replace("\\", "/");
                var dest = Path.Combine(zipPath, "abdata\\" + bundle).Replace("\\", "/");

                Directory.CreateDirectory(Path.Combine(
                    zipPath,
                    Path.GetDirectoryName("abdata\\" + bundle)
                ).Replace("\\", "/"));
                File.Copy(source, dest);
            }

            foreach (var builder in CsvBuilders)
            {
                var path = "";
                if (builder.valid)
                {
                    path = builder.listPath != null
                        ? Path.Combine(zipPath, builder.listPath).Replace("\\", "/")
                        : Path.Combine(zipPath, builder.typeInfo.listPath).Replace("\\", "/");
                }
                else
                {
                    continue;
                }

                Directory.CreateDirectory(Path.GetDirectoryName(path));
                File.WriteAllText(path, builder.buffer);
            }
        }

        public void DeployZipMod(string targetPath)
        {
            // TODO: Make it modular.
            var srcPath = Path.Combine(TempFolder, Path.Combine(_fileName, "*")).Replace("\\", "/");
            var extPath = Path.Combine(targetPath, _fileName + ".zipmod").Replace("\\", "/");
            var zipExec = Path.Combine(Directory.GetCurrentDirectory(), "_External\\7za.exe").Replace("\\", "/");

            var p = new Process
            {
                StartInfo =
                {
                    UseShellExecute = false, FileName = zipExec, Arguments = $"a -tzip -aoa -w{Environment.GetEnvironmentVariable("TEMP")} \"{extPath}\" \"{srcPath}\""
                }
            };
            p.Start();
            p.WaitForExit();
            if (p.ExitCode != 0)
                throw new Exception("Failed to make zip file. (" + p.ExitCode + ")");
        }

        public void BuildAssetBundles()
        {
            var assetBuildList = new AssetBundleBuild[AssetBundleNames.Count()];

            for (var i = 0; i < assetBuildList.Count(); i++)
            {
                assetBuildList[i].assetBundleName = AssetBundleNames[i];
                assetBuildList[i].assetNames = AssetNames[i];
                if (!AssetNames[i].Any(x => string.IsNullOrEmpty(AssetDatabase.AssetPathToGUID(x)))) continue;
          
                Debug.LogError("Mod Packer was not able to find following assets from folder.");
                foreach (var s in AssetNames[i].Where(x => string.IsNullOrEmpty(AssetDatabase.AssetPathToGUID(x))))
                    Debug.LogError($">> {s}");
                throw new Exception("Failed to pack asset bundle.");
            }

            var result = BuildPipeline.BuildAssetBundles(BundleCacheName, assetBuildList,
                BuildAssetBundleOptions.ChunkBasedCompression | BuildAssetBundleOptions.StrictMode,
                BuildTarget.StandaloneWindows64);
            
            if (!result)
                throw new Exception("Failed to pack asset bundle.");
        }
    }
}
#endif