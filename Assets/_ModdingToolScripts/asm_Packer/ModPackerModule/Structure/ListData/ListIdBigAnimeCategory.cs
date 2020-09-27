using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace ModPackerModule.Structure.ListData
{
    public class ListIdBigAnimeCategory : ListIdBigCategory
    {
        public ListIdBigAnimeCategory(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
        }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var manifest = parameters.First();
            return $"abdata/studio/info/{manifest}/AnimeGroup_{manifest}.csv";
        }
    }
}