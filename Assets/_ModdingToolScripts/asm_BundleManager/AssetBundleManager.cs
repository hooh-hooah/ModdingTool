using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ModdingTool
{
    public static class AssetBundleManager
    {
        public static AssetBundle GetBundle(string path)
        {
            AssetBundle bundle;
            try
            {
                bundle = AssetBundle.LoadFromFile(path);
            }
            finally
            {
                AssetBundle.UnloadAllAssetBundles(false);
                bundle = AssetBundle.LoadFromFile(path);
            }

            return bundle;
        }
    }
}