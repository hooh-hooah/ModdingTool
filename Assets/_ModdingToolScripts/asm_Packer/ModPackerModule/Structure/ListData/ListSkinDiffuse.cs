using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListSkinDiffuse : ListCharacterBase
    {
        public ListSkinDiffuse(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            Texture = element.Attr("tex-a", "0");
            TextureBundle = element.Attr("tex-bundle", GetBundleFromName(Texture) ?? "0");
        }

        public string Texture { get; }
        public string TextureBundle { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (TextureBundle, Texture)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, TextureBundle, Texture, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainAB,AddTex,ThumbAB,ThumbTex";
        }
    }
}