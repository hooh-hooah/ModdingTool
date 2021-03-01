using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothingInnerTop : ListClothingKokan
    {
        public ListClothingInnerTop(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            Coordinate = element.Attr("coordinate", 0);
            OverBraType = element.Attr("overbra-type", 0);
            OverBodyMaskTexture = element.FindAttr(new[]
            {
                "bodymask-tex",
                "overbodymask-tex",
                "overbra-tex",
            }, "0");
            OverBodyMaskBundle = element.FindAttr(new[]
            {
                "bodymask-bundle",
                "overbodymask-bundle",
                "overbra-bundle",
            }, GetBundleFromName(OverBodyMaskBundle) ?? "0");
        }

        public int Coordinate { get; }
        public int OverBraType { get; }
        public string OverBodyMaskBundle { get; }
        public string OverBodyMaskTexture { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (OverBodyMaskBundle, OverBodyMaskTexture),
                (OverBodyMaskBundle, OverBodyMaskTexture)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, MeshAssetBundle, MeshAsset, StateType, Coordinate, OverBraType, OverBodyMaskBundle, OverBodyMaskTexture,
                Texture, TextureMask, TextureSub, TextureSubMask, KokanHide, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return
                "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,OverBraType,OverBodyMaskAB,OverBodyMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";
        }
    }
}