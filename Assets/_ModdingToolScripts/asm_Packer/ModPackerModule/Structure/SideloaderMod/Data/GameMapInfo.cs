using System.Collections;
using System.Collections.Generic;
using hooh_ModdingTool.asm_Packer.Utility;
using UnityEditor;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod.Data
{
    // TODO: Parse map info after loading all of the data. - yes i'm doing this because this is separated to another assembly. you can laugh at me.
    public class GameMapInfo
    {
        public readonly List<(string, string)> MapBundles = new List<(string, string)>();
        public readonly Dictionary<object, int[]> MapEvents = new Dictionary<object, int[]>();
        public readonly Dictionary<string, int> MapNameToId = new Dictionary<string, int>();


        public int GetMapId(string name)
        {
            return MapNameToId.TryGetValue(name, out var id) ? id : -1;
        }

        public void ParseMapAsset(string scriptPath)
        {
            var asset = AssetDatabase.LoadAssetAtPath<ScriptableObject>(scriptPath);
            if (ReferenceEquals(null, asset)) return;

            var assetType = asset.GetType();
            if (assetType.Name != "MapInfo") return;

            var mapLists = (IEnumerable) assetType.GetField("param").GetValue(asset);

            foreach (var mapInfo in mapLists)
            {
                var mapBundleName = mapInfo.ReflectField<string>("AssetBundleName");
                var mapAssetName = mapInfo.ReflectField<string>("AssetName");
                var mapId = mapInfo.ReflectField("No", -1);
                if (!ValidateUtils.BulkValidCheck(mapBundleName, mapAssetName)) continue;

                MapBundles.Add((mapBundleName, mapAssetName));
                MapNameToId[mapAssetName] = mapId;

                var events = mapInfo.ReflectField<int[]>("Events");
                MapEvents.Add(mapInfo, events);
            }
        }
    }
}