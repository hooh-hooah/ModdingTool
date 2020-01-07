using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Xml;
using System.Xml.Linq;
using UnityEditor;
using Debug = UnityEngine.Debug;

public class ModPacker {
    public static string SB3UtilityPath = Path.Combine(Directory.GetCurrentDirectory(), "External\\sb3\\SB3UtilityScript").Replace("\\", "/");

    public static void Announce(bool isSuccess = true, string message = "Please check the console the see error.") {
        if (isSuccess)
            EditorUtility.DisplayDialog("SUCCESS!", "Successfully Built Mod!", "Dismiss");
        else
            EditorUtility.DisplayDialog("FAILED!", message, "Dismiss");
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

        if (parsedModInfo != null) {
            if (parsedModInfo.Root.Attribute("type") == null) {
                Debug.LogError("mod.xml does not have type information!");
                return;
            }

            try {
                ModPackInfo modInfo = new ModPackInfo(parsedModInfo);
                modInfo.BuildAssetBundles();
                modInfo.HairSwapMaterial();
                modInfo.SetupModFolder();
                modInfo.DeployZipMod(exportGamePath);
                Announce();
            } catch (Exception e) {
                Debug.LogError(e);
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
        private CSVBuilder[] builders;
        private Dictionary<string, string>[] matswapTargets;

        public void HairSwapMaterial() {
            if (matswapTargets != null) {
                for (int i = 0; i < matswapTargets.Length; i++) {
                    ScriptBuilder builder = new ScriptBuilder();
                    builder.SetupHairSwapScript(matswapTargets[i]);
                    builder.Execute();
                    builder.CleanUp();
                }
            }
        }

        private Dictionary<string, string> modFolderInfo = new Dictionary<string, string>();

        public void SetupModFolder() {
            string zipPath = Path.Combine(tempFolder, modFolderInfo["modname"]).Replace("\\", "/");
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

            // I know this shit is wack
            // Initialize manifest.xml
            string manifestText = "<manifest schema-ver=\"1\">\n";
            manifestText += string.Format("\t<guid>{0}</guid>\n", modFolderInfo["guid"]);
            manifestText += string.Format("\t<name>{0}</name>\n", modFolderInfo["name"]);
            manifestText += string.Format("\t<version>{0}</version>\n", modFolderInfo["version"]);
            manifestText += string.Format("\t<author>{0}</author>\n", modFolderInfo["author"]);
            manifestText += string.Format("\t<description>{0}</description>\n", modFolderInfo["description"]);
            manifestText += "</manifest>";
            File.WriteAllText(Path.Combine(zipPath, "manifest.xml").Replace("\\", "/"), manifestText);

            // Copy shits from folder.
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
            string zipPath = Path.Combine(tempFolder, modFolderInfo["modname"]).Replace("\\", "/");
            Process p = new Process();
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.FileName = "C:\\Program Files\\Bandizip\\Bandizip.exe";
            p.StartInfo.Arguments = string.Format("c -y \"{0}\" \"{1}\"", Path.Combine(targetpath, modFolderInfo["modname"] + ".zipmod").Replace("\\", "/"), zipPath);
            p.Start();
            p.WaitForExit();
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
                // Setup Asset Bundle Informations
                {
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
                }

                // Setup Material Swap
                if (documentInfo.Root.Element("matswap") != null) {
                    IEnumerable<XElement> swapTargets = documentInfo.Root.Element("matswap").Elements("target");
                    matswapTargets = new Dictionary<string, string>[swapTargets.Count()];

                    int index = 0;
                    foreach (var target in swapTargets) {
                        matswapTargets[index] = new Dictionary<string, string>();

                        matswapTargets[index].Add("mesh-bundle", Path.Combine(bundleCachePath, target.Attribute("mesh-bundle").Value).Replace("\\", "/"));
                        matswapTargets[index].Add("tex-bundle", Path.Combine(bundleCachePath, target.Attribute("tex-bundle").Value).Replace("\\", "/"));
                        matswapTargets[index].Add("mat-bundle", Path.Combine(aiBundlePath, target.Attribute("mat-bundle").Value).Replace("\\", "/"));
                        matswapTargets[index].Add("mesh-object", target.Attribute("mesh-object").Value);
                        matswapTargets[index].Add("mat-name", target.Attribute("mat-name").Value);

                        IEnumerable<XElement> slots = target.Elements("texture");
                        foreach (var slot in slots)
                            matswapTargets[index].Add(slot.Attribute("slot").Value, slot.Attribute("tex-name").Value);

                        IEnumerable<XElement> parms = target.Elements("matvalue");
                        foreach (var param in parms)
                            matswapTargets[index].Add(param.Attribute("slot").Value, param.Attribute("value").Value);

                        index++;
                    }
                }

                // Setup Mod Informations.
                {
                    modFolderInfo.Add("modname", documentInfo.Root.Element("build").Attribute("name").Value);
                    modFolderInfo.Add("guid", documentInfo.Root.Element("guid").Value);
                    modFolderInfo.Add("name", documentInfo.Root.Element("name").Value);
                    modFolderInfo.Add("version", documentInfo.Root.Element("version").Value);
                    modFolderInfo.Add("author", documentInfo.Root.Element("author").Value);
                    modFolderInfo.Add("description", documentInfo.Root.Element("description").Value);

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
                }
            } else {
                Debug.LogError("Invalid XML Document.");
            }
        }
    }

    // This shit build script for SB3Utility.
    private class ScriptBuilder {
        private static string scriptTemplatePath = Path.Combine(Directory.GetCurrentDirectory(), "_SBTemplates").Replace("\\", "/");
        private static string runnerPath = Path.Combine(Directory.GetCurrentDirectory(), "_External\\sb3\\SB3UtilityScript.exe").Replace("\\", "/");
        private static string temporaryScriptPath = Path.Combine(Directory.GetCurrentDirectory(), "_Temporary\\__temp__.txt").Replace("\\", "/");
        public string buffer = "";

        public ScriptBuilder() {
        }

        public void SetupHairSwapScript(Dictionary<string, string> matswapInfo) {
            string templateString = File.ReadAllText(Path.Combine(scriptTemplatePath, "__material_swap.txt").Replace("\\", "/"));

            // Okay fuck nugget, I'll solve this issue later, so can you fuck off?
            templateString = templateString.Replace("@@PATH_MESH@@", Path.Combine(ModPackInfo.bundleCachePath, matswapInfo["mesh-bundle"].Replace("/", "\\")));
            templateString = templateString.Replace("@@PATH_TEX@@", Path.Combine(ModPackInfo.bundleCachePath, matswapInfo["tex-bundle"].Replace("/", "\\")));
            templateString = templateString.Replace("@@PATH_MAT@@", Path.Combine(ModPackInfo.bundleCachePath, matswapInfo["mat-bundle"].Replace("/", "\\")));
            templateString = templateString.Replace("@@TARGET_OBJECT@@", matswapInfo["mesh-object"]);
            templateString = templateString.Replace("@@TARGET_MATERIAL@@", matswapInfo["mat-name"]);
            templateString = templateString.Replace("@@TEX_NORMAL@@", matswapInfo["asset-normal"]);
            templateString = templateString.Replace("@@TEX_COLORMASK@@", matswapInfo["asset-colormask"]);
            templateString = templateString.Replace("@@TEX_NOISE@@", matswapInfo["asset-noise"]);
            templateString = templateString.Replace("@@TEX_DIFFUSE@@", matswapInfo["asset-diffuse"]);
            templateString = templateString.Replace("@@TEX_OCCLUSION@@", matswapInfo["asset-ao"]);

            templateString = templateString.Replace("@@DETAIL_STRENGTH@@", matswapInfo["mat-detail"]);

            File.WriteAllText(temporaryScriptPath, templateString);
        }

        public void Execute() {
            Process p = new Process();
            p.StartInfo.UseShellExecute = false;
            p.StartInfo.FileName = runnerPath;
            p.StartInfo.Arguments = temporaryScriptPath;
            p.Start();
            p.WaitForExit();
        }

        public void CleanUp() {
            File.Delete(temporaryScriptPath);
        }
    }
}