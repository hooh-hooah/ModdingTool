using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothingBottom : ListClothingKokan
    {
        public ListClothingBottom(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            BreakMaskTexture = element.Attr("breakmask-tex", "0");
            InnerTBMaskTexture = element.Attr("innermask-tb-tex", "0");
            InnerTBMaskBundle = element.Attr("innermask-tb-bundle", GetBundleFromName(InnerTBMaskTexture) ?? "0");
            InnerBodyMask = element.Attr("innermask-b-tex", "0");
            InnerBodyMaskBundle = element.Attr("innermask-b-bundle", GetBundleFromName(InnerBodyMask) ?? "0");
            OverPanstMaskTexture = element.Attr("panstmask-tex", "0");
            OverPanstMaskBundle = element.Attr("panstmask-bundle", GetBundleFromName(OverPanstMaskTexture) ?? "0");
            OverBodyBottomMaskTexture = element.Attr("bodymask-b-tex", "0");
            OverBodyBottomMaskBundle = element.Attr("bodymask-b-bundle", GetBundleFromName(OverBodyBottomMaskTexture) ?? "0");
            TextureThird = element.Attr("tex-main3", "0");
            TextureThirdMask = element.Attr("tex-mask3", "0");
        }

        public string BreakMaskTexture { get; }
        public string InnerTBMaskTexture { get; }
        public string InnerTBMaskBundle { get; }
        public string InnerBodyMask { get; }
        public string InnerBodyMaskBundle { get; }
        public string OverPanstMaskBundle { get; }
        public string OverPanstMaskTexture { get; }
        public string OverBodyBottomMaskBundle { get; }
        public string OverBodyBottomMaskTexture { get; }
        public string TextureThird { get; }
        public string TextureThirdMask { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (InnerTBMaskBundle, InnerTBMaskTexture),
                (InnerBodyMaskBundle, InnerBodyMask),
                (OverPanstMaskBundle, OverPanstMaskTexture),
                (OverBodyBottomMaskBundle, OverBodyBottomMaskTexture),
                (TextureBundle, TextureThird),
                (TextureBundle, TextureThirdMask)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, MeshAssetBundle, MeshAsset, StateType, BreakMaskTexture, InnerTBMaskBundle, InnerTBMaskTexture,
                InnerBodyMaskBundle, InnerBodyMask, OverPanstMaskBundle, OverPanstMaskTexture, OverBodyBottomMaskBundle, OverBodyBottomMaskTexture, Texture, TextureBundle,
                TextureSub, TextureSubMask, TextureThird, TextureThirdMask,
                KokanHide, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return
                "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";
        }
    }
}