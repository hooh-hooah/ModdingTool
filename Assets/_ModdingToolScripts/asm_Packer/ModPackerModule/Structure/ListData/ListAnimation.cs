using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;

namespace ModPackerModule.Structure.ListData
{
    public class ListAnimation : ListBase
    {
        public ListAnimation(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element) : base(in sideloaderMod, in element)
        {
            SortIndex = Index;
            BigCategory = element.Attr("big-category", 0);
            MidCategory = element.Attr("mid-category", 0);
            Name = element.Attr("name", "Unknown Name");
            AnimationController = element.Attr("anime-controller", "0");
            AnimationClip = element.Attr("anime", "0");
            AnimationControllerBundle = element.Attr("anime-bundle", GetBundleFromName(AnimationController) ?? "0");

            ItemAsset = element.Attr<string>("item-asset", "0");
            if (!ItemAsset.IsNullOrEmpty())
            {
                ItemManifest = element.Attr("item-manifest", Manifest);
                ItemBundle = element.Attr("item-bundle", GetBundleFromName(ItemAsset) ?? "0");
                ItemAnimationController = element.Attr("item-anime-controller", "0");
                ItemAnimationBundle = element.Attr("item-anime-bundle", GetBundleFromName(ItemAnimationController) ?? "0");
                SubAnimationAsset = element.Attr("sub-anime", "0");
                SubAnimationBundle = element.Attr("sub-bundle", GetBundleFromName(SubAnimationBundle) ?? "0");
                ItemParentBone = element.Attr("item-parent", "");
                UseParentScale = Convert.ToBoolean(element.Attr("use-scale", "true").ToLower());
                ItemAnimationSync = Convert.ToBoolean(element.Attr("sync-anime", "false").ToLower());
            }
            else
            {
                ItemManifest = "abdata";
                ItemBundle = "0";
                ItemAnimationController = "0";
                ItemAnimationBundle = "0";
                SubAnimationAsset = "0";
                SubAnimationBundle = "0";
                ItemParentBone = "0";
                UseParentScale = false;
                ItemAnimationSync = false;
            }
        }

        public int SortIndex { get; }
        public int BigCategory { get; }
        public int MidCategory { get; }
        public string Name { get; }
        public string AnimationControllerBundle { get; }
        public string AnimationController { get; }
        public string AnimationClip { get; }
        public string ItemBundle { get; }
        public string ItemAsset { get; }
        public string ItemManifest { get; }
        public string ItemAnimationBundle { get; }
        public string ItemAnimationController { get; }
        public string SubAnimationBundle { get; }
        public string SubAnimationAsset { get; }
        public string ItemParentBone { get; }
        public bool UseParentScale { get; }
        public bool ItemAnimationSync { get; }

        public override IEnumerable<string> GetAssetNames => new[] {Name};

        public override IEnumerable<int> GetCategories => base.GetCategories.Concat(
            new[] {BigCategory, MidCategory}
        );

        public override IEnumerable<(string, string)> GetAssetTuples => new[]
        {
            (AnimationControllerBundle, AnimationController),
            (ItemBundle, ItemAsset),
            (ItemAnimationBundle, ItemAnimationController),
            (SubAnimationBundle, SubAnimationAsset)
        };

        public override string ToString()
        {
            return ToCsvLine(Index, SortIndex, BigCategory, MidCategory, Name, AnimationControllerBundle, AnimationController, AnimationClip, "","","","","","","","","");
        }

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var array = parameters.ToArray();
            return $"abdata/studio/info/{array[0]}/custom/Anime_00_{array[2]:D2}_{array[1]:D2}.csv";
        }

        public new static string GetOutputHeader()
        {
            return "ダンス,,,,,,,,アイテム,,,ベースアニメーター,,アニメーター,,付けるところ\n表示順番,管理番号,大きい項目,中間項目,表示名,バンドルパス,ファイル名,クリップ名,バンドル,ファイル,マニフェスト,バンドル,ファイル,バンドル,ファイル,親,親のスケール影響受けるか,アニメ同期";
        }
    }
}