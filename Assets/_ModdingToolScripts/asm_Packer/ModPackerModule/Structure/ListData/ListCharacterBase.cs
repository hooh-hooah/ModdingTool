using System;
using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Xml.Linq;
using hooh_ModdingTool.asm_Packer.Utility;

namespace ModPackerModule.Structure.ListData
{
    /// <summary>
    ///     Fields:
    ///     Index, Manifest, Category, Kind, Possess, Name, EN_US, ThumbBundle, ThumbAsset
    /// </summary>
    public class ListCharacterBase : ListBase
    {
        [SuppressMessage("ReSharper", "StringLiteralTypo")]
        public static readonly Dictionary<string, (int, string)> DictCategory = new Dictionary<string, (int, string)>
        {
            {"mhead", (110, "mo_head_00")},
            {"mskinf", (111, "mt_skin_f_00")},
            {"mdetailf", (112, "mt_detail_f_00")},
            {"mbeard", (121, "mt_beard_00")},
            {"mskinb", (131, "mt_skin_b_00")},
            {"mdetailb", (132, "mt_detail_b_00")},
            {"msunburn", (133, "mt_sunburn_00")},
            {"mtop", (140, "mo_top_00")},
            {"mbottom", (141, "mo_bot_00")},
            {"mgloves", (144, "mo_gloves_00")},
            {"mshoes", (147, "mo_shoes_00")},
            {"fhead", (210, "fo_head_00")},
            {"fskinf", (211, "ft_skin_f_00")},
            {"fdetailf", (212, "ft_detail_f_00")},
            {"fskinb", (231, "ft_skin_b_00")},
            {"fdetailb", (232, "ft_detail_b_00")},
            {"fsunburn", (233, "ft_sunburn_00")},
            {"ftop", (240, "fo_top_00")},
            {"fbottom", (241, "fo_bot_00")},
            {"fintop", (242, "fo_inner_t_00")},
            {"finbottom", (243, "fo_inner_b_00")},
            {"fgloves", (244, "fo_gloves_00")},
            {"fpanst", (245, "fo_panst_00")},
            {"fsocks", (246, "fo_socks_00")},
            {"fshoes", (247, "fo_shoes_00")},
            {"spaint", (313, "st_paint_00")},
            {"seyebrow", (314, "st_eyebrow_00")},
            {"seyelash", (315, "st_eyelash_00")},
            {"seyeshadow", (316, "st_eyeshadow_00")},
            {"seye", (317, "st_eye_00")},
            {"seyeblack", (318, "st_eyeblack_00")},
            {"seye_hl", (319, "st_eye_hl_00")},
            {"scheek", (320, "st_cheek_00")},
            {"slip", (322, "st_lip_00")},
            {"smole", (323, "st_mole_00")},
            {"snip", (334, "st_nip_00")},
            {"sunderhair", (335, "st_underhair_00")},
            {"spattern", (348, "st_pattern_00")},
            {"accnone", (350, "ao_none_00")},
            {"acchead", (351, "ao_head_00")},
            {"accear", (352, "ao_ear_00")},
            {"accglasses", (353, "ao_glasses_00")},
            {"accface", (354, "ao_face_00")},
            {"accneck", (355, "ao_neck_00")},
            {"accshoulder", (356, "ao_shoulder_00")},
            {"accchest", (357, "ao_chest_00")},
            {"accwaist", (358, "ao_waist_00")},
            {"accback", (359, "ao_back_00")},
            {"accarm", (360, "ao_arm_00")},
            {"acchand", (361, "ao_hand_00")},
            {"accleg", (362, "ao_leg_00")},
            {"acckokan", (363, "ao_kokan_00")},
            {"hairback", (300, "fo_hair_back_00")},
            {"hairfront", (301, "fo_hair_front_00")},
            {"hairside", (302, "fo_hair_side_00")},
            {"hairext", (303, "fo_hair_option_00")}
        };

        public ListCharacterBase(in SideloaderMod.SideloaderMod sideloaderMod, in XElement element, string category) : base(in sideloaderMod, in element)
        {
            Kind = element.Attr("kind", 0);
            Possess = element.Attr("possess", 0);
            Name = element.Attr("name", "Unknown Name");
            EN_US = element.Attr("en_us", Name);
            ThumbAsset = element.Attr("thumb", "0");
            ThumbBundle = element.Attr("thumb-bundle", GetBundleFromName(ThumbAsset) ?? "0");
            if (DictCategory.TryGetValue(category, out var num)) Category = num.Item1;
            CategoryString = category;
        }

        public string CategoryString { get; }
        public int Category { get; }
        public int Kind { get; }
        public int Possess { get; }
        public string Name { get; }
        public string EN_US { get; }
        public string ThumbBundle { get; }
        public string ThumbAsset { get; }
        public override IEnumerable<string> GetAssetNames => new[] {Name};

        public override IEnumerable<(string, string)> GetAssetTuples => new (string, string)[]
        {
            (ThumbBundle, ThumbAsset)
        };

        public new static string GetOutputName(IEnumerable<object> parameters)
        {
            var array = parameters.ToArray();
            var categoryNum = Convert.ToInt32(array[0]);

            var categoryName = DictCategory.FirstOrDefault(x => x.Value.Item1 == categoryNum);

            return $"abdata/list/characustom/00/{categoryName.Value.Item2}.csv";
        }
    }
}