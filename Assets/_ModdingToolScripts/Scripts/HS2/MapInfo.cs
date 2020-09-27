using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using UnityEngine;
#if UNITY_EDITOR
using ModPackerModule.Utility;
using UnityEditor;

#endif

[CreateAssetMenu(fileName = "MapInfo", menuName = "Honey Select 2: Libido/Create MapInfo", order = 1)]
public class MapInfo : ScriptableObject
{
    public List<Param> param = new List<Param>();

#if UNITY_EDITOR
    public void AutoFix()
    {
        if (!this.TryFindNearestModData(out var sideloaderMod)) return;

        var index = -1;
        foreach (var map in param)
        {
            if (index < 0) index = map.No;
            else map.No = ++index;

            map.AssetBundleName = sideloaderMod.Assets.GetBundleFromName(map.AssetName);

            // Check small thumb name
            var smallThumbName = $"{map.AssetName}_thumb_s";
            if (sideloaderMod.Assets.HasAsset(smallThumbName))
                map.ThumbnailAsset_S = smallThumbName;

            // Check large thumb name
            var largeThumbName = $"{map.AssetName}_thumb_l";
            if (sideloaderMod.Assets.HasAsset(largeThumbName))
                map.ThumbnailAsset_L = largeThumbName;

            map.ThumbnailBundle_L = sideloaderMod.Assets.GetBundleFromName(map.ThumbnailAsset_L);
            map.ThumbnailBundle_S = sideloaderMod.Assets.GetBundleFromName(map.ThumbnailAsset_S);
            map.ThumbnailManifest_L = sideloaderMod.DependencyData.ManifestName;
            map.ThumbnailManifest_S = sideloaderMod.DependencyData.ManifestName;
        }


        EditorUtility.SetDirty(this);
    }
#endif

    // TODO: Automatically adjust asset bundle paths if available.
    [Serializable]
    [SuppressMessage("ReSharper", "InconsistentNaming")]
    public class Param
    {
#if UNITY_EDITOR
        // Currently used by ILLUSION atm.
        private static readonly int[] ReservedMapSlots = {0, 1, 2, 3, 4, 100, 101, 102, 103, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15, 50, 51, 52, 53, 16, 500};
#endif
        public static readonly int[] DefaultADVEventCategories = {-1, 0, 1, 2, 10, 11, 16, 18, 19, 20, 21, 23, 24, 25, 26, 27, 33};

        public string AssetBundleName;
        public string AssetName;
        public int Draw = 2;
        public int[] Events = DefaultADVEventCategories;
        public bool isADV;
        public bool isOutdoors;
        public List<string> MapNames = new List<string> {"Japanese Name", "English Name"};
        public int No = -1;
        public int State = 1;
        public string ThumbnailAsset_L;
        public string ThumbnailAsset_S;
        public string ThumbnailBundle_L;
        public string ThumbnailBundle_S;
        public string ThumbnailManifest_L;
        public string ThumbnailManifest_S;
    }
}