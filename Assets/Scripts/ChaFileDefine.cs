using System;

namespace AIChara
{
    // Token: 0x020007EB RID: 2027
    public static class ChaFileDefine
    {
        // Token: 0x060032D5 RID: 13013 RVA: 0x0012C8D4 File Offset: 0x0012ACD4
        public static string GetBloodTypeStr(int bloodType)
        {
            string[] array = new string[]
            {
                "Ａ型",
                "Ｂ型",
                "Ｏ型",
                "ＡＢ型"
            };
            if (MathfEx.RangeEqualOn<int>(0, bloodType, array.Length - 1))
            {
                return array[bloodType];
            }
            return "不明";
        }

        // Token: 0x060032D6 RID: 13014 RVA: 0x0012C924 File Offset: 0x0012AD24
        public static string GetMonthInEnglish(int month)
        {
            string[] array = new string[]
            {
                "Jan.",
                "Feb.",
                "Mar.",
                "Apr.",
                "May",
                "June",
                "July",
                "Aug.",
                "Sept.",
                "Oct.",
                "Nov.",
                "Dec."
            };
            return array[month];
        }

        // Token: 0x0400324A RID: 12874
        public static readonly Version ChaFileVersion = new Version("0.0.0");

        // Token: 0x0400324B RID: 12875
        public static readonly Version ChaFileCustomVersion = new Version("0.0.0");

        // Token: 0x0400324C RID: 12876
        public static readonly Version ChaFileFaceVersion = new Version("0.0.1");

        // Token: 0x0400324D RID: 12877
        public static readonly Version ChaFileBodyVersion = new Version("0.0.1");

        // Token: 0x0400324E RID: 12878
        public static readonly Version ChaFileHairVersion = new Version("0.0.2");

        // Token: 0x0400324F RID: 12879
        public static readonly Version ChaFileCoordinateVersion = new Version("0.0.0");

        // Token: 0x04003250 RID: 12880
        public static readonly Version ChaFileClothesVersion = new Version("0.0.0");

        // Token: 0x04003251 RID: 12881
        public static readonly Version ChaFileAccessoryVersion = new Version("0.0.0");

        // Token: 0x04003252 RID: 12882
        public static readonly Version ChaFileParameterVersion = new Version("0.0.1");

        // Token: 0x04003253 RID: 12883
        public static readonly Version ChaFileStatusVersion = new Version("0.0.0");

        // Token: 0x04003254 RID: 12884
        public static readonly Version ChaFileGameInfoVersion = new Version("0.0.0");

        // Token: 0x04003255 RID: 12885
        public const float MaleDefaultHeight = 0.75f;

        // Token: 0x04003256 RID: 12886
        public const int AccessoryCategoryTypeNone = 120;

        // Token: 0x04003257 RID: 12887
        public const int AccessoryColorNum = 4;

        // Token: 0x04003258 RID: 12888
        public const int AccessoryCorrectNum = 2;

        // Token: 0x04003259 RID: 12889
        public const int AccessorySlotNum = 20;

        // Token: 0x0400325A RID: 12890
        public const int CustomPaintNum = 2;

        // Token: 0x0400325B RID: 12891
        public const int ParamAttributeNum = 3;

        // Token: 0x0400325C RID: 12892
        public const int ClothesColorNum = 3;

        // Token: 0x0400325D RID: 12893
        public const int ClothesMaterialNum = 3;

        // Token: 0x0400325E RID: 12894
        public const int FlavorKindNum = 8;

        // Token: 0x0400325F RID: 12895
        public const int DesireKindNum = 16;

        // Token: 0x04003260 RID: 12896
        public const int SkillSlotNum = 5;

        // Token: 0x04003261 RID: 12897
        public const float NipStandLimit = 0.8f;

        // Token: 0x04003262 RID: 12898
        public const float NipStandPlusH = 0.2f;

        // Token: 0x04003263 RID: 12899
        public const float SkinGlossLimit = 0.8f;

        // Token: 0x04003264 RID: 12900
        public const float SkinGlossPlusH = 0.2f;

        // Token: 0x04003265 RID: 12901
        public const float VoicePitchMin = 0.94f;

        // Token: 0x04003266 RID: 12902
        public const float VoicePitchMax = 1.06f;

        // Token: 0x04003267 RID: 12903
        public const string CharaFileFemaleDir = "chara/female/";

        // Token: 0x04003268 RID: 12904
        public const string CharaFileMaleDir = "chara/male/";

        // Token: 0x04003269 RID: 12905
        public const string CoordinateFileFemaleDir = "coordinate/female/";

        // Token: 0x0400326A RID: 12906
        public const string CoordinateFileMaleDir = "coordinate/male/";

        // Token: 0x0400326B RID: 12907
        public const int LoadError_Tag = -1;

        // Token: 0x0400326C RID: 12908
        public const int LoadError_Version = -2;

        // Token: 0x0400326D RID: 12909
        public const int LoadError_ProductNo = -3;

        // Token: 0x0400326E RID: 12910
        public const int LoadError_EndOfStream = -4;

        // Token: 0x0400326F RID: 12911
        public const int LoadError_OnlyPNG = -5;

        // Token: 0x04003270 RID: 12912
        public const int LoadError_FileNotExist = -6;

        // Token: 0x04003271 RID: 12913
        public const int LoadError_ETC = -999;

        // Token: 0x04003272 RID: 12914
        public const int M_DefHeadID = 0;

        // Token: 0x04003273 RID: 12915
        public const int M_DefBodyID = 0;

        // Token: 0x04003274 RID: 12916
        public const int M_DefHairBackID = 0;

        // Token: 0x04003275 RID: 12917
        public const int M_DefHairFrontID = 1;

        // Token: 0x04003276 RID: 12918
        public const int M_DefHairSideID = 0;

        // Token: 0x04003277 RID: 12919
        public const int M_DefHairOptionID = 0;

        // Token: 0x04003278 RID: 12920
        public const int M_DefClothesTopID = 0;

        // Token: 0x04003279 RID: 12921
        public const int M_DefClothesBotID = 0;

        // Token: 0x0400327A RID: 12922
        public const int M_DefClothesGlovesID = 0;

        // Token: 0x0400327B RID: 12923
        public const int M_DefClothesShoesID = 0;

        // Token: 0x0400327C RID: 12924
        public const int F_DefHeadID = 0;

        // Token: 0x0400327D RID: 12925
        public const int F_DefBodyID = 0;

        // Token: 0x0400327E RID: 12926
        public const int F_DefHairBackID = 0;

        // Token: 0x0400327F RID: 12927
        public const int F_DefHairFrontID = 1;

        // Token: 0x04003280 RID: 12928
        public const int F_DefHairSideID = 0;

        // Token: 0x04003281 RID: 12929
        public const int F_DefHairOptionID = 0;

        // Token: 0x04003282 RID: 12930
        public const int F_DefClothesTopID = 0;

        // Token: 0x04003283 RID: 12931
        public const int F_DefClothesBotID = 0;

        // Token: 0x04003284 RID: 12932
        public const int F_DefClothesInnerTID = 0;

        // Token: 0x04003285 RID: 12933
        public const int F_DefClothesInnerBID = 0;

        // Token: 0x04003286 RID: 12934
        public const int F_DefClothesGlovesID = 0;

        // Token: 0x04003287 RID: 12935
        public const int F_DefClothesPanstID = 0;

        // Token: 0x04003288 RID: 12936
        public const int F_DefClothesSocksID = 0;

        // Token: 0x04003289 RID: 12937
        public const int F_DefClothesShoesID = 0;

        // Token: 0x0400328A RID: 12938
        public static readonly string[] cf_bodyshapename = new string[]
        {
            "身長",
            "胸サイズ",
            "胸上下位置",
            "胸の左右開き",
            "胸の左右位置",
            "胸上下角度",
            "胸の尖り",
            "乳輪の膨らみ",
            "乳首太さ",
            "頭サイズ",
            "首周り幅",
            "首周り奥",
            "胴体肩周り幅",
            "胴体肩周り奥",
            "胴体上幅",
            "胴体上奥",
            "胴体下幅",
            "胴体下奥",
            "ウエスト位置",
            "腰上幅",
            "腰上奥",
            "腰下幅",
            "腰下奥",
            "尻",
            "尻角度",
            "太もも上",
            "太もも下",
            "ふくらはぎ",
            "足首",
            "肩",
            "上腕",
            "前腕",
            "乳首立ち"
        };

        // Token: 0x0400328B RID: 12939
        public static readonly int[] cf_BustShapeMaskID = new int[]
        {
            2,
            3,
            4,
            5,
            6,
            7,
            8,
            32
        };

        // Token: 0x0400328C RID: 12940
        public static readonly int[] cf_ShapeMaskBust = new int[]
        {
            0,
            1,
            2,
            3,
            4
        };

        // Token: 0x0400328D RID: 12941
        public static readonly int[] cf_ShapeMaskNip = new int[]
        {
            5,
            6
        };

        // Token: 0x0400328E RID: 12942
        public const int cf_ShapeMaskNipStand = 7;

        // Token: 0x0400328F RID: 12943
        public static readonly float[] cf_bodyInitValue = new float[]
        {
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0f
        };

        // Token: 0x04003290 RID: 12944
        public static readonly string[] cf_headshapename = new string[]
        {
            "顔全体横幅",
            "顔上部前後",
            "顔上部上下",
            "顔下部前後",
            "顔下部横幅",
            "顎横幅",
            "顎上下",
            "顎前後",
            "顎角度",
            "顎下部上下",
            "顎先幅",
            "顎先上下",
            "顎先前後",
            "頬下部上下",
            "頬下部前後",
            "頬下部幅",
            "頬上部上下",
            "頬上部前後",
            "頬上部幅",
            "目上下",
            "目横位置",
            "目前後",
            "目の横幅",
            "目の縦幅",
            "目の角度Z軸",
            "目の角度Y軸",
            "目頭左右位置",
            "目尻左右位置",
            "目頭上下位置",
            "目尻上下位置",
            "まぶた形状１",
            "まぶた形状２",
            "鼻全体上下",
            "鼻全体前後",
            "鼻全体角度X軸",
            "鼻全体横幅",
            "鼻筋高さ",
            "鼻筋横幅",
            "鼻筋形状",
            "小鼻横幅",
            "小鼻上下",
            "小鼻前後",
            "小鼻角度X軸",
            "小鼻角度Z軸",
            "鼻先高さ",
            "鼻先角度X軸",
            "鼻先サイズ",
            "口上下",
            "口横幅",
            "口縦幅",
            "口前後位置",
            "口形状上",
            "口形状下",
            "口形状口角",
            "耳サイズ",
            "耳角度Y軸",
            "耳角度Z軸",
            "耳上部形状",
            "耳下部形状"
        };

        // Token: 0x04003291 RID: 12945
        public static readonly int[] cf_MouthShapeMaskID = new int[]
        {
            3,
            47,
            48,
            49,
            50,
            51,
            52,
            53
        };

        // Token: 0x04003292 RID: 12946
        public static readonly float[] cf_MouthShapeDefault = new float[]
        {
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f
        };

        // Token: 0x04003293 RID: 12947
        public static readonly float[] cf_faceInitValue = new float[]
        {
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f,
            0.5f
        };

        // Token: 0x020007EC RID: 2028
        public enum BodyShapeIdx
        {
            // Token: 0x04003295 RID: 12949
            Height,
            // Token: 0x04003296 RID: 12950
            BustSize,
            // Token: 0x04003297 RID: 12951
            BustY,
            // Token: 0x04003298 RID: 12952
            BustRotX,
            // Token: 0x04003299 RID: 12953
            BustX,
            // Token: 0x0400329A RID: 12954
            BustRotY,
            // Token: 0x0400329B RID: 12955
            BustSharp,
            // Token: 0x0400329C RID: 12956
            AreolaBulge,
            // Token: 0x0400329D RID: 12957
            NipWeight,
            // Token: 0x0400329E RID: 12958
            HeadSize,
            // Token: 0x0400329F RID: 12959
            NeckW,
            // Token: 0x040032A0 RID: 12960
            NeckZ,
            // Token: 0x040032A1 RID: 12961
            BodyShoulderW,
            // Token: 0x040032A2 RID: 12962
            BodyShoulderZ,
            // Token: 0x040032A3 RID: 12963
            BodyUpW,
            // Token: 0x040032A4 RID: 12964
            BodyUpZ,
            // Token: 0x040032A5 RID: 12965
            BodyLowW,
            // Token: 0x040032A6 RID: 12966
            BodyLowZ,
            // Token: 0x040032A7 RID: 12967
            WaistY,
            // Token: 0x040032A8 RID: 12968
            WaistUpW,
            // Token: 0x040032A9 RID: 12969
            WaistUpZ,
            // Token: 0x040032AA RID: 12970
            WaistLowW,
            // Token: 0x040032AB RID: 12971
            WaistLowZ,
            // Token: 0x040032AC RID: 12972
            Hip,
            // Token: 0x040032AD RID: 12973
            HipRotX,
            // Token: 0x040032AE RID: 12974
            ThighUp,
            // Token: 0x040032AF RID: 12975
            ThighLow,
            // Token: 0x040032B0 RID: 12976
            Calf,
            // Token: 0x040032B1 RID: 12977
            Ankle,
            // Token: 0x040032B2 RID: 12978
            Shoulder,
            // Token: 0x040032B3 RID: 12979
            ArmUp,
            // Token: 0x040032B4 RID: 12980
            ArmLow,
            // Token: 0x040032B5 RID: 12981
            NipStand
        }

        // Token: 0x020007ED RID: 2029
        public enum FaceShapeIdx
        {
            // Token: 0x040032B7 RID: 12983
            FaceBaseW,
            // Token: 0x040032B8 RID: 12984
            FaceUpZ,
            // Token: 0x040032B9 RID: 12985
            FaceUpY,
            // Token: 0x040032BA RID: 12986
            FaceLowZ,
            // Token: 0x040032BB RID: 12987
            FaceLowW,
            // Token: 0x040032BC RID: 12988
            ChinW,
            // Token: 0x040032BD RID: 12989
            ChinY,
            // Token: 0x040032BE RID: 12990
            ChinZ,
            // Token: 0x040032BF RID: 12991
            ChinRot,
            // Token: 0x040032C0 RID: 12992
            ChinLowY,
            // Token: 0x040032C1 RID: 12993
            ChinTipW,
            // Token: 0x040032C2 RID: 12994
            ChinTipY,
            // Token: 0x040032C3 RID: 12995
            ChinTipZ,
            // Token: 0x040032C4 RID: 12996
            CheekLowY,
            // Token: 0x040032C5 RID: 12997
            CheekLowZ,
            // Token: 0x040032C6 RID: 12998
            CheekLowW,
            // Token: 0x040032C7 RID: 12999
            CheekUpY,
            // Token: 0x040032C8 RID: 13000
            CheekUpZ,
            // Token: 0x040032C9 RID: 13001
            CheekUpW,
            // Token: 0x040032CA RID: 13002
            EyeY,
            // Token: 0x040032CB RID: 13003
            EyeX,
            // Token: 0x040032CC RID: 13004
            EyeZ,
            // Token: 0x040032CD RID: 13005
            EyeW,
            // Token: 0x040032CE RID: 13006
            EyeH,
            // Token: 0x040032CF RID: 13007
            EyeRotZ,
            // Token: 0x040032D0 RID: 13008
            EyeRotY,
            // Token: 0x040032D1 RID: 13009
            EyeInX,
            // Token: 0x040032D2 RID: 13010
            EyeOutX,
            // Token: 0x040032D3 RID: 13011
            EyeInY,
            // Token: 0x040032D4 RID: 13012
            EyeOutY,
            // Token: 0x040032D5 RID: 13013
            EyelidForm01,
            // Token: 0x040032D6 RID: 13014
            EyelidForm02,
            // Token: 0x040032D7 RID: 13015
            NoseAllY,
            // Token: 0x040032D8 RID: 13016
            NoseAllZ,
            // Token: 0x040032D9 RID: 13017
            NoseAllRotX,
            // Token: 0x040032DA RID: 13018
            NoseAllW,
            // Token: 0x040032DB RID: 13019
            NoseBridgeH,
            // Token: 0x040032DC RID: 13020
            NoseBridgeW,
            // Token: 0x040032DD RID: 13021
            NoseBridgeForm,
            // Token: 0x040032DE RID: 13022
            NoseWingW,
            // Token: 0x040032DF RID: 13023
            NoseWingY,
            // Token: 0x040032E0 RID: 13024
            NoseWingZ,
            // Token: 0x040032E1 RID: 13025
            NoseWingRotX,
            // Token: 0x040032E2 RID: 13026
            NoseWingRotZ,
            // Token: 0x040032E3 RID: 13027
            NoseH,
            // Token: 0x040032E4 RID: 13028
            NoseRotX,
            // Token: 0x040032E5 RID: 13029
            NoseSize,
            // Token: 0x040032E6 RID: 13030
            MouthY,
            // Token: 0x040032E7 RID: 13031
            MouthW,
            // Token: 0x040032E8 RID: 13032
            MouthH,
            // Token: 0x040032E9 RID: 13033
            MouthZ,
            // Token: 0x040032EA RID: 13034
            MouthUpForm,
            // Token: 0x040032EB RID: 13035
            MouthLowForm,
            // Token: 0x040032EC RID: 13036
            MouthCornerForm,
            // Token: 0x040032ED RID: 13037
            EarSize,
            // Token: 0x040032EE RID: 13038
            EarRotY,
            // Token: 0x040032EF RID: 13039
            EarRotZ,
            // Token: 0x040032F0 RID: 13040
            EarUpForm,
            // Token: 0x040032F1 RID: 13041
            EarLowForm
        }

        // Token: 0x020007EE RID: 2030
        public enum HairKind
        {
            // Token: 0x040032F3 RID: 13043
            back,
            // Token: 0x040032F4 RID: 13044
            front,
            // Token: 0x040032F5 RID: 13045
            side,
            // Token: 0x040032F6 RID: 13046
            option
        }

        // Token: 0x020007EF RID: 2031
        public enum ClothesKind
        {
            // Token: 0x040032F8 RID: 13048
            top,
            // Token: 0x040032F9 RID: 13049
            bot,
            // Token: 0x040032FA RID: 13050
            inner_t,
            // Token: 0x040032FB RID: 13051
            inner_b,
            // Token: 0x040032FC RID: 13052
            gloves,
            // Token: 0x040032FD RID: 13053
            panst,
            // Token: 0x040032FE RID: 13054
            socks,
            // Token: 0x040032FF RID: 13055
            shoes
        }

        // Token: 0x020007F0 RID: 2032
        public enum SiruParts
        {
            // Token: 0x04003301 RID: 13057
            SiruKao,
            // Token: 0x04003302 RID: 13058
            SiruFrontTop,
            // Token: 0x04003303 RID: 13059
            SiruFrontBot,
            // Token: 0x04003304 RID: 13060
            SiruBackTop,
            // Token: 0x04003305 RID: 13061
            SiruBackBot
        }

        // Token: 0x020007F1 RID: 2033
        public enum WishKind
        {
            // Token: 0x04003307 RID: 13063
            Kindness,
            // Token: 0x04003308 RID: 13064
            Pleasure,
            // Token: 0x04003309 RID: 13065
            SmallDevil,
            // Token: 0x0400330A RID: 13066
            Stimulation,
            // Token: 0x0400330B RID: 13067
            Courtesy,
            // Token: 0x0400330C RID: 13068
            Forbidden,
            // Token: 0x0400330D RID: 13069
            CalmDown,
            // Token: 0x0400330E RID: 13070
            Money,
            // Token: 0x0400330F RID: 13071
            Intelligence,
            // Token: 0x04003310 RID: 13072
            Belief,
            // Token: 0x04003311 RID: 13073
            Loyalty,
            // Token: 0x04003312 RID: 13074
            Endurance,
            // Token: 0x04003313 RID: 13075
            Pretty,
            // Token: 0x04003314 RID: 13076
            Innocence,
            // Token: 0x04003315 RID: 13077
            Incomplete,
            // Token: 0x04003316 RID: 13078
            Understanding,
            // Token: 0x04003317 RID: 13079
            Judgement,
            // Token: 0x04003318 RID: 13080
            Healing
        }
    }
}
