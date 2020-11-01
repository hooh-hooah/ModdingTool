using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace ModPackerModule.Structure.ListData
{
    public class ListIdMidAnimeCategory : ListIdMidCategory
    {
        public ListIdMidAnimeCategory(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
        }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var array = parameters.ToArray();
            return $"abdata/studio/info/{array[0]}/custom/AnimeCategory_00_{array[2]:D2}.csv";
        }
    }
}