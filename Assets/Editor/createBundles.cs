using UnityEngine;
using System.Collections;
using UnityEditor;
using System.IO;
using System.Collections.Generic;

public class AssetBoundExport : EditorWindow
{

    [MenuItem("AI Shoujo/Build Asset Bundles")]
    static void Init()
    {        

        {
            BuildAssetBundleOptions ops = 
                BuildAssetBundleOptions.DeterministicAssetBundle | BuildAssetBundleOptions.UncompressedAssetBundle;
            BuildPipeline.BuildAssetBundles(Application.dataPath + "/assetbundle",ops, BuildTarget.StandaloneWindows);
        }

    }



}
