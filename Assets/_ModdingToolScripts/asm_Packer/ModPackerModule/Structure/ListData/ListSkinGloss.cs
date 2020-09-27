using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListSkinGloss : ListSkinDiffuse
    {
        public ListSkinGloss(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            TextureGloss = element.FindAttr(new[] {"tex-g"}, "0");
        }

        public string TextureGloss { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (TextureBundle, TextureGloss)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, TextureBundle, Texture, TextureGloss, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainAB,AddTex,GlossTex,ThumbAB,ThumbTex";
        }
    }
}