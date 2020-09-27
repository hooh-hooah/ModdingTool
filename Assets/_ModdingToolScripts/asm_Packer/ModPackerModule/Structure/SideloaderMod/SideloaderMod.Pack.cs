using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Xml;
using hooh_ModdingTool.asm_Packer.Utility;
using ModPackerModule.Structure.BundleData;
using ModPackerModule.Structure.DynamicGenerator;
using ModPackerModule.Structure.SideloaderMod.Data;
using ModPackerModule.Utility;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod
{
    // This file will only contain making class into zipmod file
    public partial class SideloaderMod
    {
        private const bool CleanTempFolderAfterBuild = true;
        private string ManifestAssetFolder => Path.Combine(Constants.PathBundleCache, DependencyData.ManifestName).ToUnixPath();

        public void SwapMaterials()
        {
        }


        // Resolve Dependency of the core assets and pack those assets into various dependency AssetBundles
        // to save space and memory for the game and users.
        private IEnumerable<AssetBundleBuild> SplitBundleIntoModules(IEnumerable<AssetBundleBuild> builds)
        {
            // TODO:
            // Causes major overhead. 
            // Requires better method.

            var index = 0;
            var result = new List<AssetBundleBuild>();
            foreach (var group in builds
                .SelectMany(bundle =>
                    {
                        var parentAssets = bundle.assetNames.ToDictionary(x => x);
                        return bundle.assetNames
                            .SelectMany(asset =>
                                AssetDatabase.GetDependencies(asset)
                                    .Where(assetName => !parentAssets.ContainsKey(assetName)) // it should stay where it belongs.
                                    .Select(dependantAsset => (Asset: dependantAsset, Group: Path.GetDirectoryName(dependantAsset)))
                            );
                    }
                )
                .Where(tuple => Constants.RegexTextureExtension.IsMatch(tuple.Asset))
                .GroupBy(tuple => tuple.Group))
            {
                index += 1;
                var bundlePath = $"{DependencyData.ManifestName}_dependency_bundle_{index:D5}.unity3d";
                bundlePath = Path.Combine(DependencyData.Path, bundlePath).ToUnixPath(); // Dependency Data's value is ensured.

                Assets.InsertDependencyBundle(bundlePath);
                result.Add(new AssetBundleBuild
                {
                    assetBundleName = bundlePath,
                    assetNames = group.Select(x => x.Asset).Distinct().ToArray()
                });
            }

            return result;
        }

        protected void ScaryLog(string spooky)
        {
            Debug.Log($"<b><color=red>{spooky}</color></b>");
        }

        private bool BuildAssetBundles(bool isDryRun = false)
        {
            if (BuildPipeline.isBuildingPlayer) return false;

            if (EditorApplication.isCompiling) return false;

            var buildList = GetAssetBundleBuilds();
            if (buildList.Count <= 0) return false;
            if (DependencyData.ManifestName != "abdata")
                buildList.AddRange(SplitBundleIntoModules(buildList));

            Directory.CreateDirectory(ManifestAssetFolder);

            var result = BuildPipeline.BuildAssetBundles(
                ManifestAssetFolder,
                buildList.ToArray(),
                isDryRun
                    ? BuildAssetBundleOptions.StrictMode | BuildAssetBundleOptions.DryRunBuild
                    : BuildAssetBundleOptions.ChunkBasedCompression | BuildAssetBundleOptions.StrictMode,
                BuildTarget.StandaloneWindows64);

            return result != null;
        }

        private string GetSplitTargetName(string target)
        {
            return AssetInfo.BundleTargetDefault.Equals(target) ? _outputFileName : _outputFileName + "_" + target;
        }

        private string TempZipFolder(string target)
        {
            return Path.Combine(Constants.PathTempFolder, GetSplitTargetName(target)).ToUnixPath();
        }

        private static string TempPath(string targetFolder, string path)
        {
            return Path.Combine(targetFolder, path).ToUnixPath();
        }

        private void SetupFolder(string targetPath, bool isDryRun = false)
        {
            foreach (var targetName in Assets.GetTargetBundles)
            {
                var isMainArchive = targetName == AssetInfo.BundleTargetDefault;

                var targetBundles = Assets.GetBundlesOfTarget(targetName);
                var targetFolder = TempZipFolder(targetName);

                if (Directory.Exists(targetFolder)) Directory.Delete(targetFolder, true);
                Directory.CreateDirectory(targetFolder);

                var sb = new StringBuilder();
                var settings = new XmlWriterSettings
                {
                    Indent = true,
                    OmitXmlDeclaration = true,
                    IndentChars = "    ",
                    NewLineChars = "\n",
                    NewLineHandling = NewLineHandling.Replace
                };
                using (var writer = XmlWriter.Create(sb, settings))
                {
                    if (isMainArchive)
                    {
                        _outputDocumentObject.Save(writer);
                    }
                    else
                    {
                        var info = XmlUtils.GetManifestTemplate();
                        MainData.SaveData(ref info);
                        info.Root?.Element("guid")?.SetValue(MainData.Guid + "." + targetName.SanitizeNonCharacters("."));
                        info.Root?.Element("name")?.SetValue(MainData.Name + " " + targetName.SanitizeNonCharacters("."));
                        info.Save(writer);
                    }
                }

                File.WriteAllText(TempPath(targetFolder, "manifest.xml"), sb.ToString());

                if (!isDryRun)
                {
                    // Make temporary
                    void Copy(string name, string extension = "")
                    {
                        var from = Path.Combine(ManifestAssetFolder, name);
                        var to = Path.Combine(targetFolder, "abdata", name + extension);
                        Directory.CreateDirectory(Path.GetDirectoryName(to).ToUnixPath());
                        File.Copy(from, to);
                    }

                    // Copy Bundle
                    foreach (var bundle in targetBundles) Copy(bundle);

                    // Copy manifest bundle if it's available
                    if (DependencyData.UseDependency && isMainArchive) Copy(DependencyData.ManifestName, ".unity3d");

                    // copy target files
                    foreach (var target in GetCopyTargets(targetName))
                        target.Copy(AssetDirectory, targetFolder);
                }

                if (_gameItems.TryGetValue(targetName, out var gameInfo))
                    gameInfo.WriteCsvFiles(targetFolder, MainData.Separator);
            }
        }

        private void Deploy(string targetPath)
        {
            try
            {
                var progressMAX = Assets.GetTargetBundles.Count;
                var progressDone = 0;

                void Progress()
                {
                    EditorUtility.DisplayProgressBar("Compressing...", "Compressing and deploying zipmod", progressDone / (float) progressMAX);
                }

                Progress();
                foreach (var targetName in Assets.GetTargetBundles)
                {
                    var targetFolder = TempZipFolder(targetName);
                    var targetModFileName = GetSplitTargetName(targetName);
                    if (targetModFileName.IsNullOrEmpty()) throw new Exception("Output file name cannot be empty.");

                    // Props to 2155X for giving me new multi-platform method!
                    var from = targetFolder;
                    var to = Path.Combine(targetPath, $"{targetModFileName}.zipmod").ToUnixPath();
                    if (File.Exists(to)) File.Delete(to);

                    CompressUtils.CreateFromDirectory(from, to);
                    if (CleanTempFolderAfterBuild) Directory.Delete(from, true);

                    Debug.Log($"Successfully packaged mod {targetModFileName}.zipmod!");
                    progressDone++;
                    Progress();
                }
            }
            catch (Exception)
            {
                EditorUtility.ClearProgressBar();
                throw;
            }
        }


        private void GenerateDynamicItems()
        {
            // TODO: i really need to stop making program when i'm sleepy
            foreach (var pairs in GameMapInfo.MapEvents)
            {
                var mapInfo = pairs.Key;
                var events = pairs.Value;
                var names = mapInfo.ReflectField<List<string>>("MapNames");
                var mapId = mapInfo.ReflectField("No", -1);

                _bundleTargets.Add(
                    new AssetList(this, $"adv/eventcg/{mapId}.unity3d", null)
                        .AddAsset(
                            events
                                .Where(x => x > 0)
                                .Select(id => MapEvents.GenerateMapEvent(AssetFolder, names.Last(), id))
                                .Where(x => !x.IsNullOrEmpty())
                            , false)
                );
            }
        }

        public bool Build(string targetPath, bool isDryRun = false)
        {
            GenerateDynamicItems();
            if (BuildAssetBundles(isDryRun) == false) return false;
            // swap materials
            SetupFolder(targetPath, isDryRun);
            if (isDryRun)
            {
                Debug.Log("This Mod XML is Valid!");
                return true;
            }

            Deploy(targetPath);
            return true;
        }
    }
}