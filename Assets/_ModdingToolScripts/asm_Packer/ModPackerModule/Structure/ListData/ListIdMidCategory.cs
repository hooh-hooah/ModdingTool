using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListIdMidCategory : ListIdName
    {
        public ListIdMidCategory(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
            Category = element.Attr("big-category", 0);
        }

        public int Category { get; }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var array = parameters.ToArray();
            return $"abdata/studio/info/{array[0]}/ItemCategory_{array[1]:D2}_{array[2]:D2}.csv";
        }

        public static bool IsMidCategory(Type type)
        {
            return type == typeof(ListIdMidCategory) || type.IsSubclassOf(typeof(ListIdMidCategory));
        }
    }
}