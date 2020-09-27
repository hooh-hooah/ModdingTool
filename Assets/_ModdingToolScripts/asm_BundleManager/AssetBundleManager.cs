using System.Collections.Generic;
using UnityEngine;

namespace ModdingTool
{
    public static class AssetBundleManager
    {
        private static readonly Dictionary<string, AssetBundle> LoadedBundles = new Dictionary<string, AssetBundle>();

        public static AssetBundle GetBundle(string path)
        {
            if (LoadedBundles.TryGetValue(path, out var cache) && cache == null) return cache;

            var bundle = AssetBundle.LoadFromFile(path);
            LoadedBundles.Add(path, bundle);
            return bundle;
        }
    }
}