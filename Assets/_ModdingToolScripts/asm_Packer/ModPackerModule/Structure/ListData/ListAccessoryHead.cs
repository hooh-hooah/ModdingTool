using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;

namespace ModPackerModule.Structure.ListData
{
    public class ListAccessoryHead : ListAccessory
    {
        public ListAccessoryHead(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            HairTexture = element.Attr("hair-tex", "0");
            HairTextureMask = element.Attr("hair-mask", "0");
            HairTextureBundle = element.Attr("hair-bundle", GetBundleFromName(HairTexture) ?? GetBundleFromName(HairTextureMask) ?? "0");
            HairTextureManifest = element.Attr("hair-manifest", HairTextureBundle.Equals("0") ? "abdata" : Manifest);
        }

        public string HairTexture { get; }
        public string HairTextureMask { get; }
        public string HairTextureBundle { get; }
        public string HairTextureManifest { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (HairTextureBundle, HairTexture),
                (HairTextureBundle, HairTextureMask),
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, AssetBundle, Asset, HairTextureManifest, HairTextureBundle, HairTexture, HairTextureMask, ParentPart,
                ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,TexManifest,TexAB,TexD,TexC,Parent,ThumbAB,ThumbTex";
        }
    }
}