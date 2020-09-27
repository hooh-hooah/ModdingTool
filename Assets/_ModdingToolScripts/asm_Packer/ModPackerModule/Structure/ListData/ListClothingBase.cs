using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothingBase : ListCharacterBase
    {
        public ListClothingBase(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            StateType = element.Attr("state", 0);
            MeshAsset = element.Attr("mesh-a", "0");
            MeshAssetBundle = element.Attr("mesh-bundle", GetBundleFromName(MeshAsset) ?? "0");
            Texture = element.Attr("tex-main", "0");
            TextureMask = element.Attr("tex-mask", "0");
            TextureSub = element.Attr("tex-main2", "0");
            TextureSubMask = element.Attr("tex-mask2", "0");
            TextureBundle = element.Attr("tex-bundle", GetBundleFromName(Texture) ?? GetBundleFromName(TextureMask) ?? "0");
        }

        public int StateType { get; }
        public string MeshAsset { get; }
        public string MeshAssetBundle { get; }
        public string Texture { get; }
        public string TextureMask { get; }
        public string TextureBundle { get; }

        public string TextureSub { get; }

        public string TextureSubMask { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (MeshAssetBundle, MeshAsset),
                (TextureBundle, Texture),
                (TextureBundle, TextureMask),
                (TextureBundle, TextureSub),
                (TextureBundle, TextureSubMask)
            }
        );

        public override IEnumerable<int> GetCategories => base.GetCategories.Concat(
            new[] {StateType}
        );
    }
}