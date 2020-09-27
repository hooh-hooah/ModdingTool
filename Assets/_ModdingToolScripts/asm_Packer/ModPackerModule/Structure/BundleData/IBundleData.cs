using System.Collections.Generic;
using UnityEditor;

namespace ModPackerModule.Structure.BundleData
{
    public interface IBundleData
    {
        List<AssetBundleBuild> Bundles { get; }
        string AssetPath { get; set; }
        (bool, string) IsValid();
    }
}