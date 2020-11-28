using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using ModPackerModule.Structure.ListData;
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

            try
            {
                ListShoes = modObject.GameItems.Values
                    .Where(items => items.ItemList.ContainsKey(typeof(ListClothing)))
                    .Select(x => x.ItemList[typeof(ListClothing)])
                    .SelectMany(x => x)
                    .Cast<ListClothing>()
                    .Where(x => x.CategoryString.Equals("fshoes") || x.CategoryString.Equals("mshoes"))
                    .ToArray();
            }
            catch
            {
                ListShoes = new ListClothing[] {};
            }
        }

        private ListClothing[] ListShoes { get; set; }

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

            for (var i = heelsArray.Length - 1; i >= 0; i--)
            {
                if (ListShoes.Length <= i) break;
                var shoeItems = ListShoes[i];
                heelsArray[i].SetAttributeValue("id", shoeItems.Index);
            }

            if (heelsArray.IsNullOrEmpty()) return false;
            result = heelsArray;
            return true;
        }
    }
}