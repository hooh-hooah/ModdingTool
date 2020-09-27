using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListHair : ListCharacterBase
    {
        public ListHair(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            HairAsset = element.Attr("mesh-a", "0");
            AccessoryAsset = element.Attr("mesh-b", "0");
            BundleName = element.Attr("mesh-bundle", GetBundleFromName(HairAsset) ?? "0");
            Weights = element.Attr("weights", 0);
            RingOff = element.Attr("ringoff", 0);
            TextureManifest = element.Attr("tex-manifest", Manifest);
            TextureDiffuse = element.Attr("tex-a", "0");
            TextureColormask = element.Attr("tex-b", "0");
            TextureBundle = element.Attr("tex-bundle", GetBundleFromName(TextureDiffuse) ?? GetBundleFromName(TextureColormask) ?? "0");
            IsSetHair = element.Attr("set-hair", 0).Clamp(0, 1);
        }

        public string AccessoryAsset { get; }
        public string BundleName { get; }
        public string HairAsset { get; }
        public int Weights { get; }
        public int RingOff { get; }
        public string TextureManifest { get; }
        public string TextureBundle { get; }
        public string TextureDiffuse { get; }
        public string TextureColormask { get; }
        public int IsSetHair { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (BundleName, HairAsset),
                (BundleName, AccessoryAsset),
                (TextureBundle, TextureColormask),
                (TextureBundle, TextureDiffuse)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, BundleName, HairAsset, AccessoryAsset, Weights, RingOff, TextureManifest, TextureBundle, TextureDiffuse,
                TextureColormask, IsSetHair, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,MainData02,Weights,RingOff,TexManifest,TexAB,TexD,TexC,SetHair,ThumbAB,ThumbTex";
        }
    }
}