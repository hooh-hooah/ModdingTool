using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace ModdingTool
{
    public static class AssetBundleManager
    {
        public static AssetBundle GetBundle(string path)
        {
            var bundle = AssetBundle.LoadFromFile(path);
            return bundle;
        }
    }
}