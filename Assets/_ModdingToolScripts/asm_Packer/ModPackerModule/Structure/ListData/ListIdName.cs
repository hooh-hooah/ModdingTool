using System.Collections.Generic;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListIdName : ListBase
    {
        public ListIdName(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
            Name = element.Attr("name", "Undefined Name");
        }

        public string Name { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => null;
        public override IEnumerable<string> GetAssetNames => new[] {Name};

        public override string ToString()
        {
            return ToCsvLine(Index, Name);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Name";
        }
    }
}