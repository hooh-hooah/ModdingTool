using System.Linq;
using MyBox;
using UnityEngine;

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpClothes : CmpBase
    {
        public CmpClothes() : base(true)
        {
        }

        public GameObject objTopDef;
        public GameObject objTopHalf;
        public GameObject objBotDef;
        public GameObject objBotHalf;

        public GameObject[] objOpt01;
        public GameObject[] objOpt02;

        public bool useBreak;
        public Vector4 uvScalePattern = new Vector4(1f, 1f, 0f, 0f);

        public Renderer[] rendNormal01;
        public bool useColorN01;
        [ConditionalField(nameof(useColorN01))] public bool useColorA01;
        [ConditionalField(nameof(useColorN01))] public Color defMainColor01 = Color.white;
        [ConditionalField(nameof(useColorN01)), Range(0f, 1f)] public float defGloss01;
        [ConditionalField(nameof(useColorN01)), Range(0f, 1f)] public float defMetallic01;
        [ConditionalField(nameof(useColorN01))] public Vector4 defLayout01 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);
        [ConditionalField(nameof(useColorN01)), Range(0f, 1f)] public float defRotation01 = 0.5f;
        [ConditionalField(nameof(useColorN01))] public Color defPatternColor01 = Color.white;
        [ConditionalField(nameof(useColorN01))] public int defPtnIndex01;

        public Renderer[] rendNormal02;
        public bool useColorN02;
        [ConditionalField(nameof(useColorN02))] public bool useColorA02;
        [ConditionalField(nameof(useColorN02)), Range(0f, 1f)] public float defRotation02 = 0.5f;
        [ConditionalField(nameof(useColorN02))] public Vector4 defLayout02 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);
        [ConditionalField(nameof(useColorN02)), Range(0f, 1f)] public float defMetallic02;
        [ConditionalField(nameof(useColorN02)), Range(0f, 1f)] public float defGloss02;
        [ConditionalField(nameof(useColorN02))] public Color defPatternColor02 = Color.white;
        [ConditionalField(nameof(useColorN02))] public int defPtnIndex02;
        [ConditionalField(nameof(useColorN02))] public Color defMainColor02 = Color.white;

        public Renderer[] rendNormal03;
        public bool useColorN03;
        [ConditionalField(nameof(useColorN03))] public bool useColorA03;
        [ConditionalField(nameof(useColorN03)), Range(0f, 1f)] public float defMetallic03;
        [ConditionalField(nameof(useColorN03))] public Vector4 defLayout03 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);
        [ConditionalField(nameof(useColorN03)), Range(0f, 1f)] public float defRotation03 = 0.5f;
        [ConditionalField(nameof(useColorN03)), Range(0f, 1f)] public float defGloss03;
        [ConditionalField(nameof(useColorN03))] public Color defPatternColor03 = Color.white;
        [ConditionalField(nameof(useColorN03))] public int defPtnIndex03;
        [ConditionalField(nameof(useColorN03))] public Color defMainColor03 = Color.white;
        
        public Color defMainColor04 = Color.white;
        [Range(0f, 1f)] public float defGloss04;
        [Range(0f, 1f)] public float defMetallic04;
        [HideInInspector]
        public int setdefault;

        public override void SetReferenceObject()
        {
            // TODO: Initialize custom filters.
            // fuck you please
            gameObject.layer = 10;
            gameObject.GetComponentsInChildren<Animator>().ToList().ForEach(x =>
            {
                // Destroying assets is not permitted to avoid data loss? 
                // pfff, pussy. I'm doing it anyway. suck my dick
                DestroyImmediate(x, true);
            });
            gameObject.GetComponentsInChildren<Transform>().ToList().ForEach(x =>
            {
                x.gameObject.layer = 10;
                x.localScale = Vector3.one;
            });
            
            var findAssist = new FindAssist();
            findAssist.Initialize(transform);
            objTopDef = FindAssistFilter.GetClothPart(FindAssistFilter.Cloth.Top, findAssist);
            objTopHalf = FindAssistFilter.GetClothPart(FindAssistFilter.Cloth.TopHalf, findAssist);
            objBotDef = FindAssistFilter.GetClothPart(FindAssistFilter.Cloth.Bot, findAssist);
            objBotHalf = FindAssistFilter.GetClothPart(FindAssistFilter.Cloth.BotHalf, findAssist);
            objOpt01 = FindAssistFilter.GetClothParts(FindAssistFilter.Cloth.FirstAccessory, findAssist);
            objOpt02 = FindAssistFilter.GetClothParts(FindAssistFilter.Cloth.SecondAccessory, findAssist);
            rendNormal01 = GetComponentsInChildren<Renderer>(true);
            FindAssistFilter.GetSkirtBones(findAssist).Select(x => x.GetOrAddComponent<DynamicBone>());
        }
        
        public void SyncMaterialDefaultValues()
        {
            Material material = null;
            if (rendNormal01 != null && rendNormal01.Length != 0) material = rendNormal01[0].sharedMaterial;
            if (null != material)
            {
                if (useColorN01 || useColorA01)
                {
                    if (material.HasProperty("_Color")) defMainColor01 = material.GetColor("_Color");
                    if (material.HasProperty("_Color1_2")) defPatternColor01 = material.GetColor("_Color1_2");
                    if (material.HasProperty("_Glossiness")) defGloss01 = material.GetFloat("_Glossiness");
                    if (material.HasProperty("_Metallic")) defMetallic01 = material.GetFloat("_Metallic");
                    if (material.HasProperty("_patternuv1")) defLayout01 = material.GetVector("_patternuv1");
                    if (material.HasProperty("_patternuv1Rotator"))
                        defRotation01 = material.GetFloat("_patternuv1Rotator");
                }

                if (useColorN02 || useColorA02)
                {
                    if (material.HasProperty("_Color2")) defMainColor02 = material.GetColor("_Color2");
                    if (material.HasProperty("_Color2_2")) defPatternColor01 = material.GetColor("_Color2_2");
                    if (material.HasProperty("_Glossiness2")) defGloss02 = material.GetFloat("_Glossiness2");
                    if (material.HasProperty("_Metallic2")) defMetallic02 = material.GetFloat("_Metallic2");
                    if (material.HasProperty("_patternuv2")) defLayout02 = material.GetVector("_patternuv2");
                    if (material.HasProperty("_patternuv2Rotator"))
                        defRotation02 = material.GetFloat("_patternuv2Rotator");
                }

                if (useColorN03 || useColorA03)
                {
                    if (material.HasProperty("_Color3")) defMainColor03 = material.GetColor("_Color3");
                    if (material.HasProperty("_Color3_2")) defPatternColor01 = material.GetColor("_Color3_2");
                    if (material.HasProperty("_Glossiness3")) defGloss03 = material.GetFloat("_Glossiness3");
                    if (material.HasProperty("_Metallic3")) defMetallic03 = material.GetFloat("_Metallic3");
                    if (material.HasProperty("_patternuv3")) defLayout03 = material.GetVector("_patternuv3");
                    if (material.HasProperty("_patternuv3Rotator"))
                        defRotation03 = material.GetFloat("_patternuv3Rotator");
                }

                if (material.HasProperty("_UVScalePattern")) uvScalePattern = material.GetVector("_UVScalePattern");
                if (material.HasProperty("_Color4")) defMainColor04 = material.GetColor("_Color4");
                if (material.HasProperty("_Glossiness4")) defGloss04 = material.GetFloat("_Glossiness4");
                if (material.HasProperty("_Metallic4")) defMetallic04 = material.GetFloat("_Metallic4");
            }
        }
    }
}