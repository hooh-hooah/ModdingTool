using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothingTop : ListClothingKokan
    {
        public ListClothingTop(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            Coordinate = element.Attr("coordinate", 0).Clamp(0, 1);
            NotBra = element.Attr("no-bra", 0).Clamp(0, 1);
            OverBodyMaskTexture = element.Attr("bodymask-tex", "0");
            OverBodyMaskBundle = element.Attr("bodymask-bundle", GetBundleFromName(OverBodyMaskTexture, TextureBundle) ?? "0");
            OverBraMaskTexture = element.Attr("bramask-tex", "0");
            BreakMaskTexture = element.Attr("breakmask-tex", "0");
            OverBraMaskBundle = element.Attr("bramask-bundle", GetBundleFromName(OverBraMaskTexture, TextureBundle) ?? GetBundleFromName(BreakMaskTexture, TextureBundle) ?? "0");
            InnerTbMaskTexture = element.Attr("innermask-tb-tex", "0");
            InnerTbMaskBundle = element.Attr("innermask-tb-bundle", GetBundleFromName(InnerTbMaskTexture, TextureBundle) ?? "0");
            InnerBodyMask = element.Attr("innermask-b-tex", "0");
            InnerBodyMaskBundle = element.Attr("innermask-b-bundle", GetBundleFromName(InnerBodyMask, TextureBundle) ?? "0");
            OverPanstMaskTexture = element.Attr("panstmask-tex", "0");
            OverPanstMaskBundle = element.Attr("panstmask-bundle", GetBundleFromName(OverPanstMaskTexture, TextureBundle) ?? "0");
            OverBodyBottomMaskTexture = element.Attr("bodymask-b-tex", "0");
            OverBodyBottomMaskBundle = element.Attr("bodymask-b-bundle", GetBundleFromName(OverBodyBottomMaskTexture, TextureBundle) ?? "0");
            TextureThird = element.Attr("tex-main3", "0");
            TextureThirdMask = element.Attr("tex-mask3", "0");
        }

        public int Coordinate { get; }
        public int NotBra { get; }
        public string OverBodyMaskBundle { get; }
        public string OverBodyMaskTexture { get; }
        public string OverBraMaskBundle { get; }
        public string OverBraMaskTexture { get; }
        public string BreakMaskTexture { get; }
        public string InnerTbMaskTexture { get; }
        public string InnerTbMaskBundle { get; }
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
                (OverBodyMaskBundle, OverBodyMaskTexture),
                (OverBraMaskBundle, OverBraMaskTexture),
                (OverBraMaskBundle, BreakMaskTexture),
                (InnerTbMaskBundle, InnerTbMaskTexture),
                (InnerBodyMaskBundle, InnerBodyMask),
                (OverPanstMaskBundle, OverPanstMaskTexture),
                (OverBodyBottomMaskBundle, OverBodyBottomMaskTexture),
                (TextureBundle, TextureThird),
                (TextureBundle, TextureThirdMask)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(
                Index, Kind, Possess, Name, EN_US, Manifest, MeshAssetBundle, MeshAsset, StateType, Coordinate, NotBra, OverBodyMaskBundle, OverBodyMaskTexture,
                OverBraMaskBundle, OverBraMaskTexture, BreakMaskTexture, InnerTbMaskBundle, InnerTbMaskTexture, InnerBodyMaskBundle, InnerBodyMask,
                OverPanstMaskBundle, OverPanstMaskTexture, OverBodyBottomMaskBundle, OverBodyBottomMaskTexture, Texture,
                TextureMask, TextureSub, TextureSubMask, TextureThird, TextureThirdMask, KokanHide, ThumbBundle, ThumbAsset
            );
        }

        public new static string GetOutputHeader()
        {
            return
                "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,NotBra,OverBodyMaskAB,OverBodyMask," +
                "OverBraMaskAB,OverBraMask,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask," +
                "OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex," +
                "ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";
        }
    }
}