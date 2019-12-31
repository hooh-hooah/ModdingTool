using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpClothes : CmpBase
    {
        public CmpClothes() : base(true)
        {
        }

        public void SetDefault()
        {
            Material material = null;
            if (this.rendNormal01 != null && this.rendNormal01.Length != 0)
            {
                material = this.rendNormal01[0].sharedMaterial;
            }
            if (null != material)
            {
                if (this.useColorN01 || this.useColorA01)
                {
                    if (material.HasProperty("_Color"))
                    {
                        this.defMainColor01 = material.GetColor("_Color");
                    }
                    if (material.HasProperty("_Color1_2"))
                    {
                        this.defPatternColor01 = material.GetColor("_Color1_2");
                    }
                    if (material.HasProperty("_Glossiness"))
                    {
                        this.defGloss01 = material.GetFloat("_Glossiness");
                    }
                    if (material.HasProperty("_Metallic"))
                    {
                        this.defMetallic01 = material.GetFloat("_Metallic");
                    }
                    if (material.HasProperty("_patternuv1"))
                    {
                        this.defLayout01 = material.GetVector("_patternuv1");
                    }
                    if (material.HasProperty("_patternuv1Rotator"))
                    {
                        this.defRotation01 = material.GetFloat("_patternuv1Rotator");
                    }
                }
                if (this.useColorN02 || this.useColorA02)
                {
                    if (material.HasProperty("_Color2"))
                    {
                        this.defMainColor02 = material.GetColor("_Color2");
                    }
                    if (material.HasProperty("_Color2_2"))
                    {
                        this.defPatternColor01 = material.GetColor("_Color2_2");
                    }
                    if (material.HasProperty("_Glossiness2"))
                    {
                        this.defGloss02 = material.GetFloat("_Glossiness2");
                    }
                    if (material.HasProperty("_Metallic2"))
                    {
                        this.defMetallic02 = material.GetFloat("_Metallic2");
                    }
                    if (material.HasProperty("_patternuv2"))
                    {
                        this.defLayout02 = material.GetVector("_patternuv2");
                    }
                    if (material.HasProperty("_patternuv2Rotator"))
                    {
                        this.defRotation02 = material.GetFloat("_patternuv2Rotator");
                    }
                }
                if (this.useColorN03 || this.useColorA03)
                {
                    if (material.HasProperty("_Color3"))
                    {
                        this.defMainColor03 = material.GetColor("_Color3");
                    }
                    if (material.HasProperty("_Color3_2"))
                    {
                        this.defPatternColor01 = material.GetColor("_Color3_2");
                    }
                    if (material.HasProperty("_Glossiness3"))
                    {
                        this.defGloss03 = material.GetFloat("_Glossiness3");
                    }
                    if (material.HasProperty("_Metallic3"))
                    {
                        this.defMetallic03 = material.GetFloat("_Metallic3");
                    }
                    if (material.HasProperty("_patternuv3"))
                    {
                        this.defLayout03 = material.GetVector("_patternuv3");
                    }
                    if (material.HasProperty("_patternuv3Rotator"))
                    {
                        this.defRotation03 = material.GetFloat("_patternuv3Rotator");
                    }
                }
                if (material.HasProperty("_UVScalePattern"))
                {
                    this.uvScalePattern = material.GetVector("_UVScalePattern");
                }
                if (material.HasProperty("_Color4"))
                {
                    this.defMainColor04 = material.GetColor("_Color4");
                }
                if (material.HasProperty("_Glossiness4"))
                {
                    this.defGloss04 = material.GetFloat("_Glossiness4");
                }
                if (material.HasProperty("_Metallic4"))
                {
                    this.defMetallic04 = material.GetFloat("_Metallic4");
                }
            }
        }

        public override void SetReferenceObject()
        {
        }

        // Token: 0x04002F31 RID: 12081
        [Header("Torn flag")]
        public bool useBreak;

        // Token: 0x04002F32 RID: 12082
        [Header("Normal parts")]
        public Renderer[] rendNormal01;

        // Token: 0x04002F33 RID: 12083
        public Renderer[] rendNormal02;

        // Token: 0x04002F34 RID: 12084
        public Renderer[] rendNormal03;

        // Token: 0x04002F35 RID: 12085
        public bool useColorN01;

        // Token: 0x04002F36 RID: 12086
        public bool useColorN02;

        // Token: 0x04002F37 RID: 12087
        public bool useColorN03;

        // Token: 0x04002F38 RID: 12088
        public bool useColorA01;

        // Token: 0x04002F39 RID: 12089
        public bool useColorA02;

        // Token: 0x04002F3A RID: 12090
        public bool useColorA03;

        // Token: 0x04002F3B RID: 12091
        [Header("Summary of clothing and half-off")]
        public GameObject objTopDef;

        // Token: 0x04002F3C RID: 12092
        public GameObject objTopHalf;

        // Token: 0x04002F3D RID: 12093
        public GameObject objBotDef;

        // Token: 0x04002F3E RID: 12094
        public GameObject objBotHalf;

        // Token: 0x04002F3F RID: 12095
        [Header("Optional parts")]
        public GameObject[] objOpt01;

        // Token: 0x04002F40 RID: 12096
        public GameObject[] objOpt02;

        // Token: 0x04002F41 RID: 12097
        [Header("Pattern size adjustment (fixed)")]
        public Vector4 uvScalePattern = new Vector4(1f, 1f, 0f, 0f);

        // Token: 0x04002F42 RID: 12098
        [Header("Basic initial settings")]
        public Color defMainColor01 = Color.white;

        // Token: 0x04002F43 RID: 12099
        public Color defMainColor02 = Color.white;

        // Token: 0x04002F44 RID: 12100
        public Color defMainColor03 = Color.white;

        // Token: 0x04002F45 RID: 12101
        public int defPtnIndex01;

        // Token: 0x04002F46 RID: 12102
        public int defPtnIndex02;

        // Token: 0x04002F47 RID: 12103
        public int defPtnIndex03;

        // Token: 0x04002F48 RID: 12104
        public Color defPatternColor01 = Color.white;

        // Token: 0x04002F49 RID: 12105
        public Color defPatternColor02 = Color.white;

        // Token: 0x04002F4A RID: 12106
        public Color defPatternColor03 = Color.white;

        // Token: 0x04002F4B RID: 12107
        [Range(0f, 1f)]
        public float defGloss01;

        // Token: 0x04002F4C RID: 12108
        [Range(0f, 1f)]
        public float defGloss02;

        // Token: 0x04002F4D RID: 12109
        [Range(0f, 1f)]
        public float defGloss03;

        // Token: 0x04002F4E RID: 12110
        [Range(0f, 1f)]
        public float defMetallic01;

        // Token: 0x04002F4F RID: 12111
        [Range(0f, 1f)]
        public float defMetallic02;

        // Token: 0x04002F50 RID: 12112
        [Range(0f, 1f)]
        public float defMetallic03;

        // Token: 0x04002F51 RID: 12113
        public Vector4 defLayout01 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);

        // Token: 0x04002F52 RID: 12114
        public Vector4 defLayout02 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);

        // Token: 0x04002F53 RID: 12115
        public Vector4 defLayout03 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);

        // Token: 0x04002F54 RID: 12116
        [Range(0f, 1f)]
        public float defRotation01 = 0.5f;

        // Token: 0x04002F55 RID: 12117
        [Range(0f, 1f)]
        public float defRotation02 = 0.5f;

        // Token: 0x04002F56 RID: 12118
        [Range(0f, 1f)]
        public float defRotation03 = 0.5f;

        // Token: 0x04002F57 RID: 12119
        [Space]
        [Header("4th color (fixed)")]
        public Color defMainColor04 = Color.white;

        // Token: 0x04002F58 RID: 12120
        [Range(0f, 1f)]
        public float defGloss04;

        // Token: 0x04002F59 RID: 12121
        [Range(0f, 1f)]
        public float defMetallic04;

        public int setdefault;
    }
}
