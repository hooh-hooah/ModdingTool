using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "MapInfo", menuName = "Honey Select 2: Libido/Create MapInfo", order = 1)]
public class MapInfo : ScriptableObject
{
    public List<MapInfo.Param> param = new List<MapInfo.Param>();

    [Serializable]
    public class Param
    {
        public List<string> MapNames;
        public int No;
        public string AssetBundleName;
        public string AssetName;
        public int State;
        public bool isOutdoors;
        public int Draw;
        public int[] Events;
        public string ThumbnailManifest_L;
        public string ThumbnailBundle_L;
        public string ThumbnailAsset_L;
        public string ThumbnailManifest_S;
        public string ThumbnailBundle_S;
        public string ThumbnailAsset_S;
        public bool isADV;
    }
}