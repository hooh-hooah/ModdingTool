#if UNITY_EDITOR
using System.Collections.Generic;
using System.Xml.Linq;
using UnityEngine;

namespace ModPackerModule
{
    public class CSVBuilder
    {
        // Okay I'll manage this later, do not bash me for this shit!
        private static readonly string hairHeader =
            "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,MainData02,Weights,RingOff,TexManifest,TexAB,TexD,TexC,SetHair,ThumbAB,ThumbTex";

        private static readonly string accessoryHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,Parent,ThumbAB,ThumbTex";
        private static readonly string accessoryHeadHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,TexManifest,TexAB,TexD,TexC,Parent,ThumbAB,ThumbTex";

        private static readonly string clothesBottomHeader =
            "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";

        private static readonly string clothesTopHeader =
            "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,NotBra,OverBodyMaskAB,OverBodyMask,OverBraMaskAB,OverBraMask,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";

        private static readonly string clothesInnerTopHeader =
            "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,OverBraType,OverBodyMaskAB,OverBodyMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";

        private static readonly string clothesInnerBottomHeader =
            "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";

        private static readonly string clothesSubHeader =
            "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,ThumbAB,ThumbTex";

        private static readonly string headHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,ShapeAnime,MatData,Preset,ThumbAB,ThumbTex";
        private static readonly string itemHeader = "ID,BigCategory,MidCategory,Name,Manifest,Bundle,Object,Child,IsAnime,IsColor,柄,IsColor2,柄,IsColor3,柄,拡縮判定,Emission";
        private static readonly string skinDiffGlossHeader = "ID,Kind,Possess,Name,EN_US,MainAB,AddTex,GlossTex,ThumbAB,ThumbTex";
        private static readonly string skinDiffHeader = "ID,Kind,Possess,Name,EN_US,MainAB,AddTex,ThumbAB,ThumbTex";
        private static readonly string skinDiffMainHeader = "ID,Kind,Possess,Name,EN_US,MainAB,MainTex,ThumbAB,ThumbTex";
        private static readonly string skinDetailHeader = "ID,Kind,Possess,Name,EN_US,MainAB,OcclusionMapTex,NormalMapTex,ThumbAB,ThumbTex";
        private static readonly string skinFaceHeader = "ID,HeadID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainTex,OcclusionMapTex,NormalMapTex,ThumbAB,ThumbTex";

        private static readonly string animeHeader =
            "ダンス,,,,,,,,アイテム,,,ベースアニメーター,,アニメーター,,付けるところ\n表示順番,管理番号,大きい項目,中間項目,表示名,バンドルパス,ファイル名,クリップ名,バンドル,ファイル,マニフェスト,バンドル,ファイル,バンドル,ファイル,親,親のスケール影響受けるか,アニメ同期";

        private static readonly string[] hairKeys =
            {"index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "mesh-b", "weights", "ringoff", "manifest", "tex-a", "tex-b", "set-hair", "thumb"};

        private static readonly string[] accKeys = {"indeX", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "parent", "thumb"};
        private static readonly string[] accHeadKeys = {"index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "manifest", "tex-a", "tex-b", "parent", "thumb"};

        private static readonly string[] clothesTopKeys =
        {
            "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "coordinate", "no-bra", "bodymask-tex", "bramask-tex", "breakmask-tex", "innermask-tb-tex",
            "innermask-b-tex", "panstmask-tex", "bodymask-b-tex", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "tex-main3", "tex-mask3", "hide-bottom", "thumb"
        };

        private static readonly string[] clothesBottomKeys =
        {
            "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "breakmask-tex", "innermask-tb-tex", "innermask-b-tex", "panstmask-tex", "bodymask-b-tex",
            "tex-main", "tex-mask", "tex-main2", "tex-mask2", "tex-main3", "tex-mask3", "hide-bottom", "thumb"
        };

        private static readonly string[] clothesInnerTopKeys =
        {
            "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "coordinate", "overbra-type", "bodymask-tex", "tex-main", "tex-mask", "tex-main2",
            "tex-mask2",
            "hide-bottom", "thumb"
        };

        private static readonly string[] clothesInnerBottomKeys =
            {"index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "hide-bottom", "thumb"};

        private static readonly string[] clothesKeys =
            {"index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "thumb"};

        private static readonly string[] skinDiffGlossKeys = {"index", "kind", "possess", "name", "en_us", "tex-a", "tex-g", "thumb"};
        private static readonly string[] skinDiffKeys = {"index", "kind", "possess", "name", "en_us", "tex-a", "thumb"};
        private static readonly string[] skinDetailKeys = {"index", "kind", "possess", "name", "en_us", "tex-a", "tex-n", "thumb"};
        private static readonly string[] skinFaceKeys = {"index", "head-id", "kind", "possess", "name", "en_us", "manifest", "tex-a", "tex-o", "tex-n", "thumb"};
        private static readonly string[] headKeys = {"index", "kind", "possess", "name", "en_us", "manifest", "head-object", "shape-anime", "mat-data", "preset", "thumb"};
        private static readonly string[] animeKeys = {"anime-index", "big-category", "mid-category", "name", "anime-controller", "anime", "anime-null"}; //,  

        public static Dictionary<string, ListType> listTypeInfo = new Dictionary<string, ListType>
        {
            // Studio NEO
            {"map", new ListType("-5", "", "MAPMOD,,,\nMAPMOD,,,", new[] {"index", "name", "scene", "manifest"})},
            {"bigcategory", new ListType("-1", "", "ID,Name", new[] {"id", "name"})},
            {"midcategory", new ListType("-2", "", "ID,Name", new[] {"id", "name"})},
            {"studioitem", new ListType("-3", "", itemHeader, new[] {"index", "big-category", "mid-category", "name", "manifest", "object"})}, // ✅ TESTED AND PROVEN
            {"studiobones", new ListType("-5", "", "ID,Bones", new[] {"index", "bones"})},
            // Animations
            {"anime", new ListType("-1", "", animeHeader, animeKeys)},
            //{ "anime", new ListType("-10", "", animeHeader, animeKeys)},
            // Male Parts
            {"mhead", new ListType("110", "abdata\\list\\characustom\\00\\mo_head_00.csv", headHeader, headKeys)}, // ❎ NOT DONE
            {"mskinf", new ListType("111", "abdata\\list\\characustom\\00\\mt_skin_f_00.csv", skinFaceHeader, skinFaceKeys)}, // ❎ NOT DONE
            {"mdetailf", new ListType("112", "abdata\\list\\characustom\\00\\mt_detail_f_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
            {"mbeard", new ListType("121", "abdata\\list\\characustom\\00\\mt_beard_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
            {"mskinb", new ListType("131", "abdata\\list\\characustom\\00\\mt_skin_b_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
            {"mdetailb", new ListType("132", "abdata\\list\\characustom\\00\\mt_detail_b_00.csv", skinDetailHeader, skinDetailKeys)}, // ❎ NOT DONE
            {"msunburn", new ListType("133", "abdata\\list\\characustom\\00\\mt_sunburn_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
            //// Male Clothes
            {"mtop", new ListType("140", "abdata\\list\\characustom\\00\\mo_top_00.csv", clothesTopHeader, clothesTopKeys)}, // ❎ NOT DONE - not working
            {"mbottom", new ListType("141", "abdata\\list\\characustom\\00\\mo_bot_00.csv", clothesBottomHeader, clothesBottomKeys)}, // ❎ NOT DONE - not working
            {"mgloves", new ListType("144", "abdata\\list\\characustom\\00\\mo_gloves_00.csv", clothesSubHeader, clothesKeys)}, // ❎ NOT DONE - not working
            {"mshoes", new ListType("147", "abdata\\list\\characustom\\00\\mo_shoes_00.csv", clothesSubHeader, clothesKeys)}, // ❎ NOT DONE - not working
            ////Female Parts
            {"fhead", new ListType("210", "abdata\\list\\characustom\\00\\fo_head_00.csv", headHeader, headKeys)}, // ❎ NOT DONE
            {"fskinf", new ListType("211", "abdata\\list\\characustom\\00\\ft_skin_f_00.csv", skinFaceHeader, skinFaceKeys)}, // Not Tested
            {"fdetailf", new ListType("212", "abdata\\list\\characustom\\00\\ft_detail_f_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"fskinb", new ListType("231", "abdata\\list\\characustom\\00\\ft_skin_b_00.csv", skinDiffMainHeader, skinDiffKeys)}, // Not Tested
            {"fdetailb", new ListType("232", "abdata\\list\\characustom\\00\\ft_detail_b_00.csv", skinDetailHeader, skinDetailKeys)}, // Not Tested
            {"fsunburn", new ListType("233", "abdata\\list\\characustom\\00\\ft_sunburn_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            //Female Clothes
            {"ftop", new ListType("240", "abdata\\list\\characustom\\00\\fo_top_00.csv", clothesTopHeader, clothesTopKeys)}, // ✅ TESTED AND PROVEN
            {"fbottom", new ListType("241", "abdata\\list\\characustom\\00\\fo_bot_00.csv", clothesBottomHeader, clothesBottomKeys)}, // ✅ TESTED AND PROVEN
            {"fintop", new ListType("242", "abdata\\list\\characustom\\00\\fo_inner_t_00.csv", clothesInnerTopHeader, clothesInnerTopKeys)}, // ✅ TESTED AND PROVEN
            {"finbottom", new ListType("243", "abdata\\list\\characustom\\00\\fo_inner_b_00.csv", clothesInnerBottomHeader, clothesInnerBottomKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"fgloves", new ListType("244", "abdata\\list\\characustom\\00\\fo_gloves_00.csv", clothesSubHeader, clothesKeys)}, // ✅ TESTED AND PROVEN
            {"fpanst", new ListType("245", "abdata\\list\\characustom\\00\\fo_panst_00.csv", clothesInnerBottomHeader, clothesInnerBottomKeys)}, // ✅ TESTED AND PROVEN
            {"fsocks", new ListType("246", "abdata\\list\\characustom\\00\\fo_socks_00.csv", clothesSubHeader, clothesKeys)}, // ✅ TESTED AND PROVEN
            {"fshoes", new ListType("247", "abdata\\list\\characustom\\00\\fo_shoes_00.csv", clothesSubHeader, clothesKeys)}, // ✅ TESTED AND PROVEN
            ////Skin Options
            {"spaint", new ListType("313", "abdata\\list\\characustom\\00\\st_paint_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ✅ TESTED AND PROVEN
            {"seyebrow", new ListType("314", "abdata\\list\\characustom\\00\\st_eyebrow_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"seyelash", new ListType("315", "abdata\\list\\characustom\\00\\st_eyelash_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"seyeshadow", new ListType("316", "abdata\\list\\characustom\\00\\st_eyeshadow_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"seye", new ListType("317", "abdata\\list\\characustom\\00\\st_eye_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"seyeblack", new ListType("318", "abdata\\list\\characustom\\00\\st_eyeblack_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"seye_hl", new ListType("319", "abdata\\list\\characustom\\00\\st_eye_hl_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"scheek", new ListType("320", "abdata\\list\\characustom\\00\\st_cheek_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"slip", new ListType("322", "abdata\\list\\characustom\\00\\st_lip_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"smole", new ListType("323", "abdata\\list\\characustom\\00\\st_mole_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"snip", new ListType("334", "abdata\\list\\characustom\\00\\st_nip_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"sunderhair", new ListType("335", "abdata\\list\\characustom\\00\\st_underhair_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            {"spattern", new ListType("348", "abdata\\list\\characustom\\00\\st_pattern_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
            //Accessory
            {"accnone", new ListType("350", "abdata\\list\\characustom\\00\\ao_none_00.csv", accessoryHeader, accKeys)}, // DO NOT USE THIS
            {"acchead", new ListType("351", "abdata\\list\\characustom\\00\\ao_head_00.csv", accessoryHeadHeader, accHeadKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accear", new ListType("352", "abdata\\list\\characustom\\00\\ao_ear_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accglasses", new ListType("353", "abdata\\list\\characustom\\00\\ao_glasses_00.csv", accessoryHeader, accKeys)}, // ✅ TESTED AND PROVEN
            {"accface", new ListType("354", "abdata\\list\\characustom\\00\\ao_face_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accneck", new ListType("355", "abdata\\list\\characustom\\00\\ao_neck_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accshoulder", new ListType("356", "abdata\\list\\characustom\\00\\ao_shoulder_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accchest", new ListType("357", "abdata\\list\\characustom\\00\\ao_chest_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accwaist", new ListType("358", "abdata\\list\\characustom\\00\\ao_waist_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accback", new ListType("359", "abdata\\list\\characustom\\00\\ao_back_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accarm", new ListType("360", "abdata\\list\\characustom\\00\\ao_arm_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"acchand", new ListType("361", "abdata\\list\\characustom\\00\\ao_hand_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"accleg", new ListType("362", "abdata\\list\\characustom\\00\\ao_leg_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"acckokan", new ListType("363", "abdata\\list\\characustom\\00\\ao_kokan_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            //Hair Items
            {"hairback", new ListType("300", "abdata\\list\\characustom\\00\\fo_hair_back_00.csv", hairHeader, hairKeys)}, // ✅ TESTED AND PROVEN
            {"hairfront", new ListType("301", "abdata\\list\\characustom\\00\\fo_hair_front_00.csv", hairHeader, hairKeys)}, // ✅ TESTED AND PROVEN
            {"hairside", new ListType("302", "abdata\\list\\characustom\\00\\fo_hair_side_00.csv", hairHeader, hairKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
            {"hairext", new ListType("303", "abdata\\list\\characustom\\00\\fo_hair_option_00.csv", hairHeader, hairKeys)} // ❔ SHOULD WORK DIDN'T TESTED
        };

        public string buffer = "";
        public string listPath;
        public ModPacker.ModPackInfo packData;

        public ListType typeInfo;
        public string typeString;
        public bool valid;

        public CSVBuilder(string typeString, ModPacker.ModPackInfo packData)
        {
            this.typeString = typeString;
            listTypeInfo.TryGetValue(typeString, out typeInfo);
            this.packData = packData;
        }

        public CSVBuilder(string typeString, string path, ModPacker.ModPackInfo packData)
        {
            this.typeString = typeString;
            listTypeInfo.TryGetValue(typeString, out typeInfo);
            listPath = path;
            this.packData = packData;
        }

        public void Generate(IEnumerable<XElement> items)
        {
            if (typeInfo == null)
            {
                Debug.LogError($"Type \"{typeString}\" is an invalid CSV builder type.");
                return;
            }

            buffer = typeInfo.GenerateHeader();
            var index = 0;
            foreach (var item in items)
            {
                buffer += typeInfo.GetLine(index, item, this);
                index++;
            }

            valid = true;
        }
    }
}
#endif