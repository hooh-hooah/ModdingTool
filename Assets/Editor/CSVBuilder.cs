using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using Debug = UnityEngine.Debug;

public class ListType {
    public List<string> studioKeys = new List<string>() { "-1", "-2", "-3", "-5" };
    public string catNum = "";
    public string headerText = "";

    public delegate string GeneratorDelegate(int index, XElement item);

    public GeneratorDelegate Generate;

    public bool isStudioMod {
        get {
            return studioKeys.Contains(catNum);
        }
    }

    public string listPath;

    private static Random random = new Random();

    public static string RandomString(int length) {
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }

    public ListType(string catNum, string listPath, string headerText) {
        this.catNum = catNum;
        this.listPath = listPath;
        this.headerText = headerText;
    }

    public ListType(string catNum, string listPath, string headerText, GeneratorDelegate func) {
        this.catNum = catNum;
        this.listPath = listPath;
        this.headerText = headerText;
        this.Generate = func;
    }

    public string GenerateHeader() {
        string buffer = "";

        if (!isStudioMod) {
            buffer += catNum + "\n";
            buffer += "0\n";
            buffer += (RandomString(32) + "\n");
        }
        buffer += (headerText + "\n");

        return buffer;
    }

    public string GetLine(int index, XElement item) {
        string buffer = "";

        if (Generate != null) {
            buffer = Generate(index, item);
        } else {
            buffer = "DELEGATE IS MISSING!";
        }

        buffer += "\n";
        return buffer;
    }
}

public class CSVBuilder {
    // Okay I'll manage this later, do not bash me for this shit!
    private static string hairHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,MainData02,Weights,RingOff,TexManifest,TexAB,TexD,TexC,SetHair,ThumbAB,ThumbTex";
    private static string accessoryHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,Parent,ThumbAB,ThumbTex";
    private static string accessoryHeadHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,TexManifest,TexAB,TexD,TexC,Parent,ThumbAB,ThumbTex";
    private static string clothesBottomHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";
    private static string clothesTopHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,NotBra,OverBodyMaskAB,OverBodyMask,OverBraMaskAB,OverBraMask,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";
    private static string clothesInnerTopHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,OverBraType,OverBodyMaskAB,OverBodyMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";
    private static string clothesInnerBottomHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";
    private static string clothesSubHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,ThumbAB,ThumbTex";
    private static string headHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,ShapeAnime,MatData,Preset,ThumbAB,ThumbTex";
 
    // TODO: Make Delegates giving proper error messages!
    // TODO: Convert these to TryGenerate(int, XElement, out string) 
    private static string AccessoryDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a", "parent", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }
    private static string AccessoryHeadDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a",
            "tex-manifest", "tex-bundle", "tex-a", "tex-b", "parent", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }

    private static string ClothesTopDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a", "state",
            "coordinate", "no-bra", "bodymask-bundle", "bodymask-tex", "bramask-bundle", "bramask-tex", "breakmask-tex",
            "innermask-tb-bundle", "innermask-tb-tex", "innermask-b-bundle", "innermask-b-tex",
            "panstmask-bundle", "panstmask-tex", "bodymask-b-bundle", "bodymask-b-tex",
            "tex-main", "tex-mask", "tex-main2", "tex-mask2", "tex-main3", "tex-mask3", "hide-bottom", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }

    private static string ClothesBottomDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a", "state",
            "breakmask-tex", "innermask-tb-bundle", "innermask-tb-tex", "innermask-b-bundle", "innermask-b-tex",
            "panstmask-bundle", "panstmask-tex", "bodymask-b-bundle", "bodymask-b-tex",
            "tex-main", "tex-mask", "tex-main2", "tex-mask2", "tex-main3", "tex-mask3", "hide-bottom", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }
    private static string ClothesInnerTopDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a", "state",
            "coordinate", "overbra-type", "bodymask-bundle", "bodymask-tex",
            "tex-main", "tex-mask", "tex-main2", "tex-mask2", "hide-bottom", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }
    private static string ClothesInnerBottomDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a", "state",
            "tex-main", "tex-mask", "tex-main2", "tex-mask2", "hide-bottom", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }
    private static string ClothesSubDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a",
            "state", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "thumb-bundle", "thumb"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }
    private static string HairDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] {
            "kind", "possess", "name", "en_us", "mesh-manifest", "mesh-bundle", "mesh-a", "mesh-b",
            "weights", "ringoff", "tex-manifest", "tex-bundle", "tex-a", "tex-b"
        }) {
            buffer += item.Attribute(key).Value + ",";
        }
        buffer += "0,";
        buffer += item.Attribute("thumb-bundle").Value + ",";
        buffer += item.Attribute("thumb").Value;
        return buffer;
    }
    private static string CategoryDelegate(int index, XElement item) {
        string buffer = "";
        buffer += item.Attribute("id").Value + ",";
        buffer += item.Attribute("name").Value + "";
        return buffer;
    }
    private static string ItemDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        foreach (var key in new string[] { "big-category", "mid-category", "name", "manifest", "bundle", "object" }) {
            buffer += item.Attribute(key).Value + ",";
        }
        return buffer;
    }
    private static string MapDelegate(int index, XElement item) {
        string buffer = "";
        buffer += index + ",";
        buffer += item.Attribute("name").Value + ",";
        buffer += item.Attribute("bundle").Value + ",";
        buffer += item.Attribute("scene").Value + ",";
        return buffer;
    }

    public static Dictionary<string, ListType> listTypeInfo = new Dictionary<string, ListType>() {
        //Lists Referenced from ChaListDefine. Not everything works atm.

        //Studio Items
        { "map", new ListType("-5", "","MAPMOD,,,\nMAPMOD,,,", new ListType.GeneratorDelegate(MapDelegate))}, // ✅ TESTED AND PROVEN
        { "bigcategory", new ListType("-1", "","ID,Name", new ListType.GeneratorDelegate(CategoryDelegate))}, // ✅ TESTED AND PROVEN
        { "midcategory", new ListType("-2", "","ID,Name", new ListType.GeneratorDelegate(CategoryDelegate))}, // ✅ TESTED AND PROVEN
        { "studioitem", new ListType("-3", "","管理番号,大きい項目,中間項目,名称,マニフェスト,バンドルパス,ファイルパス,子の接続先,アニメがあるか,色替え,柄,色替え(カラー２),柄,カラー３,柄,拡縮判定,エミッション", new ListType.GeneratorDelegate(ItemDelegate)) }, // ✅ TESTED AND PROVEN
        // FK Studioitem should add bones automatically, I guess.

        //Male Parts
        { "mhead", new ListType("110", "abdata\\list\\characustom\\00\\mo_head_00.csv", "")}, // ❎ NOT DONE
        { "mskinf", new ListType("111", "abdata\\list\\characustom\\00\\mt_skin_f_00.csv", "")}, // ❎ NOT DONE
        { "mdetailf", new ListType("112", "abdata\\list\\characustom\\00\\mt_detail_f_00.csv", "")}, // ❎ NOT DONE
        { "mbeard", new ListType("121", "abdata\\list\\characustom\\00\\mt_beard_00.csv", "")}, // ❎ NOT DONE
        { "mskinb", new ListType("131", "abdata\\list\\characustom\\00\\mt_skin_b_00.csv", "")}, // ❎ NOT DONE
        { "mdetailb", new ListType("132", "abdata\\list\\characustom\\00\\mt_detail_b_00.csv", "")}, // ❎ NOT DONE
        { "msunburn", new ListType("133", "abdata\\list\\characustom\\00\\mt_sunburn_00.csv", "")}, // ❎ NOT DONE
        // Male Clothes
        { "mtop", new ListType("140", "abdata\\list\\characustom\\00\\mo_top_00.csv", "")}, // ❎ NOT DONE
        { "mbottom", new ListType("141", "abdata\\list\\characustom\\00\\mo_bot_00.csv", "")}, // ❎ NOT DONE
        { "mgloves", new ListType("144", "abdata\\list\\characustom\\00\\mo_gloves_00.csv", "")}, // ❎ NOT DONE
        { "mshoes", new ListType("147", "abdata\\list\\characustom\\00\\mo_shoes_00.csv", "")}, // ❎ NOT DONE
        //Female Parts
        { "fhead", new ListType("210", "abdata\\list\\characustom\\00\\fo_head_00.csv", headHeader)}, // ❎ NOT DONE
        { "fskinf", new ListType("211", "abdata\\list\\characustom\\00\\ft_skin_f_00.csv", "")}, // ❎ NOT DONE
        { "fdetailf", new ListType("212", "abdata\\list\\characustom\\00\\ft_detail_f_00.csv", "")}, // ❎ NOT DONE
        { "fskinb", new ListType("231", "abdata\\list\\characustom\\00\\ft_skin_b_00.csv", "")}, // ❎ NOT DONE
        { "fdetailb ", new ListType("232", "abdata\\list\\characustom\\00\\ft_detail_b_00.csv", "")}, // ❎ NOT DONE
        { "fsunburn", new ListType("233", "abdata\\list\\characustom\\00\\ft_sunburn_00.csv", "")}, // ❎ NOT DONE
        //Skin Options
        { "spaint", new ListType("313", "abdata\\list\\characustom\\00\\st_paint_00.csv", "")}, // ❎ NOT DONE
        { "seyebrow", new ListType("314", "abdata\\list\\characustom\\00\\st_eyebrow_00.csv", "")}, // ❎ NOT DONE
        { "seyelash", new ListType("315", "abdata\\list\\characustom\\00\\st_eyelash_00.csv", "")}, // ❎ NOT DONE
        { "seyeshadow", new ListType("316", "abdata\\list\\characustom\\00\\st_eyeshadow_00.csv", "")}, // ❎ NOT DONE
        { "seye", new ListType("317", "abdata\\list\\characustom\\00\\st_eye_00.csv", "")}, // ❎ NOT DONE
        { "seyeblack", new ListType("318", "abdata\\list\\characustom\\00\\st_eyeblack_00.csv", "")}, // ❎ NOT DONE
        { "seye_hl", new ListType("319", "abdata\\list\\characustom\\00\\st_eye_hl_00.csv", "")}, // ❎ NOT DONE
        { "scheek", new ListType("320", "abdata\\list\\characustom\\00\\st_cheek_00.csv", "")}, // ❎ NOT DONE
        { "slip", new ListType("322", "abdata\\list\\characustom\\00\\st_lip_00.csv", "")}, // ❎ NOT DONE
        { "smole", new ListType("323", "abdata\\list\\characustom\\00\\st_mole_00.csv", "")}, // ❎ NOT DONE
        { "snip", new ListType("334", "abdata\\list\\characustom\\00\\st_nip_00.csv", "")}, // ❎ NOT DONE
        { "sunderhair", new ListType("335", "abdata\\list\\characustom\\00\\st_underhair_00.csv", "")}, // ❎ NOT DONE
        { "spattern", new ListType("348", "abdata\\list\\characustom\\00\\st_pattern_00.csv", "")}, // ❎ NOT DONE
        //Female Clothes
        { "ftop", new ListType("240", "abdata\\list\\characustom\\00\\fo_top_00.csv", clothesTopHeader, new ListType.GeneratorDelegate(ClothesTopDelegate))}, // ✅ TESTED AND PROVEN
        { "fbottom", new ListType("241", "abdata\\list\\characustom\\00\\fo_bot_00.csv", clothesBottomHeader, new ListType.GeneratorDelegate(ClothesBottomDelegate))}, // ✅ TESTED AND PROVEN
        { "fintop", new ListType("242", "abdata\\list\\characustom\\00\\fo_inner_t_00.csv", clothesInnerTopHeader, new ListType.GeneratorDelegate(ClothesInnerTopDelegate))}, // ✅ TESTED AND PROVEN
        { "finbottom", new ListType("243", "abdata\\list\\characustom\\00\\fo_inner_b_00.csv", clothesInnerBottomHeader, new ListType.GeneratorDelegate(ClothesInnerBottomDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "fgloves", new ListType("244", "abdata\\list\\characustom\\00\\fo_gloves_00.csv", clothesSubHeader, new ListType.GeneratorDelegate(ClothesSubDelegate))},  // ✅ TESTED AND PROVEN
        { "fpanst", new ListType("245", "abdata\\list\\characustom\\00\\fo_panst_00.csv", clothesInnerBottomHeader, new ListType.GeneratorDelegate(ClothesInnerBottomDelegate))}, // ✅ TESTED AND PROVEN
        { "fsocks", new ListType("246", "abdata\\list\\characustom\\00\\fo_socks_00.csv", clothesSubHeader, new ListType.GeneratorDelegate(ClothesSubDelegate))}, // ✅ TESTED AND PROVEN
        { "fshoes", new ListType("247", "abdata\\list\\characustom\\00\\fo_shoes_00.csv", clothesSubHeader, new ListType.GeneratorDelegate(ClothesSubDelegate))},  // ✅ TESTED AND PROVEN
        //Accessory
        { "accnone", new ListType("350", "abdata\\list\\characustom\\00\\ao_none_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // DO NOT USE THIS
        { "acchead", new ListType("351", "abdata\\list\\characustom\\00\\ao_head_00.csv", accessoryHeadHeader, new ListType.GeneratorDelegate(AccessoryHeadDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accear", new ListType("352", "abdata\\list\\characustom\\00\\ao_ear_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accglasses", new ListType("353", "abdata\\list\\characustom\\00\\ao_glasses_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ✅ TESTED AND PROVEN
        { "accface", new ListType("354", "abdata\\list\\characustom\\00\\ao_face_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accneck", new ListType("355", "abdata\\list\\characustom\\00\\ao_neck_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accshoulder", new ListType("356", "abdata\\list\\characustom\\00\\ao_shoulder_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accchest", new ListType("357", "abdata\\list\\characustom\\00\\ao_chest_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accwaist", new ListType("358", "abdata\\list\\characustom\\00\\ao_waist_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accback", new ListType("359", "abdata\\list\\characustom\\00\\ao_back_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accarm", new ListType("360", "abdata\\list\\characustom\\00\\ao_arm_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "acchand", new ListType("361", "abdata\\list\\characustom\\00\\ao_hand_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accleg", new ListType("362", "abdata\\list\\characustom\\00\\ao_leg_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "acckokan", new ListType("363", "abdata\\list\\characustom\\00\\ao_kokan_00.csv", accessoryHeader, new ListType.GeneratorDelegate(AccessoryDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        //Hair Items
        { "hairback", new ListType("300", "abdata\\list\\characustom\\00\\fo_hair_back_00.csv", hairHeader, new ListType.GeneratorDelegate(HairDelegate))}, // ✅ TESTED AND PROVEN
        { "hairfront", new ListType("301", "abdata\\list\\characustom\\00\\fo_hair_front_00.csv", hairHeader, new ListType.GeneratorDelegate(HairDelegate))}, // ✅ TESTED AND PROVEN
        { "hairside", new ListType("302", "abdata\\list\\characustom\\00\\fo_hair_side_00.csv", hairHeader, new ListType.GeneratorDelegate(HairDelegate))}, // ❔ SHOULD WORK DIDN'T TESTED
        { "hairext", new ListType("303", "abdata\\list\\characustom\\00\\fo_hair_option_00.csv", hairHeader, new ListType.GeneratorDelegate(HairDelegate))} // ❔ SHOULD WORK DIDN'T TESTED
    };

    public ListType typeInfo;
    public string typeString;
    public string buffer = "";
    public bool valid = false;
    public string listPath;

    public CSVBuilder(string typeString) {
        this.typeString = typeString;
        listTypeInfo.TryGetValue(typeString, out typeInfo);
    }

    public CSVBuilder(string typeString, string path) {
        this.typeString = typeString;
        listTypeInfo.TryGetValue(typeString, out typeInfo);
        listPath = path;
    }

    public void Generate(IEnumerable<XElement> items) {
        if (typeInfo == null) {
            Debug.LogError(string.Format("Type \"{0}\" is an invalid CSV builder type.", typeString));
            return;
        }

        buffer = typeInfo.GenerateHeader();
        int index = 0;
        foreach (var item in items) {
            buffer += typeInfo.GetLine(index, item);
            index++;
        }

        valid = true;
    }
}