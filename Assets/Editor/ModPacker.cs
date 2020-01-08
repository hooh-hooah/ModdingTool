using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.IO.Compression;
using System.Linq;
using System.Media;
using System.Reflection;
using System.Text;
using System.Xml;
using System.Xml.Linq;
using UnityEditor;
using Debug = UnityEngine.Debug;

public class ModPacker {
    public static string SB3UtilityPath = Path.Combine(Directory.GetCurrentDirectory(), "External\\sb3\\SB3UtilityScript").Replace("\\", "/");

    public static void Announce(bool isSuccess = true, string message = "Please check the console the see error.") {
        if (isSuccess) {
            EditorApplication.Beep();
            if (EditorUtility.DisplayDialog("Alert", "Build Successful!", "Open Folder", "Okay")) {
                if (Directory.Exists(HoohTools.gameExportPath)) {
                    Process process = new Process();
                    ProcessStartInfo startInfo = new ProcessStartInfo();
                    startInfo.WindowStyle = ProcessWindowStyle.Hidden;
                    startInfo.FileName = "cmd.exe";
                    startInfo.Arguments = string.Format("/C start explorer.exe {0}", HoohTools.gameExportPath);
                    process.StartInfo = startInfo;
                    process.Start();
                }
            }
        } else {
            EditorUtility.DisplayDialog("FAILED!", message, "Dismiss");
        }
    }

    public static string GetProjectPath() {
        try {
            var projectBrowserType = Type.GetType("UnityEditor.ProjectBrowser,UnityEditor");
            var projectBrowser = projectBrowserType.GetField("s_LastInteractedProjectBrowser", BindingFlags.Static | BindingFlags.Public).GetValue(null);
            var invokeMethod = projectBrowserType.GetMethod("GetActiveFolderPath", BindingFlags.NonPublic | BindingFlags.Instance);
            return (string)invokeMethod.Invoke(projectBrowser, new object[] { });
        } catch (Exception exception) {
            Debug.LogWarning("Error while trying to get current project path.");
            Debug.LogWarning(exception.Message);
            return string.Empty;
        }
    }

    public static XDocument ParseModXML(string path) {
        try {
            if (File.Exists(path)) {
                XmlDocument modDocument = new XmlDocument();
                modDocument.Load(path);
                return XDocument.Parse(modDocument.OuterXml);
            }
        } catch (Exception e) {
            Debug.LogWarning(e);
        }
        return null;
    }

    public static void PackMod(string exportGamePath) {
        string assetPackageInfo = Path.Combine(Path.Combine(Directory.GetCurrentDirectory(), GetProjectPath()), "mod.xml").Replace("\\", "/");

        // TODO: get target output shits?
        Debug.Log(assetPackageInfo);
        XDocument parsedModInfo = ParseModXML(assetPackageInfo);

        if (!File.Exists(assetPackageInfo)) {
            EditorUtility.DisplayDialog("Error!", "The folder does not have 'mod.xml' file!", "Dismiss");
            return;
        }

        if (parsedModInfo != null) {
            if (parsedModInfo.Root.Attribute("type") == null) {
                Debug.LogError("mod.xml does not have type information!");
                return;
            }

            try {
                ModPackInfo modInfo = new ModPackInfo(parsedModInfo);
                modInfo.BuildAssetBundles();
                modInfo.SwapMaterial();
                modInfo.SetupModFolder();
                modInfo.DeployZipMod(exportGamePath);
                Announce();
            } catch (Exception e) {
                Debug.LogError(e);
                SystemSounds.Exclamation.Play();
                EditorUtility.DisplayDialog("Error!", "Failed to build mod!\nCheck the Console!", "Dismiss");
            }
        } else {
            Debug.LogError("Failed to parse mod information.");
        }
    }

    public class ModPackInfo {
        public static string bundleCacheName = "_BundleCache/abdata";
        public static string bundleCachePath = Path.Combine(Directory.GetCurrentDirectory(), bundleCacheName).Replace("\\", "/");
        public static string aiBundlePath = Path.Combine(Directory.GetCurrentDirectory(), "_AIResources").Replace("\\", "/");
        public static string tempFolder = Path.Combine(Directory.GetCurrentDirectory(), "_Temporary").Replace("\\", "/");

        public CSVBuilder[] csvBuilders;
        public string[] assetBundleNames = null;
        public string[][] assetNames = null;
        CSVBuilder[] builders;
        Dictionary<string, string>[] matswapTargets;
        Dictionary<string, string> modFolderInfo = new Dictionary<string, string>();
        SBUScriptBuilder sbuScriptBuilder;
        ManifestBuilder manifestBuilder;
        string fileName;

        public void SwapMaterial() {
            if (sbuScriptBuilder != null) {
                sbuScriptBuilder.Execute();
            }
        }

        public void SetupModFolder() {
            string zipPath = Path.Combine(tempFolder, fileName).Replace("\\", "/");
            try {
                DirectoryInfo info = new DirectoryInfo(zipPath);
                foreach (var subDirectory in info.GetDirectories())
                    subDirectory.Delete(true);
            } catch (DirectoryNotFoundException e) {
                // creating new folder.
            } catch (Exception e) {
                Debug.Log(e);
            } finally {
                Directory.CreateDirectory(zipPath);
            }

            File.WriteAllText(Path.Combine(zipPath, "manifest.xml").Replace("\\", "/"), manifestBuilder.Generate());

            for (int i = 0; i < assetBundleNames.Length; i++) {
                string source = Path.Combine(bundleCachePath, assetBundleNames[i]).Replace("\\", "/");
                string dest = Path.Combine(zipPath, "abdata\\" + assetBundleNames[i]).Replace("\\", "/");

                Directory.CreateDirectory(Path.Combine(
                    zipPath,
                    Path.GetDirectoryName("abdata\\" + assetBundleNames[i])
                ).Replace("\\", "/"));
                File.Copy(source, dest);
            }

            foreach (CSVBuilder builder in csvBuilders) {
                string path = "";
                if (builder.valid) {
                    if (builder.listPath != null)
                        path = Path.Combine(zipPath, builder.listPath).Replace("\\", "/");
                    else
                        path = Path.Combine(zipPath, builder.typeInfo.listPath).Replace("\\", "/");
                } else
                    continue;

                Directory.CreateDirectory(Path.GetDirectoryName(path));
                File.WriteAllText(path, builder.buffer);
            }
        }

        public void DeployZipMod(string targetpath) {
            // TODO: Make it modular.
            string srcPath = Path.Combine(tempFolder, Path.Combine(fileName, "*")).Replace("\\", "/");
            string extPath = Path.Combine(targetpath, fileName + ".zipmod").Replace("\\", "/");
            string zipExec = Path.Combine(Directory.GetCurrentDirectory(), "_External\\7za.exe").Replace("\\", "/");

            Process p = new Process();
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.FileName = zipExec;
            p.StartInfo.Arguments = $"a -tzip -aoa -w{System.Environment.GetEnvironmentVariable("TEMP")} \"{extPath}\" \"{srcPath}\"";
            p.Start();
            p.WaitForExit();
            if (p.ExitCode != 0)
                throw new Exception("Failed to make zip file.");
        }

        public void BuildAssetBundles() {
            AssetBundleBuild[] assetBuildList = new AssetBundleBuild[assetBundleNames.Count()];

            for (int i = 0; i < assetBuildList.Count(); i++) {
                assetBuildList[i].assetBundleName = assetBundleNames[i];
                assetBuildList[i].assetNames = assetNames[i];
            }

            BuildPipeline.BuildAssetBundles(bundleCacheName, assetBuildList, BuildAssetBundleOptions.None, BuildTarget.StandaloneWindows64);
        }

        public ModPackInfo(XDocument documentInfo) {
            string currentDirectory = GetProjectPath().Replace("/", "\\");

            if (documentInfo != null) {
                #region Build AssetBundle Target Array
                IEnumerable<XElement> bundleTargets = documentInfo.Root.Element("bundles").Elements("bundle");
                assetBundleNames = new string[bundleTargets.Count()];
                assetNames = new string[bundleTargets.Count()][];

                int index = 0; // lmao

                foreach (var bundle in bundleTargets) {
                    IEnumerable<XElement> assets = bundle.Elements("asset");
                    int assetIndex = 0;

                    string[] assetArray = new string[assets.Count()];
                    foreach (var asset in assets) {
                        assetArray[assetIndex] = Path.Combine(currentDirectory, asset.Attribute("path").Value).Replace("\\", "/");
                        assetIndex++;
                    }

                    assetBundleNames[index] = bundle.Attribute("path").Value;
                    assetNames[index] = assetArray;

                    index++;
                }
                #endregion
                #region Build Material Swap Script
                if (documentInfo.Root.Element("matswap") != null) 
                    sbuScriptBuilder = new SBUScriptBuilder(documentInfo.Root.Element("matswap"));
                #endregion
                #region Build Manifest Buffer
                fileName = documentInfo.Root.Element("build").Attribute("name").Value;
                manifestBuilder = new ManifestBuilder(documentInfo);
                #endregion
                #region Build CSV Buffer
                IEnumerable<XElement> buildLists = documentInfo.Root.Element("build").Elements("list");
                csvBuilders = new CSVBuilder[buildLists.Count()];
                int csvIndex = 0;
                foreach (var list in buildLists) {
                    string type = list.Attribute("type").Value;

                    if (CSVBuilder.listTypeInfo.ContainsKey(type)) {
                        if (CSVBuilder.listTypeInfo[type].isStudioMod)
                            csvBuilders[csvIndex] = new CSVBuilder(type, list.Attribute("path").Value, this);
                        else
                            csvBuilders[csvIndex] = new CSVBuilder(type, this);
                    } else {
                        Debug.LogError(string.Format("Type \"{0}\" is an invalid list category.", type));
                    }

                    csvBuilders[csvIndex].Generate(list.Elements("item"));
                    csvIndex++;
                }
                #endregion
            } else {
                Debug.LogError("Invalid XML Document.");
            }
        }
    }
}