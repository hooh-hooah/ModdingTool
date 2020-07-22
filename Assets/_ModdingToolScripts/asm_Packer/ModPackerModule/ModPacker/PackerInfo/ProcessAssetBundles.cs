using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using JetBrains.Annotations;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule
{
    public static partial class ModPacker
    {
        public partial class ModPackInfo
        {
            private IEnumerable<string> GetFilesFromPath(string assetPath, string regex = null)
            {
                if (assetPath == null || assetPath.Length <= 0) return null;
                var regexObject = regex != null ? new Regex(regex) : null;
                var searchPath = Path.Combine(Directory.GetCurrentDirectory(), _modRootPath, assetPath);
                return Directory.GetFiles(searchPath)
                    .Where(x => !x.EndsWith(".meta") && (!regexObject?.IsMatch(assetPath) ?? true))
                    .Select(x => Path.Combine(assetPath, Path.GetFileName(x)).Replace("\\", "/"))
                    .OrderBy(x => x);
            }

            // Resolve Dependency of the core assets and pack those assets into various dependency AssetBundles
            // to save space and memory for the game and users.
            private void SplitBundleIntoModules()
            {
                var index = 0;
                foreach (var group in AssetBundleList
                    .SelectMany(bundle =>
                        {
                            var parentAssets = bundle.assetNames.ToDictionary(x => x);
                            return bundle.assetNames
                                .SelectMany(asset =>
                                    AssetDatabase.GetDependencies(asset)
                                        .Where(assetName => !parentAssets.ContainsKey(assetName)) // it should stay where it belongs.
                                        .Select(dependantAsset =>
                                            new DependantAsset(
                                                dependantAsset,
                                                Path.GetDirectoryName(dependantAsset)
                                            )
                                        )
                                );
                        }
                    )
                    .Where(x => TextureExtenstion.IsMatch(x.DependentAssetName))
                    .GroupBy(x => x.DependentBundleGroup))
                {
                    index += 1;
                    var bundleName = $"{DependencyManifest}_dependency_bundle_{index:D5}.unity3d";
                    if (!string.IsNullOrEmpty(_dependencyPath)) bundleName = Path
                        .Combine(_dependencyPath, bundleName)
                        .Replace("\\", "/");

                    AssetBundleList.Add(new AssetBundleBuild
                    {
                        assetBundleName = bundleName,
                        assetNames = group.Select(x => x.DependentAssetName).Distinct().ToArray()
                    });
                }
            }

            private string ValidatePath(string targetPath)
            {
                var result = Path.Combine(_modRootPath, targetPath).Replace("\\", "/");
                if (!string.IsNullOrEmpty(AssetDatabase.AssetPathToGUID(result))) return result;

                Debug.LogError("Mod Packer was not able to find following asset from folder.");
                Debug.LogError($">> {result}");
                throw new Exception("Mod Packer was not able to find specified asset from folder.");
            }

            // Remove all the memes on the name to group them properly.
            private string SanitizeNameForGrouping(string assetName)
            {
                return _removeNumberRegex.Replace(
                    _removeStateRegex.Replace(
                        Path.GetFileNameWithoutExtension(assetName), Empty)
                    , Empty);
            }

            private void RegisterAssetBundle(string name, string asset)
            {
                if (asset == null) throw new Exception("Invalid Path Name in <asset>");
                RegisterAssetBundle(name, new[] {asset});
            }

            private void RegisterAssetBundle(string name, [NotNull] string[] bundles)
            {
                if (bundles == null) throw new ArgumentNullException(nameof(bundles));
                AssetBundleList.Add(new AssetBundleBuild
                {
                    assetBundleName = name,
                    assetNames = bundles.Select(ValidatePath).ToArray()
                });
            }


            private void ResolveAssetGroups(XElement folder, string bundleName)
            {
                var folderSequence = 0;
                // well shit fuck me up, i value easy to develop for meme tools.
                // first, group by sanitized name format.
                var groups = GetFilesFromPath(folder.Attribute("from")?.Value, folder.Attribute("filter")?.Value)
                    .Select(ValidatePath)
                    .GroupBy(SanitizeNameForGrouping)
                    .Select(x => x.ToArray())
                    .ToArray();

                // and re-group single-file bundles (I don't like them)
                // single-file bundle group merge size should be customizable mostly.
                const float groupSize = (float) 5;
                var groupIndex = 0;
                var mergedSingularBundle = groups
                    .Where(x => x.Length <= 1)
                    .SelectMany(x => x)
                    .GroupBy(x => Math.Floor(groupIndex++ / groupSize))
                    .Select(x => x.ToArray())
                    .ToArray();

                // group by assets.
                foreach (var bundleGroup in groups.Where(x => x.Length > 1).Concat(mergedSingularBundle))
                {
                    AssetBundleList.Add(
                        new AssetBundleBuild
                        {
                            assetBundleName = bundleName.Replace("*", $"{folderSequence:D4}"),
                            assetNames = bundleGroup.ToArray()
                        });
                    folderSequence++;
                }
            }

            private void ProcessAssetBundleTargets(XDocument documentInfo)
            {
                if (documentInfo.Root == null) return;
                var bundlesObject = documentInfo.Root.Element("bundles");
                AssetBundleList = new List<AssetBundleBuild>();
                if (bundlesObject == null) return;

                foreach (var bundle in bundlesObject.Elements("bundle"))
                    AssetBundleList.Add(
                        new AssetBundleBuild
                        {
                            assetBundleName = bundle.Attribute("path")?.Value,
                            assetNames = bundle.Elements("asset")
                                .Select(asset => ValidatePath(asset.Attribute("path")?.Value))
                                .ToArray()
                        });

                foreach (var folder in bundlesObject.Elements("folder"))
                {
                    var useGroup = folder.Attribute("grouped");
                    var bundleName = folder.Attribute("path")?.Value;
                    if (bundleName == null) continue;

                    if (useGroup != null) ResolveAssetGroups(folder, bundleName);
                    else
                    {
                        AssetBundleList.Add(
                            new AssetBundleBuild
                            {
                                assetBundleName = bundleName,
                                assetNames = GetFilesFromPath(folder.Attribute("from")?.Value, folder.Attribute("filter")?.Value)
                                    .Select(ValidatePath)
                                    .ToArray()
                            });
                    }
                }

                foreach (var each in bundlesObject.Elements("each"))
                {
                    var eachSequence = 0;
                    var bundleName = each.Attribute("path")?.Value;
                    var from = each.Attribute("from")?.Value;
                    if (bundleName == null) continue;

                    foreach (var file in GetFilesFromPath(from, each.Attribute("filter")?.Value))
                    {
                        RegisterAssetBundle(bundleName.Replace("*", $"{eachSequence:D4}"), file);
                        eachSequence++;
                    }
                }
            }


            // public static Regex textureGroupReplace = new Regex(@"_()", RegexOptions.IgnoreCase); 
            private readonly struct DependantAsset
            {
                public readonly string DependentAssetName;
                public readonly string DependentBundleGroup;

                public DependantAsset(string dependentAssetName, string dependentBundleGroup)
                {
                    DependentAssetName = dependentAssetName;
                    DependentBundleGroup = dependentBundleGroup;
                }
            }
        }
    }
}