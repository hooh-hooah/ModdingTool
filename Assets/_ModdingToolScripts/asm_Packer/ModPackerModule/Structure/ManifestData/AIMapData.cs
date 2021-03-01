using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using MyBox;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    public class AIMapData : IManifestData
    {
        private static readonly string[] candidates = {"ai-maps", "ai-map"};
        private List<XElement> mapElements;
        private XElement mapRootElement;

        public (bool, string) IsValid()
        {
            return (true, null);
        }

        public void ParseData(in SideloaderMod.SideloaderMod modObject, in XElement modDocument)
        {
            foreach (var candidate in candidates)
            {
                mapRootElement = modDocument.Element(candidate);
                if (!ReferenceEquals(null, mapRootElement)) break;
            }
        }

        
        // TODO: automatically assign the bundle and verify 
        public void SaveData(ref XDocument document)
        {
            if (ReferenceEquals(null, mapRootElement)) return;
            if (!TryGetMapData(out var mapData)) return;
            var mapDataElement = new XElement("ai-maps");
            foreach (var map in mapData)
                mapDataElement.Add(map);
            document.Root?.Add(mapDataElement);
        }

        public bool TryGetMapData(out XElement[] result)
        {
            result = null;
            if (ReferenceEquals(null, mapRootElement)) return false;
            var mapData = mapRootElement.Elements("map-data");
            var mapArray = mapData as XElement[] ?? mapData.ToArray();
            if (mapArray.IsNullOrEmpty()) return false;
            result = mapArray;
            return true;
        }
    }
}