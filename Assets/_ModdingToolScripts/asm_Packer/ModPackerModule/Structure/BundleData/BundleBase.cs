using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using ModPackerModule.Structure.SideloaderMod.Data;
using ModPackerModule.Utility;
using MyBox;
using UnityEditor;
using UnityEngine;
using static System.IO.Path;

// ReSharper disable StringLiteralTypo

namespace ModPackerModule.Structure.BundleData
{
    public abstract class BundleBase : IBundleData
    {
        private readonly List<string> _badAssets;

        private readonly XElement _bundleElement;

        protected readonly SideloaderMod.SideloaderMod SideloaderMod;

        public bool AutoPath;
        // remember types
        // prefabs, materials, shaders, asset, text, csv, .... for later confirmation use.

        protected string AutoPathParameter;
        protected string AutoPathType;

        protected BundleBase(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element)
        {
            _bundleElement = element;
            _badAssets = new List<string>();
            SideloaderMod = sideloaderMod;
            AssetPath = element.Attr("path");
            Target = element.Attr("target", AssetInfo.BundleTargetDefault);
            Bundles = new List<AssetBundleBuild>();

            sideloaderMod.Assets.RememberTarget(Target);
        }

        protected BundleBase(in SideloaderMod.SideloaderMod sideloaderMod, string assetPath, string target)
        {
            _badAssets = new List<string>();
            SideloaderMod = sideloaderMod;
            AssetPath = assetPath;
            Target = target ?? AssetInfo.BundleTargetDefault;
            Bundles = new List<AssetBundleBuild>();

            sideloaderMod.Assets.RememberTarget(Target);
        }

        public string Target { get; } // Used for splitting bundles;

        public List<AssetBundleBuild> Bundles { get; }

        public string AssetPath { get; set; }

        public (bool, string) IsValid()
        {
            if (ReferenceEquals(null, _bundleElement)) return (false, "Invalid Element");
            if (AssetPath.IsNullOrEmpty()) return (false, "Invalid Path");
            if (_badAssets.Count <= 0) return (true, null);

            _badAssets.ForEach(path => Debug.LogError($"Failed to resolve asset: {path}"));
            return (false, "Failed to validate assetbundle.");
        }

        public BundleBase InitializeBundles(in XElement element)
        {
            if (element.Attribute("auto-path")?.Value == null)
            {
                GenerateAssetBundles();
            }
            else
            {
                AutoPathType = element.Attr<string>("auto-path");
                AutoPathParameter = element.Attr("parameter", "");
                AutoPath = true;
            }

            return this;
        }

        public virtual void ResolveAutoPath()
        {
            AssetPath = GetAutoPath(
                SideloaderMod,
                AutoPathType,
                SideloaderMod.MainData.Separator,
                AutoPathParameter
            );
            GenerateAssetBundles();
        }

        public virtual void GenerateAssetBundles()
        {
        }

        private string GetAutoPathIdentifier(string idKey)
        {
            if (this is FolderBundle folder && folder.Grouped) return "*";
            return $"{SideloaderMod.GetAutoPathIndex(idKey):D3}";
        }

        protected string GetAutoPath(in SideloaderMod.SideloaderMod sideloaderMod, string mode, string uniqueId, string parameter)
        {
            switch (mode)
            {
                case "textures":
                case "texture":
                    return $"{sideloaderMod.MainData.SafeName}/{uniqueId}/data_texture_{GetAutoPathIdentifier("textures")}.unity3d";
                case "materials":
                case "material":
                    return $"{sideloaderMod.MainData.SafeName}/{uniqueId}/data_material_{GetAutoPathIdentifier("materials")}.unity3d";
                case "map":
                case "maps":
                    return $"{sideloaderMod.MainData.SafeName}/{uniqueId}/data_scene_{GetAutoPathIdentifier("maps")}.unity3d";
                case "thumbnail":
                case "thumbnails":
                case "thumb":
                case "thumbs":
                    return $"{sideloaderMod.MainData.SafeName}/{uniqueId}/data_thumbnail_{GetAutoPathIdentifier("thumbs")}.unity3d";
                case "object":
                case "objects":
                case "prefab":
                case "prefabs":
                    return $"{sideloaderMod.MainData.SafeName}/{uniqueId}/data_prefab_{GetAutoPathIdentifier("prefabs")}.unity3d";
                case "object-split":
                case "objects-split":
                case "prefab-split":
                case "prefabs-split":
                    return $"{sideloaderMod.MainData.SafeName}/{uniqueId}/data_prefab_*.unity3d";
                case "studiothumbs":
                case "studiothumb":
                case "studio-thumbs":
                case "studio-thumb":
                case "studiothumbnails":
                case "studiothumbnail":
                    return "abdata/studio_thumbnails";
                case "mapinfo":
                case "mapdata":
                    return $"map/list/mapinfo/{uniqueId}_mapdata_{GetAutoPathIdentifier("mapdata"):D3}.unity3d";
                case "eventcg":
                case "mapcamera":
                    var mapId = sideloaderMod.GameMapInfo.GetMapId(parameter);
                    return $"adv/eventcg/{(mapId > 0 ? mapId.ToString() : parameter)}.unity3d";

                default:
                    Debug.LogError($"Invalid Auto-path parameter {mode}");
                    break;
            }

            return "";
        }

        public static bool IsValidAssetPath(string path)
        {
            if (path.IsNullOrEmpty()) return false;
            return !AssetDatabase.AssetPathToGUID(path).IsNullOrEmpty();
        }

        public bool IsDirectoryValid(string path, out string validatedPath)
        {
            validatedPath = Combine(SideloaderMod.AssetDirectory, path);
            return Directory.Exists(validatedPath);
        }

        public string[] GetFilesWithRegex(string path, string regex)
        {
            // TODO: find better way
            var assetFolder = SideloaderMod.AssetFolder;
            var currentDirectory = SideloaderMod.AssetDirectory;
            return PathUtils.GetFilesWithRegex(Combine(currentDirectory, path), regex)
                .Select(file => Combine(assetFolder, path, GetFileName(file)).ToUnixPath())
                .ToArray();
        }

        public bool CheckAndRememberAsset(string path)
        {
            var result = IsValidAssetPath(path);
            if (!result) _badAssets.Add(path);
            return result;
        }

        public void AddBundle(string bundlePath, List<string> bundleAssets, bool isAllocBundle = true)
        {
            AddBundle(bundlePath, bundleAssets.ToArray());
        }

        public void AddBundle(string bundlePath, string asset, bool isAllocBundle = true)
        {
            AddBundle(bundlePath, new[] {asset}, isAllocBundle);
        }

        public void AddBundle(string bundlePath, string[] bundleAssets, bool isAllocBundle = true)
        {
            if (isAllocBundle)
                if (bundleAssets.IsNullOrEmpty())
                    Debug.LogWarning($"Empty Assetbundle Detected: {bundlePath}");
                else
                    bundleAssets.ForEach(assetPath => SideloaderMod.RememberAsset(assetPath, bundlePath, Target));

            // register asset for resolving assetbundle 
            Bundles.Add(
                new AssetBundleBuild
                {
                    assetBundleName = bundlePath,
                    assetNames = bundleAssets
                }
            );
        }
    }
}