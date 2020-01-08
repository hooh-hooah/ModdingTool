using System;
using System.Collections.Generic;
using System.Linq;
using System.Xml.Linq;
using Debug = UnityEngine.Debug;

public class ListType {
    public List<string> studioKeys = new List<string>() { "-1", "-2", "-3", "-5" };
    public string catNum = "";
    public string headerText = "";
    public string[] keys;
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
        this.keys = new string[0];
    }

    public ListType(string catNum, string listPath, string headerText, string[] keys) {
        this.catNum = catNum;
        this.listPath = listPath;
        this.headerText = headerText;
        this.keys = keys;
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

    public string GetLine(int index, XElement item, CSVBuilder instance) {
        string buffer = "";

        foreach (var key in keys) {
            try {
                AutoCSVKeys.KeyDelegate spcKey;
                if (AutoCSVKeys.specialKeys.TryGetValue(key, out spcKey)) {
                    buffer += spcKey(index, key, item.Attribute(key) != null ? item.Attribute(key).Value : "0", item, instance);
                } else {
                    buffer += (item.Attribute(key) != null ? item.Attribute(key).Value : "0") + ",";
                }
            } catch (Exception e) {
                Debug.LogError(string.Format("An Error Occured while getting values from mod.xml : {0}", key));
                Debug.LogWarning(e);
            }

        }
        buffer = buffer.Substring(0, buffer.Length - 1); // fucker

        buffer += "\n";
        return buffer;
    }
}

public class AutoCSVKeys {
    public delegate string KeyDelegate(int index, string key, string parameter, XElement item, CSVBuilder instance);

    private static string GetBundleFromAsset(int index, string key, string assetName, XElement item, CSVBuilder instance) {
        string bundleName = "0";

        string[][] assetNames = instance.packData.assetNames;
        string[] bundleNames = instance.packData.assetBundleNames;

        for (int i = 0; i < bundleNames.Length; i++)
            foreach (string name in assetNames[i]) 
                if (name.Contains(assetName)) 
                    bundleName = bundleNames[i];

        //Debug.Log(string.Format("{0}: {1}", key, bundleName));
        if (bundleName == "0") {
            try {
                int dashIndex = key.LastIndexOf('-') < 0 ? key.Length : key.LastIndexOf('-');
                string bundleKey = key.Substring(0, dashIndex) + "-bundle";
                Debug.Log(bundleKey);
                bundleName = item.Attribute(bundleKey) != null ? item.Attribute(bundleKey).Value : "0";
            } catch (Exception e) {
                Debug.LogWarning("Could not catch shits.");
            }
        }

        return string.Format("{0},{1},", bundleName, assetName);
    }

    private static string InsertIndex(int index, string key, string parameter, XElement item, CSVBuilder instance) {
        return index.ToString() + ",";
    }
    private static string InsertNull(int index, string key, string parameter, XElement item, CSVBuilder instance) {
        return "0,";
    }

    private static string InsertManifest(int index, string key, string parameter, XElement item, CSVBuilder instance) {
        return "abdata,";
    }

    public static Dictionary<string, KeyDelegate> specialKeys = new Dictionary<string, KeyDelegate>() {
        {"scene", new KeyDelegate(GetBundleFromAsset)},
        {"object", new KeyDelegate(GetBundleFromAsset)},
        {"thumb", new KeyDelegate(GetBundleFromAsset)},
        {"mesh-a", new KeyDelegate(GetBundleFromAsset)},
        {"tex-a", new KeyDelegate(GetBundleFromAsset)},
        {"bodymask-tex", new KeyDelegate(GetBundleFromAsset)},
        {"bramask-tex", new KeyDelegate(GetBundleFromAsset)},
        {"innermask-tb-tex", new KeyDelegate(GetBundleFromAsset)},
        {"innermask-b-tex", new KeyDelegate(GetBundleFromAsset)},
        {"panstmask-tex", new KeyDelegate(GetBundleFromAsset)},
        {"bodymask-b-tex", new KeyDelegate(GetBundleFromAsset)},
        {"manifest", new KeyDelegate(InsertManifest)},
        {"index", new KeyDelegate(InsertIndex)},
        {"set-hair", new KeyDelegate(InsertNull)},
        {"en-us", new KeyDelegate(InsertNull)}
    };
}

public class CSVBuilder {
    // Okay I'll manage this later, do not bash me for this shit!
    static string hairHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,MainData02,Weights,RingOff,TexManifest,TexAB,TexD,TexC,SetHair,ThumbAB,ThumbTex";
    static string accessoryHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,Parent,ThumbAB,ThumbTex";
    static string accessoryHeadHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,TexManifest,TexAB,TexD,TexC,Parent,ThumbAB,ThumbTex";
    static string clothesBottomHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";
    static string clothesTopHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,NotBra,OverBodyMaskAB,OverBodyMask,OverBraMaskAB,OverBraMask,BreakDisableMask,OverInnerTBMaskAB,OverInnerTBMask,OverInnerBMaskAB,OverInnerBMask,OverPanstMaskAB,OverPanstMask,OverBodyBMaskAB,OverBodyBMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,MainTex03,ColorMask03Tex,KokanHide,ThumbAB,ThumbTex";
    static string clothesInnerTopHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,Coordinate,OverBraType,OverBodyMaskAB,OverBodyMask,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";
    static string clothesInnerBottomHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,KokanHide,ThumbAB,ThumbTex";
    static string clothesSubHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,StateType,MainTex,ColorMaskTex,MainTex02,ColorMask02Tex,ThumbAB,ThumbTex";
    static string headHeader = "ID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainData,ShapeAnime,MatData,Preset,ThumbAB,ThumbTex";
    static string itemHeader = "ID,BigCategory,MidCategory,Name,Manifest,Bundle,Object,Child,IsAnime,IsColor,柄,IsColor2,柄,IsColor3,柄,拡縮判定,Emission";
    static string skinDiffGlossHeader = "ID,Kind,Possess,Name,EN_US,MainAB,AddTex,GlossTex,ThumbAB,ThumbTex";
    static string skinDiffHeader = "ID,Kind,Possess,Name,EN_US,MainAB,AddTex,ThumbAB,ThumTex";
    static string skinDetailHeader = "ID,Kind,Possess,Name,EN_US,MainAB,OcclusionMapTex,NormalMapTex,ThumbAB,ThumbTex";
    static string skinFaceHeader = "ID,HeadID,Kind,Possess,Name,EN_US,MainManifest,MainAB,MainTex,OcclusionMapTex,NormalMapTex,ThumbAB,ThumbTex";

    static string[] hairKeys = new string[] {"index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "mesh-b", "weights", "ringoff", "manifest", "tex-a", "tex-b", "set-hair", "thumb"};
    static string[] accKeys = new string[] { "indeX", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "parent", "thumb" };
    static string[] accHeadKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "manifest", "tex-a", "tex-b", "parent", "thumb" };
    static string[] clothesTopKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "coordinate", "no-bra", "bodymask-tex", "bramask-tex", "breakmask-tex", "innermask-tb-tex", "innermask-b-tex", "panstmask-tex", "bodymask-b-tex", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "tex-main3", "tex-mask3", "hide-bottom", "thumb"  };
    static string[] clothesBottomKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "breakmask-tex", "innermask-tb-tex", "innermask-b-tex", "panstmask-tex", "bodymask-b-tex", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "tex-main3", "tex-mask3", "hide-bottom", "thumb" };
    static string[] clothesInnerTopKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "coordinate", "overbra-type", "bodymask-tex", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "hide-bottom", "thumb" };
    static string[] clothesInnerBottomKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "hide-bottom", "thumb" };
    static string[] clothesKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "mesh-a", "state", "tex-main", "tex-mask", "tex-main2", "tex-mask2", "thumb" };
    static string[] skinDiffGlossKeys = new string[] { "index", "kind", "possess", "name", "en_us", "tex-a", "tex-g", "thumb" };                                                                                        
    static string[] skinDiffKeys = new string[] { "index", "kind", "possess", "name", "en_us", "tex-a", "thumb" };
    static string[] skinDetailKeys = new string[] { "index", "kind", "possess", "name", "en_us", "tex-a", "tex-n", "thumb"  };
    static string[] skinFaceKeys = new string[] { "index", "head-id", "kind", "possess", "name", "en_us", "manifest", "tex-a", "tex-o", "tex-n", "thumb" };
    static string[] headKeys = new string[] { "index", "kind", "possess", "name", "en_us", "manifest", "head-object", "shape-anime", "mat-data", "preset", "thumb"};
    
    public static Dictionary<string, ListType> listTypeInfo = new Dictionary<string, ListType>() {
        // Studio NEO
        { "map", new ListType("-5", "","MAPMOD,,,\nMAPMOD,,,", new string[] {"index", "name", "scene"} )},
        { "bigcategory", new ListType("-1", "", "ID,Name", new string[] {"id", "name"} )},
        { "midcategory", new ListType("-2", "", "ID,Name", new string[] {"id", "name"} )},
        { "studioitem", new ListType("-3", "", itemHeader, new string[] {"index", "big-category", "mid-category", "name", "manifest", "object" } ) }, // ✅ TESTED AND PROVEN
        // Male Parts
        { "mhead", new ListType("110", "abdata\\list\\characustom\\00\\mo_head_00.csv", headHeader, headKeys)}, // ❎ NOT DONE
        { "mskinf", new ListType("111", "abdata\\list\\characustom\\00\\mt_skin_f_00.csv", skinFaceHeader, skinFaceKeys)}, // ❎ NOT DONE
        { "mdetailf", new ListType("112", "abdata\\list\\characustom\\00\\mt_detail_f_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
        { "mbeard", new ListType("121", "abdata\\list\\characustom\\00\\mt_beard_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
        { "mskinb", new ListType("131", "abdata\\list\\characustom\\00\\mt_skin_b_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
        { "mdetailb", new ListType("132", "abdata\\list\\characustom\\00\\mt_detail_b_00.csv", skinDetailHeader, skinDetailKeys)}, // ❎ NOT DONE
        { "msunburn", new ListType("133", "abdata\\list\\characustom\\00\\mt_sunburn_00.csv", skinDiffHeader, skinDiffKeys)}, // ❎ NOT DONE
        //// Male Clothes
        { "mtop", new ListType("140", "abdata\\list\\characustom\\00\\mo_top_00.csv", clothesTopHeader, clothesTopKeys)}, // ❎ NOT DONE - not working
        { "mbottom", new ListType("141", "abdata\\list\\characustom\\00\\mo_bot_00.csv", clothesBottomHeader, clothesBottomKeys)}, // ❎ NOT DONE - not working
        { "mgloves", new ListType("144", "abdata\\list\\characustom\\00\\mo_gloves_00.csv", clothesSubHeader, clothesKeys)}, // ❎ NOT DONE - not working
        { "mshoes", new ListType("147", "abdata\\list\\characustom\\00\\mo_shoes_00.csv", clothesSubHeader, clothesKeys)}, // ❎ NOT DONE - not working
        ////Female Parts
        { "fhead", new ListType("210", "abdata\\list\\characustom\\00\\fo_head_00.csv", headHeader, headKeys)}, // ❎ NOT DONE
        { "fskinf", new ListType("211", "abdata\\list\\characustom\\00\\ft_skin_f_00.csv", skinFaceHeader, skinFaceKeys)}, // Not Tested
        { "fdetailf", new ListType("212", "abdata\\list\\characustom\\00\\ft_detail_f_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "fskinb", new ListType("231", "abdata\\list\\characustom\\00\\ft_skin_b_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "fdetailb ", new ListType("232", "abdata\\list\\characustom\\00\\ft_detail_b_00.csv", skinDetailHeader, skinDetailKeys)}, // Not Tested
        { "fsunburn", new ListType("233", "abdata\\list\\characustom\\00\\ft_sunburn_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        //Female Clothes
        { "ftop", new ListType("240", "abdata\\list\\characustom\\00\\fo_top_00.csv", clothesTopHeader, clothesTopKeys)}, // ✅ TESTED AND PROVEN
        { "fbottom", new ListType("241", "abdata\\list\\characustom\\00\\fo_bot_00.csv", clothesBottomHeader, clothesBottomKeys)}, // ✅ TESTED AND PROVEN
        { "fintop", new ListType("242", "abdata\\list\\characustom\\00\\fo_inner_t_00.csv", clothesInnerTopHeader, clothesInnerTopKeys)}, // ✅ TESTED AND PROVEN
        { "finbottom", new ListType("243", "abdata\\list\\characustom\\00\\fo_inner_b_00.csv", clothesInnerBottomHeader, clothesInnerBottomKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "fgloves", new ListType("244", "abdata\\list\\characustom\\00\\fo_gloves_00.csv", clothesSubHeader, clothesKeys)},  // ✅ TESTED AND PROVEN
        { "fpanst", new ListType("245", "abdata\\list\\characustom\\00\\fo_panst_00.csv", clothesInnerBottomHeader, clothesInnerBottomKeys)}, // ✅ TESTED AND PROVEN
        { "fsocks", new ListType("246", "abdata\\list\\characustom\\00\\fo_socks_00.csv", clothesSubHeader, clothesKeys)}, // ✅ TESTED AND PROVEN
        { "fshoes", new ListType("247", "abdata\\list\\characustom\\00\\fo_shoes_00.csv", clothesSubHeader, clothesKeys)},  // ✅ TESTED AND PROVEN
        ////Skin Options
        { "spaint", new ListType("313", "abdata\\list\\characustom\\00\\st_paint_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ✅ TESTED AND PROVEN
        { "seyebrow", new ListType("314", "abdata\\list\\characustom\\00\\st_eyebrow_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "seyelash", new ListType("315", "abdata\\list\\characustom\\00\\st_eyelash_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "seyeshadow", new ListType("316", "abdata\\list\\characustom\\00\\st_eyeshadow_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "seye", new ListType("317", "abdata\\list\\characustom\\00\\st_eye_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "seyeblack", new ListType("318", "abdata\\list\\characustom\\00\\st_eyeblack_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "seye_hl", new ListType("319", "abdata\\list\\characustom\\00\\st_eye_hl_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "scheek", new ListType("320", "abdata\\list\\characustom\\00\\st_cheek_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "slip", new ListType("322", "abdata\\list\\characustom\\00\\st_lip_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "smole", new ListType("323", "abdata\\list\\characustom\\00\\st_mole_00.csv", skinDiffGlossHeader, skinDiffGlossKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "snip", new ListType("334", "abdata\\list\\characustom\\00\\st_nip_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "sunderhair", new ListType("335", "abdata\\list\\characustom\\00\\st_underhair_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        { "spattern", new ListType("348", "abdata\\list\\characustom\\00\\st_pattern_00.csv", skinDiffHeader, skinDiffKeys)}, // Not Tested
        //Accessory
        { "accnone", new ListType("350", "abdata\\list\\characustom\\00\\ao_none_00.csv", accessoryHeader, accKeys)}, // DO NOT USE THIS
        { "acchead", new ListType("351", "abdata\\list\\characustom\\00\\ao_head_00.csv", accessoryHeadHeader, accHeadKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accear", new ListType("352", "abdata\\list\\characustom\\00\\ao_ear_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accglasses", new ListType("353", "abdata\\list\\characustom\\00\\ao_glasses_00.csv", accessoryHeader, accKeys)}, // ✅ TESTED AND PROVEN
        { "accface", new ListType("354", "abdata\\list\\characustom\\00\\ao_face_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accneck", new ListType("355", "abdata\\list\\characustom\\00\\ao_neck_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accshoulder", new ListType("356", "abdata\\list\\characustom\\00\\ao_shoulder_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accchest", new ListType("357", "abdata\\list\\characustom\\00\\ao_chest_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accwaist", new ListType("358", "abdata\\list\\characustom\\00\\ao_waist_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accback", new ListType("359", "abdata\\list\\characustom\\00\\ao_back_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accarm", new ListType("360", "abdata\\list\\characustom\\00\\ao_arm_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "acchand", new ListType("361", "abdata\\list\\characustom\\00\\ao_hand_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "accleg", new ListType("362", "abdata\\list\\characustom\\00\\ao_leg_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "acckokan", new ListType("363", "abdata\\list\\characustom\\00\\ao_kokan_00.csv", accessoryHeader, accKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        //Hair Items
        { "hairback", new ListType("300", "abdata\\list\\characustom\\00\\fo_hair_back_00.csv", hairHeader, hairKeys)}, // ✅ TESTED AND PROVEN
        { "hairfront", new ListType("301", "abdata\\list\\characustom\\00\\fo_hair_front_00.csv", hairHeader, hairKeys)}, // ✅ TESTED AND PROVEN
        { "hairside", new ListType("302", "abdata\\list\\characustom\\00\\fo_hair_side_00.csv", hairHeader, hairKeys)}, // ❔ SHOULD WORK DIDN'T TESTED
        { "hairext", new ListType("303", "abdata\\list\\characustom\\00\\fo_hair_option_00.csv", hairHeader, hairKeys)} // ❔ SHOULD WORK DIDN'T TESTED
    };

    public ListType typeInfo;
    public string typeString;
    public string buffer = "";
    public bool valid = false;
    public string listPath;
    public ModPacker.ModPackInfo packData;

    public CSVBuilder(string typeString, ModPacker.ModPackInfo packData) {
        this.typeString = typeString;
        listTypeInfo.TryGetValue(typeString, out typeInfo);
        this.packData = packData;
    }

    public CSVBuilder(string typeString, string path, ModPacker.ModPackInfo packData) {
        this.typeString = typeString;
        listTypeInfo.TryGetValue(typeString, out typeInfo);
        listPath = path;
        this.packData = packData;
    }

    public void Generate(IEnumerable<XElement> items) {
        if (typeInfo == null) {
            Debug.LogError(string.Format("Type \"{0}\" is an invalid CSV builder type.", typeString));
            return;
        }

        buffer = typeInfo.GenerateHeader();
        int index = 0;
        foreach (var item in items) {
            buffer += typeInfo.GetLine(index, item, this);
            index++;
        }

        valid = true;
    }
}