using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListSkinDetail : ListCharacterBase
    {
        public ListSkinDetail(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            TextureNormal = element.Attr("tex-n", "0");
            TextureOcclusion = element.FindAttr(new[] {"tex-a", "tex-o"}, "0");
            TextureBundle = element.Attr("tex-bundle", GetBundleFromName(TextureNormal) ?? GetBundleFromName(TextureOcclusion) ?? "0");
        }

        public string TextureBundle { get; }
        public string TextureOcclusion { get; }
        public string TextureNormal { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (TextureBundle, TextureOcclusion),
                (TextureBundle, TextureNormal)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, TextureBundle, TextureOcclusion, TextureNormal, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainAB,OcclusionMapTex,NormalMapTex,ThumbAB,ThumbTex";
        }
    }
}