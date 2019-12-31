using System;
using System.Collections.Generic;
using MessagePack;
using UnityEngine;

namespace AIChara
{
    // Token: 0x020007E6 RID: 2022
    [MessagePackObject(true)]
    public class ChaFileHair
    {
        // Token: 0x06003294 RID: 12948 RVA: 0x0012C20C File Offset: 0x0012A60C
        public ChaFileHair()
        {
            this.MemberInit();
        }

        // Token: 0x170008CB RID: 2251
        // (get) Token: 0x06003295 RID: 12949 RVA: 0x0012C21A File Offset: 0x0012A61A
        // (set) Token: 0x06003296 RID: 12950 RVA: 0x0012C222 File Offset: 0x0012A622
        public Version version { get; set; }

        // Token: 0x170008CC RID: 2252
        // (get) Token: 0x06003297 RID: 12951 RVA: 0x0012C22B File Offset: 0x0012A62B
        // (set) Token: 0x06003298 RID: 12952 RVA: 0x0012C233 File Offset: 0x0012A633
        public bool sameSetting { get; set; }

        // Token: 0x170008CD RID: 2253
        // (get) Token: 0x06003299 RID: 12953 RVA: 0x0012C23C File Offset: 0x0012A63C
        // (set) Token: 0x0600329A RID: 12954 RVA: 0x0012C244 File Offset: 0x0012A644
        public bool autoSetting { get; set; }

        // Token: 0x170008CE RID: 2254
        // (get) Token: 0x0600329B RID: 12955 RVA: 0x0012C24D File Offset: 0x0012A64D
        // (set) Token: 0x0600329C RID: 12956 RVA: 0x0012C255 File Offset: 0x0012A655
        public bool ctrlTogether { get; set; }

        // Token: 0x170008CF RID: 2255
        // (get) Token: 0x0600329D RID: 12957 RVA: 0x0012C25E File Offset: 0x0012A65E
        // (set) Token: 0x0600329E RID: 12958 RVA: 0x0012C266 File Offset: 0x0012A666
        public ChaFileHair.PartsInfo[] parts { get; set; }

        // Token: 0x170008D0 RID: 2256
        // (get) Token: 0x0600329F RID: 12959 RVA: 0x0012C26F File Offset: 0x0012A66F
        // (set) Token: 0x060032A0 RID: 12960 RVA: 0x0012C277 File Offset: 0x0012A677
        public int kind { get; set; }

        // Token: 0x170008D1 RID: 2257
        // (get) Token: 0x060032A1 RID: 12961 RVA: 0x0012C280 File Offset: 0x0012A680
        // (set) Token: 0x060032A2 RID: 12962 RVA: 0x0012C288 File Offset: 0x0012A688
        public int shaderType { get; set; }

        // Token: 0x060032A3 RID: 12963 RVA: 0x0012C294 File Offset: 0x0012A694
        public void MemberInit()
        {
            this.version = ChaFileDefine.ChaFileHairVersion;
            this.sameSetting = true;
            this.autoSetting = true;
            this.ctrlTogether = false;
            this.parts = new ChaFileHair.PartsInfo[Enum.GetValues(typeof(ChaFileDefine.HairKind)).Length];
            for (int i = 0; i < this.parts.Length; i++)
            {
                this.parts[i] = new ChaFileHair.PartsInfo();
            }
            this.kind = 0;
            this.shaderType = 0;
        }

        // Token: 0x060032A4 RID: 12964 RVA: 0x0012C314 File Offset: 0x0012A714
        public void ComplementWithVersion()
        {
            if (this.version < new Version("0.0.1"))
            {
                for (int i = 0; i < this.parts.Length; i++)
                {
                    this.parts[i].acsColorInfo = new ChaFileHair.PartsInfo.ColorInfo[4];
                    for (int j = 0; j < this.parts[i].acsColorInfo.Length; j++)
                    {
                        this.parts[i].acsColorInfo[j] = new ChaFileHair.PartsInfo.ColorInfo();
                    }
                }
            }
            if (this.version < new Version("0.0.2"))
            {
                this.sameSetting = true;
                this.autoSetting = true;
                this.ctrlTogether = false;
            }
            this.version = ChaFileDefine.ChaFileHairVersion;
        }

        // Token: 0x020007E7 RID: 2023
        [MessagePackObject(true)]
        public class PartsInfo
        {
            // Token: 0x060032A5 RID: 12965 RVA: 0x0012C3D5 File Offset: 0x0012A7D5
            public PartsInfo()
            {
                this.MemberInit();
            }

            // Token: 0x170008D2 RID: 2258
            // (get) Token: 0x060032A6 RID: 12966 RVA: 0x0012C3E3 File Offset: 0x0012A7E3
            // (set) Token: 0x060032A7 RID: 12967 RVA: 0x0012C3EB File Offset: 0x0012A7EB
            public int id { get; set; }

            // Token: 0x170008D3 RID: 2259
            // (get) Token: 0x060032A8 RID: 12968 RVA: 0x0012C3F4 File Offset: 0x0012A7F4
            // (set) Token: 0x060032A9 RID: 12969 RVA: 0x0012C3FC File Offset: 0x0012A7FC
            public Color baseColor { get; set; }

            // Token: 0x170008D4 RID: 2260
            // (get) Token: 0x060032AA RID: 12970 RVA: 0x0012C405 File Offset: 0x0012A805
            // (set) Token: 0x060032AB RID: 12971 RVA: 0x0012C40D File Offset: 0x0012A80D
            public Color topColor { get; set; }

            // Token: 0x170008D5 RID: 2261
            // (get) Token: 0x060032AC RID: 12972 RVA: 0x0012C416 File Offset: 0x0012A816
            // (set) Token: 0x060032AD RID: 12973 RVA: 0x0012C41E File Offset: 0x0012A81E
            public Color underColor { get; set; }

            // Token: 0x170008D6 RID: 2262
            // (get) Token: 0x060032AE RID: 12974 RVA: 0x0012C427 File Offset: 0x0012A827
            // (set) Token: 0x060032AF RID: 12975 RVA: 0x0012C42F File Offset: 0x0012A82F
            public Color specular { get; set; }

            // Token: 0x170008D7 RID: 2263
            // (get) Token: 0x060032B0 RID: 12976 RVA: 0x0012C438 File Offset: 0x0012A838
            // (set) Token: 0x060032B1 RID: 12977 RVA: 0x0012C440 File Offset: 0x0012A840
            public float metallic { get; set; }

            // Token: 0x170008D8 RID: 2264
            // (get) Token: 0x060032B2 RID: 12978 RVA: 0x0012C449 File Offset: 0x0012A849
            // (set) Token: 0x060032B3 RID: 12979 RVA: 0x0012C451 File Offset: 0x0012A851
            public float smoothness { get; set; }

            // Token: 0x170008D9 RID: 2265
            // (get) Token: 0x060032B4 RID: 12980 RVA: 0x0012C45A File Offset: 0x0012A85A
            // (set) Token: 0x060032B5 RID: 12981 RVA: 0x0012C462 File Offset: 0x0012A862
            public ChaFileHair.PartsInfo.ColorInfo[] acsColorInfo { get; set; }

            // Token: 0x170008DA RID: 2266
            // (get) Token: 0x060032B6 RID: 12982 RVA: 0x0012C46B File Offset: 0x0012A86B
            // (set) Token: 0x060032B7 RID: 12983 RVA: 0x0012C473 File Offset: 0x0012A873
            public int bundleId { get; set; }

            // Token: 0x170008DB RID: 2267
            // (get) Token: 0x060032B8 RID: 12984 RVA: 0x0012C47C File Offset: 0x0012A87C
            // (set) Token: 0x060032B9 RID: 12985 RVA: 0x0012C484 File Offset: 0x0012A884
            public Dictionary<int, ChaFileHair.PartsInfo.BundleInfo> dictBundle { get; set; }

            // Token: 0x060032BA RID: 12986 RVA: 0x0012C490 File Offset: 0x0012A890
            public void MemberInit()
            {
                this.id = 0;
                this.baseColor = new Color(0.2f, 0.2f, 0.2f);
                this.topColor = new Color(0.039f, 0.039f, 0.039f);
                this.underColor = new Color(0.565f, 0.565f, 0.565f);
                this.specular = new Color(0.3f, 0.3f, 0.3f);
                this.metallic = 0f;
                this.smoothness = 0f;
                this.acsColorInfo = new ChaFileHair.PartsInfo.ColorInfo[4];
                for (int i = 0; i < this.acsColorInfo.Length; i++)
                {
                    this.acsColorInfo[i] = new ChaFileHair.PartsInfo.ColorInfo();
                }
                this.bundleId = -1;
                this.dictBundle = new Dictionary<int, ChaFileHair.PartsInfo.BundleInfo>();
            }

            // Token: 0x020007E8 RID: 2024
            [MessagePackObject(true)]
            public class BundleInfo
            {
                // Token: 0x060032BB RID: 12987 RVA: 0x0012C566 File Offset: 0x0012A966
                public BundleInfo()
                {
                    this.MemberInit();
                }

                // Token: 0x170008DC RID: 2268
                // (get) Token: 0x060032BC RID: 12988 RVA: 0x0012C574 File Offset: 0x0012A974
                // (set) Token: 0x060032BD RID: 12989 RVA: 0x0012C57C File Offset: 0x0012A97C
                public Vector3 moveRate { get; set; }

                // Token: 0x170008DD RID: 2269
                // (get) Token: 0x060032BE RID: 12990 RVA: 0x0012C585 File Offset: 0x0012A985
                // (set) Token: 0x060032BF RID: 12991 RVA: 0x0012C58D File Offset: 0x0012A98D
                public Vector3 rotRate { get; set; }

                // Token: 0x170008DE RID: 2270
                // (get) Token: 0x060032C0 RID: 12992 RVA: 0x0012C596 File Offset: 0x0012A996
                // (set) Token: 0x060032C1 RID: 12993 RVA: 0x0012C59E File Offset: 0x0012A99E
                public bool noShake { get; set; }

                // Token: 0x060032C2 RID: 12994 RVA: 0x0012C5A7 File Offset: 0x0012A9A7
                public void MemberInit()
                {
                    this.moveRate = Vector3.zero;
                    this.rotRate = Vector3.zero;
                    this.noShake = false;
                }
            }

            // Token: 0x020007E9 RID: 2025
            [MessagePackObject(true)]
            public class ColorInfo
            {
                // Token: 0x060032C3 RID: 12995 RVA: 0x0012C5C6 File Offset: 0x0012A9C6
                public ColorInfo()
                {
                    this.MemberInit();
                }

                // Token: 0x170008DF RID: 2271
                // (get) Token: 0x060032C4 RID: 12996 RVA: 0x0012C5D4 File Offset: 0x0012A9D4
                // (set) Token: 0x060032C5 RID: 12997 RVA: 0x0012C5DC File Offset: 0x0012A9DC
                public Color color { get; set; }

                // Token: 0x060032C6 RID: 12998 RVA: 0x0012C5E5 File Offset: 0x0012A9E5
                public void MemberInit()
                {
                    this.color = Color.white;
                }
            }
        }
    }
}
