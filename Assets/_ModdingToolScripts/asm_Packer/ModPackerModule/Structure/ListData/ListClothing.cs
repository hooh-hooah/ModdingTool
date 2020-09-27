using System.Xml.Linq;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothing : ListClothingBase
    {
        public ListClothing(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
        }
    }
}