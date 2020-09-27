using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothingKokan : ListClothing
    {
        public ListClothingKokan(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            KokanHide = element.Attr("hide-bottom", 0).Clamp(0, 1);
        }

        public int KokanHide { get; }

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, MeshAssetBundle, MeshAsset, StateType, Texture, TextureMask, TextureSub, TextureSubMask, KokanHide,
                ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";
        }
    }
}