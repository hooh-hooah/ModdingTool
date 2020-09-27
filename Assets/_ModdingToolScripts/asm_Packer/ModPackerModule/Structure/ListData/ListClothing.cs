using System.Xml.Linq;

namespace ModPackerModule.Structure.ListData
{
    public class ListClothing : ListClothingBase
    {
        public ListClothing(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
        }
        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,ThumbAB,ThumbTex";
        }
        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, MeshAssetBundle, MeshAsset, StateType, Texture, TextureBundle, TextureSub, TextureSubMask, ThumbBundle, ThumbAsset);
        }
    }
}