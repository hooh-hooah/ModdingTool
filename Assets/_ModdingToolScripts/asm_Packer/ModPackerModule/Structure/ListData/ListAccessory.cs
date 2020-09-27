using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;
using MyBox;

namespace ModPackerModule.Structure.ListData
{
    public class ListAccessory : ListClothing
    {
        private static readonly HashSet<string> partWhitelist = new HashSet<string>
        {
            "N_Hair_pony", "N_Hair_twin_L", "N_Hair_twin_R", "N_Hair_pin_L", "N_Hair_pin_R",
            "N_Head_top", "N_Hitai", "N_Head", "N_Face",
            "N_Earring_L", "N_Earring_R", "N_Megane", "N_Nose", "N_Mouth",
            "N_Neck", "N_Chest_f", "N_Chest", "N_Tikubi_L", "N_Tikubi_R", "N_Back",
            "N_Back_L", "N_Back_R", "N_Waist", "N_Waist_f", "N_Waist_b", "N_Waist_L", "N_Waist_R",
            "N_Leg_L", "N_Knee_L", "N_Ankle_L", "N_Foot_L", "N_Leg_R", "N_Knee_R", "N_Ankle_R",
            "N_Foot_R", "N_Shoulder_L", "N_Elbo_L", "N_Arm_L", "N_Wrist_L", "N_Shoulder_R", "N_Elbo_R",
            "N_Arm_R", "N_Wrist_R", "N_Hand_L", "N_Index_L", "N_Middle_L", "N_Ring_L",
            "N_Hand_R", "N_Index_R", "N_Middle_R", "N_Ring_R", "N_Dan", "N_Kokan", "N_Ana"
        };

        public ListAccessory(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element, category)
        {
            // Invalid parent part;
            ParentPart = element.Attr<string>("parent");
            if (!ParentPart.IsNullOrEmpty() && !partWhitelist.Contains(ParentPart)) ParentPart = "N_Head";
            Asset = element.Attr<string>("mesh-a");
            AssetBundle = element.Attr("mesh-bundle", GetBundleFromName(Asset) ?? "0");
        }

        public string Asset { get; }
        public string AssetBundle { get; }
        public string ParentPart { get; } // should be one of enums.

        public override IEnumerable<(string, string)> GetAssetTuples => base.GetAssetTuples.Concat(
            new[]
            {
                (AssetBundle, Asset)
            }
        );

        public override string ToString()
        {
            return ToCsvLine(Index, Kind, Possess, Name, EN_US, Manifest, AssetBundle, Asset, ParentPart, ThumbBundle, ThumbAsset);
        }

        public new static string GetOutputHeader()
        {
            return "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,Parent,ThumbAB,ThumbTex";
        }

        public override bool IsValid(out string reason)
        {
            if (
                !base.IsValid(out reason)
            ) return false;

            if (!partWhitelist.Contains(ParentPart)) reason = "Invalid Accessory Parent Part";

            return true;
        }
    }
}