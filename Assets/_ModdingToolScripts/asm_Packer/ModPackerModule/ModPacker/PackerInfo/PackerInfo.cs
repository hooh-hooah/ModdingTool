using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using Common;
using UnityEditor;
using UnityEditor.VersionControl;
using UnityEngine;

namespace ModPackerModule
{
    public static partial class ModPacker
    {
        public partial class ModPackInfo
        {
            private const string Empty = ""; // ???
            private const string BundleCacheName = "_BundleCache";
            public static readonly string BundleCachePath = Path.Combine(Directory.GetCurrentDirectory(), BundleCacheName).Replace("\\", "/");
            public static readonly string AiBundlePath = Path.Combine(Directory.GetCurrentDirectory(), "_AIResources").Replace("\\", "/");
            private static readonly string TempFolder = Path.Combine(Directory.GetCurrentDirectory(), "_Temporary").Replace("\\", "/");
            private static readonly Regex TextureExtenstion = new Regex(@"png|tif|jpg|tga|psd", RegexOptions.IgnoreCase);
            private readonly CSVBuilder[] _builders;

            private readonly ManifestBuilder _manifestBuilder;
            private readonly string _modRootPath;

            private readonly Regex _removeNumberRegex = new Regex("([0-9 _\t])");
            private readonly Regex _removeStateRegex = new Regex("(_on|_off)", RegexOptions.IgnoreCase);
            private readonly SBUScriptBuilder _sbuScriptBuilder;
            private readonly string _fileName;
            private Dictionary<string, string>[] _matswapTargets;
            public List<AssetBundleBuild> AssetBundleList;

            public string DependencyManifest => _dependencyEnabled
                ? string.IsNullOrEmpty(_dependencyManifest) ||
                  string.IsNullOrWhiteSpace(_dependencyManifest)
                    ? _fileName
                    : _dependencyManifest
                : "abdata";

            public ModPackInfo(XDocument documentInfo, string path)
            {
                _modRootPath = Path.GetDirectoryName(path);

                if (documentInfo.Root != null)
                {
                    #region Process Bundler Option

                    ParseOption(documentInfo.Root?.Element("options"));

                    #endregion

                    #region Process Asset Bundle Targets

                    ProcessAssetBundleTargets(documentInfo);

                    #endregion

                    #region Build Material Swap Script

                    if (documentInfo.Root.Element("matswap") != null)
                        _sbuScriptBuilder = new SBUScriptBuilder(documentInfo.Root.Element("matswap"));

                    #endregion

                    #region Build Manifest Buffer

                    _fileName = Utility.EscapePath(documentInfo.Root.Element("build")?.Attribute("name")?.Value);
                    _manifestBuilder = new ManifestBuilder(documentInfo) {Hs2Support = _hs2Support};
                    if (_hs2Support)
                    {
                        _manifestBuilder.Hs2Manifest = DependencyManifest;
                        _manifestBuilder.Hs2Manifests = AssetBundleList.Select(x =>
                        {
                            return new object[]
                            {
                                x.assetBundleName,
                                x.assetNames
                                    .Where(name => name.EndsWith(".unity"))
                                    .Select(Path.GetFileNameWithoutExtension)
                                    .Where(name => name.Contains("_hs"))
                                    .ToArray()
                            };
                        }).ToList();
                    }

                    // everything should be independent - so it could be bit inefficient.
                    // i know better solution but i don't have time for that for now.

                    #endregion

                    #region Build CSV Buffer

                    var buildLists = documentInfo.Root.Element("build")?.Elements("list");
                    var buildListArray = buildLists as XElement[] ?? (buildLists ?? throw new NullReferenceException()).ToArray();
                    _builders = new CSVBuilder[buildListArray.Length];
                    var csvIndex = 0;
                    foreach (var list in buildListArray)
                    {
                        var type = list.Attribute("type")?.Value;

                        if (CSVBuilder.listTypeInfo.ContainsKey(type ?? throw new NullReferenceException()))
                        {
                            if (CSVBuilder.listTypeInfo[type].isStudioMod)
                                _builders[csvIndex] = new CSVBuilder(type, list.Attribute("path")?.Value, this);
                            else
                                _builders[csvIndex] = new CSVBuilder(type, this);
                        }
                        else
                        {
                            Debug.LogError($"Type \"{type}\" is an invalid list category.");
                        }

                        _builders[csvIndex].Generate(list.Elements("item"));
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


            // Build AssetBundles for the game.
            public void BuildAssetBundles()
            {
                if (_dependencyEnabled) SplitBundleIntoModules();

                var manifestDirectory = Path.Combine(BundleCacheName, DependencyManifest);
                Directory.CreateDirectory(manifestDirectory);

                var result = BuildPipeline.BuildAssetBundles(manifestDirectory, AssetBundleList.ToArray(),
                    BuildAssetBundleOptions.ChunkBasedCompression,
                    BuildTarget.StandaloneWindows64);

                if (!result)
                    throw new Exception("Failed to pack asset bundle.");
            }
        }
    }
}