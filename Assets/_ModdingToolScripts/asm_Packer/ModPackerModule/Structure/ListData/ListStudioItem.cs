using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    public class ListStudioItem : ListBase
    {
        // ChildNode - processed by ItemComponent
        // IsAnime - processed by ItemComponent
        // IsColor1 - processed by ItemComponent
        // Color1 - processed by ItemComponent
        // IsColor2 - processed by ItemComponent
        // Color2 - processed by ItemComponent
        // IsColor3 - processed by ItemComponent
        // Color3 - processed by ItemComponent
        // IsScalable - processed by ItemComponent
        // IsEmission - processed by ItemComponent
        public ListStudioItem(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
            BigCategory = element.Attr("big-category", -1);
            MidCategory = element.Attr("mid-category", -1);
            Name = element.Attr<string>("name");
            Asset = element.Attr<string>("object");
            AssetBundle = element.Attr("object-bundle", GetBundleFromName(Asset) ?? "0");
            sideloaderMod.StudioInfo.RememberStudioItem(this);
        }

        public int BigCategory { get; }
        public int MidCategory { get; }
        public string Name { get; }
        public string Asset { get; }
        public string AssetBundle { get; }

        public override IEnumerable<(string, string)> GetAssetTuples => new (string, string)[]
        {
            (AssetBundle, Asset)
        };

        public override IEnumerable<string> GetAssetNames => new[] {Name};

        public override IEnumerable<int> GetCategories => base.GetCategories.Concat(
            new[] {BigCategory, MidCategory}
        );

        public override string ToString()
        {
            return ToCsvLine(Index, BigCategory, MidCategory, Name, Manifest, AssetBundle, Asset);
        }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var array = parameters.ToArray();
            return $"abdata/studio/info/{array[0]}/ItemList_01_{array[2]:D2}_{array[1]:D2}.csv";
        }

        public new static string GetOutputHeader()
        {
            return "ID,BigCategory,MidCategory,Name,Manifest,Bundle,Object,Child,IsAnime,IsColor,柄,IsColor2,柄,IsColor3,柄,拡縮判定,Emission";
        }
    }
}