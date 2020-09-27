using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod.Data
{
    public class AssetInfo
    {
        public const string BundleTargetDefault = "_default";
        private readonly Dictionary<AssetType, HashSet<(string, string)>> _assetTypeList = new Dictionary<AssetType, HashSet<(string, string)>>();
        private readonly Dictionary<string, HashSet<string>> _bundleTargets = new Dictionary<string, HashSet<string>>();
        private readonly Dictionary<string, string> _nameToBundle = new Dictionary<string, string>();
        private readonly Dictionary<string, string> _nameToPath = new Dictionary<string, string>();
        private readonly Dictionary<string, string> _pathToBundle = new Dictionary<string, string>();

        private bool _warned;

        public HashSet<string> MarkedAsDuplicate { get; } = new HashSet<string>();
        public HashSet<string> Bundles { get; } = new HashSet<string>();

        public HashSet<string> Names { get; } = new HashSet<string>();

        public HashSet<string> Paths { get; } = new HashSet<string>();

        public Dictionary<string, HashSet<string>>.KeyCollection GetTargetBundles => _bundleTargets.Keys;

        public HashSet<string> GetBundlesOfTarget(string key)
        {
            return _bundleTargets.TryGetValue(key, out var bundles) ? bundles : default;
        }

        public void RememberTarget(string target)
        {
            if (!_bundleTargets.ContainsKey(target)) _bundleTargets.Add(target, new HashSet<string>());
        }

        public bool HasAsset(string name)
        {
            return name.IsNullOrEmpty() ? default : Names.Contains(name);
        }

        public bool HasAssetPath(string name)
        {
            return name.IsNullOrEmpty() ? default : Paths.Contains(name);
        }

        public bool HasBundle(string name)
        {
            return name.IsNullOrEmpty() ? default : Bundles.Contains(name);
        }

        public string GetBundleFromPath(string name)
        {
            return name.IsNullOrEmpty() ? default : _pathToBundle.TryGetValue(name, out var bundle) ? bundle : default;
        }

        public string GetBundleFromName(string name, string duplicateDefault = default)
        {
            if (name.IsNullOrEmpty()) return default;
            if (!duplicateDefault.IsNullOrEmpty() && MarkedAsDuplicate.Contains(name)) return duplicateDefault;
            return _nameToBundle.TryGetValue(name, out var bundle) ? bundle : default;
        }

        public string GetPathFromName(string name)
        {
            return name.IsNullOrEmpty() ? default : _nameToPath.TryGetValue(name, out var bundle) ? bundle : default;
        }

        // TODO: make scriptable object <Type, HashMap<Type>> to unfuck this mess
        public HashSet<(string, string)> GetAssetsByType(AssetType type)
        {
            return _assetTypeList.TryGetValue(type, out var assets) ? assets : default;
        }

        public IEnumerable<string> GetAssetPathsByType(AssetType type)
        {
            return _assetTypeList.TryGetValue(type, out var assets) ? assets.Select(x => x.Item1) : default;
        }

        public IEnumerable<string> GetAssetBundlesByType(AssetType type)
        {
            return _assetTypeList.TryGetValue(type, out var assets) ? assets.Select(x => x.Item1) : default;
        }

        public void InsertDependencyBundle(string bundlePath)
        {
            if (bundlePath.IsNullOrEmpty()) return;
            _bundleTargets.Insert(BundleTargetDefault, bundlePath);
        }

        public void RememberAsset(AssetType assetType, string path, string bundle, string target)
        {
            if (!ValidateUtils.BulkValidCheck(path, bundle, target)) return;

            var name = Path.GetFileNameWithoutExtension(path);

            if (!_warned && Names.Contains(name))
            {
                MarkedAsDuplicate.Add(name);
                _warned = true;
                Debug.LogWarning("Duplicated asset name found! It will mess with automatic assetbundle assignments");
            }
            else
            {
                Names.Add(name);
            }

            if (Paths.Contains(name)) throw new Exception("Duplicated asset path name");
            if (Bundles.Contains(name)) throw new Exception("Duplicated asset bundle name");

            Paths.Add(path);
            Bundles.Add(bundle);
            _nameToPath[name] = path;
            _nameToBundle[name] = bundle;
            _pathToBundle[path] = bundle;

            _bundleTargets.Insert(target, bundle);

            var tuple = (path, bundle);

            switch (assetType)
            {
                case AssetType.Map:
                    _assetTypeList.Insert(AssetType.Map, tuple);
                    break;
                case AssetType.ScriptableObject:
                    _assetTypeList.Insert(AssetType.ScriptableObject, tuple);
                    break;
                case AssetType.Animation:
                    _assetTypeList.Insert(AssetType.Animation, tuple);
                    break;
                case AssetType.Prefab:
                    _assetTypeList.Insert(AssetType.Prefab, tuple);
                    break;
            }
        }

        public static AssetType GetAssetType(string path)
        {
            var ext = Path.GetExtension(path);
            switch (ext)
            {
                case ".unity":
                    return AssetType.Map;
                case ".asset":
                    return AssetType.ScriptableObject;
                case ".controller":
                    return AssetType.Animation;
                case ".prefab":
                    return AssetType.Prefab;
                default:
                    return AssetType.Other;
            }
        }
    }
}