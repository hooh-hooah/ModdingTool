using System.Diagnostics.CodeAnalysis;
using System.Linq;
using ModdingTool;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace AIChara
{
    [DisallowMultipleComponent]
    public class CmpClothes : CmpBase
    {
        [ConditionalField(nameof(useColorN01))] [Range(0f, 1f)]
        public float defGloss01;

        [ConditionalField(nameof(useColorN02))] [Range(0f, 1f)]
        public float defGloss02;

        [ConditionalField(nameof(useColorN03))] [Range(0f, 1f)]
        public float defGloss03;

        [Range(0f, 1f)] public float defGloss04;

        [ConditionalField(nameof(useColorN01))]
        public Vector4 defLayout01 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);

        [ConditionalField(nameof(useColorN02))]
        public Vector4 defLayout02 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);

        [ConditionalField(nameof(useColorN03))]
        public Vector4 defLayout03 = new Vector4(0.5f, 0.5f, 0.5f, 0.5f);

        [ConditionalField(nameof(useColorN01))]
        public Color defMainColor01 = Color.white;

        [ConditionalField(nameof(useColorN02))]
        public Color defMainColor02 = Color.white;

        [ConditionalField(nameof(useColorN03))]
        public Color defMainColor03 = Color.white;

        public Color defMainColor04 = Color.white;

        [ConditionalField(nameof(useColorN01))] [Range(0f, 1f)]
        public float defMetallic01;

        [ConditionalField(nameof(useColorN02))] [Range(0f, 1f)]
        public float defMetallic02;

        [ConditionalField(nameof(useColorN03))] [Range(0f, 1f)]
        public float defMetallic03;

        [Range(0f, 1f)] public float defMetallic04;

        [ConditionalField(nameof(useColorN01))]
        public Color defPatternColor01 = Color.white;

        [ConditionalField(nameof(useColorN02))]
        public Color defPatternColor02 = Color.white;

        [ConditionalField(nameof(useColorN03))]
        public Color defPatternColor03 = Color.white;

        [ConditionalField(nameof(useColorN01))]
        public int defPtnIndex01;

        [ConditionalField(nameof(useColorN02))]
        public int defPtnIndex02;

        [ConditionalField(nameof(useColorN03))]
        public int defPtnIndex03;

        [ConditionalField(nameof(useColorN01))] [Range(0f, 1f)]
        public float defRotation01 = 0.5f;

        [ConditionalField(nameof(useColorN02))] [Range(0f, 1f)]
        public float defRotation02 = 0.5f;

        [ConditionalField(nameof(useColorN03))] [Range(0f, 1f)]
        public float defRotation03 = 0.5f;

        public GameObject objBotDef;
        public GameObject objBotHalf;

        public GameObject[] objOpt01;
        public GameObject[] objOpt02;

        public GameObject objTopDef;
        public GameObject objTopHalf;

        public Renderer[] rendNormal01;

        public Renderer[] rendNormal02;

        public Renderer[] rendNormal03;

        [HideInInspector] public int setdefault;

        public bool useBreak;

        [ConditionalField(nameof(useColorN01))]
        public bool useColorA01;

        [ConditionalField(nameof(useColorN02))]
        public bool useColorA02;

        [ConditionalField(nameof(useColorN03))]
        public bool useColorA03;

        public bool useColorN01;
        public bool useColorN02;
        public bool useColorN03;
        public Vector4 uvScalePattern = new Vector4(1f, 1f, 0f, 0f);

        public CmpClothes() : base(true)
        {
        }
        // This is really bad practice for generic unity game.
        // But for modding, this is perfect. 
#if UNITY_EDITOR
        // These fields will go invisible for bundle-loaded components
        public string outfitName;
        public bool isCoordinate;
        public Texture2D diffuseA;
        public Texture2D diffuseB;
        public Texture2D diffuseC;
        public Texture2D colorMask;
#endif

#if UNITY_EDITOR
        [SuppressMessage("ReSharper", "CoVariantArrayConversion")]
        public override void SetReferenceObject()
        {
            // Automatically assign the object to layer 10.
            gameObject.layer = 10;
            gameObject.GetComponentsInChildren<Animator>().ToList().ForEach(x =>
            {
                // Destroying assets is not permitted to avoid data loss? 
                DestroyImmediate(x, true);
            });
            gameObject.GetComponentsInChildren<Transform>().ToList().ForEach(x =>
            {
                // apply same to other objects.
                x.gameObject.layer = 10;
                x.localScale = Vector3.one;
            });

            var findAssist = new FindAssist(transform);

            objTopDef = findAssist.GetClothPart(FindAssistFilter.Cloth.Top);
            objTopHalf = findAssist.GetClothPart(FindAssistFilter.Cloth.TopHalf);
            objBotDef = findAssist.GetClothPart(FindAssistFilter.Cloth.Bot);
            objBotHalf = findAssist.GetClothPart(FindAssistFilter.Cloth.BotHalf);
            objOpt01 = findAssist.GetClothParts(FindAssistFilter.Cloth.FirstAccessory);
            objOpt02 = findAssist.GetClothParts(FindAssistFilter.Cloth.SecondAccessory);

            if (GetComponents<MeshRenderer>().Length > 0)
                EditorUtility.DisplayDialog("Warning",
                    "The mesh that you're trying to make as clothing is not SkinnedMeshRenderer!\n" +
                    "Check if your export option is correct and check if your mesh's avatar is 'Generic'\n" +
                    "Clothing mesh MUST NOT include any Renderer that is not Skinned Mesh Renderer.",
                    "okay... I'll export it again.");

            var rendererParts = findAssist.GetRendererParts();
            rendNormal01 = rendererParts[0];
            rendNormal02 = rendererParts[1];
            rendNormal03 = rendererParts[2];

            foreach (var dynamicBone in GetComponentsInChildren<DynamicBone>(true).Concat(GetComponents<DynamicBone>())) DestroyImmediate(dynamicBone);
            foreach (var skirtBone in findAssist.GetSkirtBones())
            {
                var dynamicBone = gameObject.AddComponent<DynamicBone>();
                dynamicBone.m_Root = skirtBone.transform;
            }
        }

        public void SyncMaterialDefaultValues()
        {
            Material material = null;
            if (rendNormal01 != null && rendNormal01.Length != 0) material = rendNormal01[0].sharedMaterial;
            if (null == material) return;

            if (useColorN01 || useColorA01)
            {
                material.SafeAssign("_Color", ref defMainColor01);
                material.SafeAssign("_Color1_2", ref defPatternColor01);
                material.SafeAssign("_Glossiness", ref defGloss01);
                material.SafeAssign("_Metallic", ref defMetallic01);
                material.SafeAssign("_patternuv1", ref defLayout01);
                material.SafeAssign("_patternuv1Rotator", ref defRotation01);
            }

            if (useColorN02 || useColorA02)
            {
                material.SafeAssign("_Color2", ref defMainColor02);
                material.SafeAssign("_Color2_2", ref defPatternColor01);
                material.SafeAssign("_Glossiness2", ref defGloss02);
                material.SafeAssign("_Metallic2", ref defMetallic02);
                material.SafeAssign("_patternuv2", ref defLayout02);
                material.SafeAssign("_patternuv2Rotator", ref defRotation02);
            }

            if (useColorN03 || useColorA03)
            {
                material.SafeAssign("_Color3", ref defMainColor03);
                material.SafeAssign("_Color3_2", ref defPatternColor01);
                material.SafeAssign("_Glossiness3", ref defGloss03);
                material.SafeAssign("_Metallic3", ref defMetallic03);
                material.SafeAssign("_patternuv3", ref defLayout03);
                material.SafeAssign("_patternuv3Rotator", ref defRotation03);
            }

            material.SafeAssign("_UVScalePattern", ref uvScalePattern);
            material.SafeAssign("_Color4", ref defMainColor04);
            material.SafeAssign("_Glossiness4", ref defGloss04);
            material.SafeAssign("_Metallic4", ref defMetallic04);
        }
#endif
    }
}