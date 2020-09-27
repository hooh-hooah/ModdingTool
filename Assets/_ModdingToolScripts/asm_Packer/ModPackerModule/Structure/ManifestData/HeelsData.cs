using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using MyBox;

namespace ModPackerModule.Structure.Classes.ManifestData
{
    public class HeelsData : IManifestData
    {
        private static readonly string[] candidates = {"heels", "HeelsData"};
        private List<XElement> heelsElements;
        private XElement heelsRootElement;

        public (bool, string) IsValid()
        {
            // Verify heels by going through all shoes
            if (TryGetHeelsData(out var heelsData))
            {
                // check heels data integrity if it's valid.
            }

            return (true, null);
        }

        public void ParseData(in SideloaderMod.SideloaderMod modObject, in XElement modDocument)
        {
            foreach (var candidate in candidates)
            {
                heelsRootElement = modDocument.Element(candidate);
                if (!ReferenceEquals(null, heelsRootElement)) break;
            }
        }

        public void SaveData(ref XDocument document)
        {
            if (ReferenceEquals(null, heelsRootElement)) return;
            if (!TryGetHeelsData(out var heelsData)) return;
            var heelsDataElement = new XElement("AI_HeelsData");
            foreach (var heels in heelsData)
                heelsDataElement.Add(heels);
            document.Root?.Add(heelsDataElement);
        }

        public bool TryGetHeelsData(out XElement[] result)
        {
            result = null;
            if (ReferenceEquals(null, heelsRootElement)) return false;
            var heelsData = heelsRootElement.Elements("heel");
            var heelsArray = heelsData as XElement[] ?? heelsData.ToArray();
            if (heelsArray.IsNullOrEmpty()) return false;
            result = heelsArray;
            return true;
        }
    }
}