using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListSkinFace : ListCharacterBase
    {
        public ListSkinFace(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            HeadID = element.Attr("head-id", 0).Clamp(0, 5);
            Texture = element.Attr("tex-a", "0");
            TextureOcclusion = element.Attr("tex-o", "0");
            TextureNormal = element.Attr("tex-n", "0");
            TextureBundle = element.Attr("tex-bundle",
                GetBundleFromName(Texture) ?? GetBundleFromName(TextureOcclusion) ?? GetBundleFromName(TextureNormal) ?? "0"
            );
        }

        public int HeadID { get; }
        public string Texture { get; }
        public string TextureOcclusion { get; }
        public string TextureNormal { get; }
        public string TextureBundle { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (TextureBundle, Texture),
                (TextureBundle, TextureOcclusion),
                (TextureBundle, TextureNormal)
            }
        );

        public override IEnumerable<int> GetCategories => base.GetCategories.Concat(
            new[] {HeadID}
        );

        public override string ToString()
        {
            return ToCsvLine(Index, HeadID, Kind, Possess, Name, EN_US, Manifest, TextureBundle, Texture, TextureOcclusion, TextureNormal, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,HeadID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainTex,OcclusionMapTex,NormalMapTex,ThumbAB,ThumbTex";
        }
    }
}