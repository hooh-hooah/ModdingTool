using System.Collections.Generic;
using ModPackerModule.Structure.ListData;
using UnityEngine;

namespace ModPackerModule.Structure.SideloaderMod.Data
{
    public class StudioInfo
    {
        private readonly Dictionary<string, ListStudioItem> ObjectToName = new Dictionary<string, ListStudioItem>();

        public bool TryGetInfo(GameObject gameObject, out ListStudioItem item)
        {
            return ObjectToName.TryGetValue(gameObject.name, out item);
        }

        public void RememberStudioItem(ListStudioItem item)
        {
            ObjectToName.Add(item.Asset, item);
        }
    }
}