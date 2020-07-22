using System;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "MapInfo", menuName = "Honey Select 2: Libido/Create MapInfo", order = 1)]
public class MapInfo : ScriptableObject
{
    public List<Param> param = new List<Param>();

    [Serializable]
    public class Param
    {
        public List<string> MapNames = new List<string> {"Japanese Name", "English Name"};
        public int No = -1;
        public string AssetBundleName;
        public string AssetName;
        public int State = 1;
        public bool isOutdoors = false;
        public int Draw = 2;
        public int[] Events = {-1, 0, 1, 2};
        public string ThumbnailManifest_L;
        public string ThumbnailBundle_L;
        public string ThumbnailAsset_L;
        public string ThumbnailManifest_S;
        public string ThumbnailBundle_S;
        public string ThumbnailAsset_S;
        public bool isADV;
    }
}