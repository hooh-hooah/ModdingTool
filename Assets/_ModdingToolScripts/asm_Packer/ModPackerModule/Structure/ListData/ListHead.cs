using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListHead : ListCharacterBase
    {
        public ListHead(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            MainAsset = element.Attr("head-object", "0");
            MainAssetBundle = element.Attr("head-bundle", GetBundleFromName(MainAsset) ?? "0");
            ShapeAnime = element.Attr("shape-anime", "0");
            MatData = element.Attr("mat-data", "0");
            Preset = element.Attr("preset", "0");
        }

        public string MainAsset { get; }
        public string MainAssetBundle { get; }
        public string ShapeAnime { get; }
        public string MatData { get; }
        public string Preset { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (MainAssetBundle, MainAsset)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, MainAssetBundle, MainAsset, ShapeAnime, MatData, Preset, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,ShapeAnime,MatData,Preset,ThumbAB,ThumbTex";
        }
    }
}