using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using JetBrains.Annotations;
using ModPackerModule.Structure.BundleData;
using ModPackerModule.Structure.Classes.ManifestData;
using ModPackerModule.Structure.ListData;
using ModPackerModule.Structure.SideloaderMod.Data;
using ModPackerModule.Utility;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod
{
    [SuppressMessage("ReSharper", "UnusedMember.Global")]
    [SuppressMessage("ReSharper", "InconsistentNaming")]
    public enum TargetGame
    {
        HS = 0,
        PH = 1,
        KK = 2,
        AI = 3,
        HS2 = 4,
        KK2 = 5
    }

    public enum AssetType
    {
        Map,
        ScriptableObject,
        Animation,
        Prefab,
        Other
    }

    public struct Warnings
    {
        public bool Duplicate;
    }

    // Use this data to make new archive.
    public partial class SideloaderMod
    {
        private const string BundleTargetName = "bundles";
        private const string BuildTargetName = "build";
        private readonly Dictionary<string, int> _autoPathIndex = new Dictionary<string, int>();
        private readonly List<BundleBase> _bundleTargets;
        private readonly Dictionary<string, GameInfo> _gameItems;
        private readonly XDocument _inputDocumentObject;
        private readonly List<IManifestData> _manifestData;
        public readonly string AssetDirectory;
        public readonly string AssetFolder;
        public readonly DependencyLoaderData DependencyData;
        public readonly GameMapInfo GameMapInfo;
        public readonly MainData MainData;
        public readonly StudioInfo StudioInfo;
        private string _failedReason = "";

        // should i separate this?
        private XDocument _outputDocumentObject;
        private string _outputFileName;
        public AssetInfo Assets;
        public int IndexOffset = 0; // for sideloader local slots.
        public Warnings Warnings;

        // Generate root document when constructor is there.
        public SideloaderMod([NotNull] TextAsset file)
        {
            // check parse error
            var assetPath = AssetDatabase.GetAssetPath(file);
            AssetFolder = Path.GetDirectoryName(assetPath) ?? "";
            AssetDirectory = Path.Combine(Directory.GetCurrentDirectory(), AssetFolder).Replace("\\", "/");
            FileName = file.name;

            _outputDocumentObject = XmlUtils.GetManifestTemplate();
            _inputDocumentObject = XDocument.Parse(file.text);

            MainData = new MainData();
            DependencyData = new DependencyLoaderData();
            GameMapInfo = new GameMapInfo();
            StudioInfo = new StudioInfo();
            MainData.ParseData(this, _inputDocumentObject.Root);
            DependencyData.ParseData(this, _inputDocumentObject.Root);

            _manifestData = new List<IManifestData>
            {
                // it should be in order, lmk if there is good way to do. I'm always learning.
                MainData,
                DependencyData,
                new HeelsData(),
                new MaterialEditorData()
            };

            _bundleTargets = new List<BundleBase>();
            _gameItems = new Dictionary<string, GameInfo>();
            Assets = new AssetInfo();

            ParseDocument(_inputDocumentObject.Root);
        }

        private string FileName { get; }

        public void RememberAsset(string path, string bundle, string target)
        {
            var assetType = AssetInfo.GetAssetType(path);

            Assets.RememberAsset(assetType, path, bundle, target);

            switch (assetType)
            {
                case AssetType.ScriptableObject:
                    GameMapInfo.ParseMapAsset(path);
                    break;
                case AssetType.Map:
                    break;
                case AssetType.Animation:
                    break;
                case AssetType.Prefab:
                    break;
                case AssetType.Other:
                    break;
                default:
                    throw new ArgumentOutOfRangeException();
            }
        }

        public int GetAutoPathIndex(string key)
        {
            if (!_autoPathIndex.ContainsKey(key)) _autoPathIndex[key] = 0;
            return _autoPathIndex[key]++;
        }

        public bool IsValid()
        {
            var root = _inputDocumentObject.Root;
            if (ReferenceEquals(null, root))
            {
                _failedReason = "invalid document root.";
                return false;
            }

            if (ReferenceEquals(null, root.Element(BuildTargetName)))
            {
                _failedReason = "invalid build target element";
                return false;
            }

            if (!ReferenceEquals(null, root.Element(BundleTargetName))) return true;
            _failedReason = "invalid build target element";
            return false;
        }

        private void ParseDocument(in XElement rootNode)
        {
            if (!IsValid()) throw new InvalidDataException(_failedReason);
            ParseBundleTargets(rootNode?.Element(BundleTargetName)); // parse bundle data is done
            foreach (var target in _bundleTargets.Where(x => x.AutoPath)) target.ResolveAutoPath();
            ParseListData(rootNode?.Element(BuildTargetName)); // parse list data
            ParseManifest(rootNode);
            ValidateListData();
            if (_outputFileName.IsNullOrEmpty())
                _outputFileName = !MainData.UniqueId.IsNullOrEmpty() ? MainData.UniqueId : MainData.Guid.SanitizeNonCharacters();
        }

        private void ParseManifest(in XElement document)
        {
            foreach (var manifestData in _manifestData)
            {
                if (!(manifestData is DependencyLoaderData) && !(manifestData is MainData))
                    manifestData.ParseData(this, document);

                var (valid, reason) = manifestData.IsValid();
                if (valid) manifestData.SaveData(ref _outputDocumentObject);
                else throw new InvalidDataException(reason);
            }
        }

        private List<AssetBundleBuild> GetAssetBundleBuilds()
        {
            return _bundleTargets.SelectMany(target => target.Bundles).ToList();
        }

        private IEnumerable<CopyFiles> GetCopyTargets(string target = AssetInfo.BundleTargetDefault)
        {
            return _bundleTargets.OfType<CopyFiles>().Where(x => x.Target == target).ToArray();
        }

        private void ParseBundleTargets(in XElement document)
        {
            foreach (var element in document.Elements())
            {
                var name = element.Name.LocalName;
                switch (name)
                {
                    case "bundle":
                        _bundleTargets.Add(new AssetList(this, element).InitializeBundles(element));
                        break;
                    case "each":
                        _bundleTargets.Add(new EachBundles(this, element).InitializeBundles(element));
                        break;
                    case "folder":
                        _bundleTargets.Add(new FolderBundle(this, element).InitializeBundles(element));
                        break;
                    case "move":
                    case "copy":
                        _bundleTargets.Add(new CopyFiles(this, element).InitializeBundles(element));
                        break;
                }
            }
        }

        [SuppressMessage("ReSharper", "StringLiteralTypo")]
        private void RegisterItems(in XElement element, string type)
        {
            var target = element.Attr("target", AssetInfo.BundleTargetDefault);
            Assets.RememberTarget(target);
            var dictItemList = _gameItems.ContainsKey(target) ? _gameItems[target] : new GameInfo(target);

            foreach (var item in element.Elements("item"))
                switch (type)
                {
                    // TODO: bruh
                    case "anime":
                    case "animation":
                        dictItemList.Insert(typeof(ListAnimation), new ListAnimation(this, item));
                        break;
                    case "studioitem":
                    case "props":
                        dictItemList.Insert(typeof(ListStudioItem), new ListStudioItem(this, item));
                        break;
                    case "bigcategory":
                        dictItemList.Insert(typeof(ListIdBigCategory), new ListIdBigCategory(this, item));
                        break;
                    case "midcategory":
                        dictItemList.Insert(typeof(ListIdMidCategory), new ListIdMidCategory(this, item));
                        break;
                    case "animebigcategory":
                        dictItemList.Insert(typeof(ListIdBigAnimeCategory), new ListIdBigAnimeCategory(this, item));
                        break;
                    case "animemidcategory":
                        dictItemList.Insert(typeof(ListIdMidAnimeCategory), new ListIdMidAnimeCategory(this, item));
                        break;
                    case "map":
                    case "scene":
                        dictItemList.Insert(typeof(ListMap), new ListMap(this, item));
                        break;
                    case "hairback":
                    case "hairfront":
                    case "hairside":
                    case "hairext":
                        dictItemList.Insert(typeof(ListHair), new ListHair(this, item, type));
                        break;
                    case "accnone":
                    case "acchead":
                    case "accear":
                    case "accglasses":
                    case "accface":
                    case "accneck":
                    case "accshoulder":
                    case "accchest":
                    case "accwaist":
                    case "accback":
                    case "accarm":
                    case "acchand":
                    case "accleg":
                    case "acckokan":
                        dictItemList.Insert(typeof(ListAccessory), new ListAccessory(this, item, type));
                        break;
                    case "spattern":
                    case "sunderhair":
                    case "snip":
                    case "seye_hl":
                    case "seyeblack":
                    case "seye":
                    case "seyelash":
                    case "seyebrow":
                    case "fsunburn":
                    case "fdetailf":
                    case "msunburn":
                    case "mdetailf":
                    case "fskinb":
                    case "mskinb":
                    case "mbeard":
                        dictItemList.Insert(typeof(ListSkinDiffuse), new ListSkinDiffuse(this, item, type));
                        break;
                    case "smole":
                    case "slip":
                    case "scheek":
                    case "spaint":
                    case "seyeshadow":
                        dictItemList.Insert(typeof(ListSkinGloss), new ListSkinGloss(this, item, type));
                        break;
                    case "fsocks":
                    case "fshoes":
                    case "fgloves":
                    case "mgloves":
                    case "mshoes":
                        dictItemList.Insert(typeof(ListClothing), new ListClothing(this, item, type));
                        break;
                    case "fpanst":
                    case "finbottom":
                        dictItemList.Insert(typeof(ListClothingKokan), new ListClothingKokan(this, item, type));
                        break;
                    case "fintop":
                        dictItemList.Insert(typeof(ListClothingInnerTop), new ListClothingInnerTop(this, item, type));
                        break;
                    case "ftop":
                    case "mtop":
                        dictItemList.Insert(typeof(ListClothingTop), new ListClothingTop(this, item, type));
                        break;
                    case "fbottom":
                    case "mbottom":
                        dictItemList.Insert(typeof(ListClothingBottom), new ListClothingBottom(this, item, type));
                        break;
                    case "fhead":
                    case "mhead":
                        dictItemList.Insert(typeof(ListHead), new ListHead(this, item, type));
                        break;
                    case "fdetailb":
                    case "mdetailb":
                        dictItemList.Insert(typeof(ListSkinDetail), new ListSkinDetail(this, item, type));
                        break;
                    case "fskinf":
                    case "mskinf":
                        dictItemList.Insert(typeof(ListSkinFace), new ListSkinFace(this, item, type));
                        break;
                    default:
                        throw new Exception($"\"{type}\" is a not valid category.");
                }

            _gameItems[target] = dictItemList;
        }

        private void ParseListData(in XElement document)
        {
            _outputFileName = document.Attr("name");

            foreach (var element in document.Elements())
                RegisterItems(element, element.Attr<string>("type"));
        }
    }
}