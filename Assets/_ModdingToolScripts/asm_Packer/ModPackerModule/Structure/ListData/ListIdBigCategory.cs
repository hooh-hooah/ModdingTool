using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;

namespace ModPackerModule.Structure.ListData
{
    public class ListIdBigCategory : ListIdName
    {
        public ListIdBigCategory(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
        }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var manifest = parameters.First();
            return $"abdata/studio/info/{manifest}/ItemGroup_{manifest}.csv";
        }

        public static bool IsBigCategory(Type type)
        {
            return type == typeof(ListIdBigCategory) || type.IsSubclassOf(typeof(ListIdBigCategory));
        }
    }
}