using System.Collections.Generic;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListMap : ListBase
    {
        public ListMap(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
            Name = element.Attr<string>("name");
            Scene = element.Attr<string>("scene");
            Bundle = element.Attr("bundle", GetBundleFromName(Scene) ?? "0");
        }

        public string Name { get; }
        public string Scene { get; }
        public string Bundle { get; }

        public override IEnumerable<(string, string)> GetAssetTuples =>
            new (string, string)[]
            {
                (Bundle, Scene)
            };

        public override IEnumerable<string> GetAssetNames => new[] {Name};

        public override string ToString()
        {
            return ToCsvLine(Index, Name, Bundle, Scene, Manifest);
        }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            return "abdata/studio/info/kPlug/Map_kPlug.csv";
        }

        public new static string GetOutputHeader()
        {
            return "MAPMOD,,,\nMAPMOD,,,";
        }
    }
}