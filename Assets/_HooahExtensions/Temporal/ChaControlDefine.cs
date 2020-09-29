using UnityEngine;

namespace AIChara
{
    // Token: 0x020003F7 RID: 1015
    public static class ChaControlDefine
    {
        // Token: 0x02000DED RID: 3565
        public enum DynamicBoneKind
        {
            // Token: 0x040051C6 RID: 20934
            BreastL,

            // Token: 0x040051C7 RID: 20935
            BreastR,

            // Token: 0x040051C8 RID: 20936
            HipL,

            // Token: 0x040051C9 RID: 20937
            HipR
        }

        // Token: 0x02000DEC RID: 3564
        public enum ExtraAccessoryParts
        {
            // Token: 0x040051C1 RID: 20929
            Head,

            // Token: 0x040051C2 RID: 20930
            Back,

            // Token: 0x040051C3 RID: 20931
            Neck,

            // Token: 0x040051C4 RID: 20932
            Waist
        }

        // Token: 0x04002201 RID: 8705
        public const string headBoneName = "cf_J_FaceRoot";

        // Token: 0x04002202 RID: 8706
        public const string bodyBoneName = "cf_J_Root";

        // Token: 0x04002203 RID: 8707
        public const string bodyTopName = "BodyTop";

        // Token: 0x04002204 RID: 8708
        public const string AnimeMannequinState = "mannequin";

        // Token: 0x04002205 RID: 8709
        public const string AnimeMannequinState02 = "mannequin02";

        // Token: 0x04002206 RID: 8710
        public const string objHeadName = "ct_head";

        // Token: 0x04002207 RID: 8711
        public const int FaceTexSize = 2048;

        // Token: 0x04002208 RID: 8712
        public const int BodyTexSize = 4096;

        // Token: 0x04002209 RID: 8713
        public static readonly Bounds bounds = new Bounds(new Vector3(0f, -2f, 0f), new Vector3(20f, 20f, 20f));

        // Token: 0x0400220A RID: 8714
        public static readonly string[] extraAcsNames =
        {
            "mapAcsHead",
            "mapAcsBack",
            "mapAcsNeck",
            "mapAcsWaist"
        };
    }
}