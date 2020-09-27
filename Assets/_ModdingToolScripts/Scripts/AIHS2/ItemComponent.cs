using System;
using System.Linq;
using System.Text.RegularExpressions;
using MyBox;
using UnityEditor;
using UnityEngine;

namespace Studio
{
    [AddComponentMenu("AIHS2 ItemComponent")]
    public class ItemComponent : MonoBehaviour
    {
        [Range(0f, 1f)] public float alpha = 1f;
        [ConditionalField(nameof(isAnime))] public AnimeInfo[] animeInfos;

        /*
         * Option Properties
         */
        [Separator("Option Information")] public Transform childRoot;
        [ColorUsage(false, true)] public Color defEmissionColor = Color.clear;
        [Range(0f, 1f)] public float defEmissionStrength;
        public Color defGlass = Color.white;
        [Range(0f, 1f)] public float defLightCancel;

        /*
         * Color Properties
         */
        [Separator("Color Information")] public Info[] info = new Info[3];

        /*
         * Animation Properties
         */
        [Separator("Animation Information")] public bool isAnime;
        public bool isScale = true;

        /*
         *  Widely Unused Properties
         */
        [HideInInspector] public GameObject objSeaParent;
        public OptionInfo[] optionInfos;

        /*
         * Renderer Properties
         */
        [Separator("Renderer Information")] public RendererInfo[] rendererInfos;
        [HideInInspector] public Renderer[] renderersSea;
        [HideInInspector] public int setcolor;

        [Serializable]
        public class MaterialInfo
        {
            public bool isAlpha;
            public bool isColor1;
            public bool isColor2;
            public bool isColor3;
            public bool isEmission;
            public bool isGlass;
            public bool isPattern1;
            public bool isPattern2;
            public bool isPattern3;
        }

        [Serializable]
        public class RendererInfo
        {
            public MaterialInfo[] materials;
            [MustBeAssigned] public Renderer renderer;
        }

        [Serializable]
        public class Info
        {
            public bool defClamp = true;
            [Header("Material Properties")] public Color defColor = Color.white;
            [Header("Pattern Properties")] [Space] public Color defColorPattern = Color.white;

            [Range(0f, 1f)] public float defGlossiness;

            [ConditionalField(nameof(useMetallic))] [Range(0f, 1f)]
            public float defMetallic;

            public float defRot;
            public Vector4 defUV = Vector4.zero;
            public bool useMetallic;
        }

        [Serializable]
        public class OptionInfo
        {
            [Tooltip("The objects that go invisible when option is turned off")]
            public GameObject[] objectsOff;

            [Tooltip("The objects that go visible when option is turned on")]
            public GameObject[] objectsOn;
        }

        [Serializable]
        public class AnimeInfo
        {
            public string name = string.Empty;
            public string state = string.Empty;
        }

#if UNITY_EDITOR
        [ButtonMethod]
        public void InitializeItemMultiple()
        {
            Selection.objects
                .OfType<GameObject>()
                .Select(o => o.GetComponent<ItemComponent>())
                .ToList()
                .ForEach(i => { i.InitializeItem(); });
        }

        [ButtonMethod]
        public void InitializeItem()
        {
            gameObject.layer = 11;
            GetComponentsInChildren<Transform>().ToList().ForEach(x => x.gameObject.layer = 11);

            if (gameObject == null) return;
            var renderers = gameObject.GetComponentsInChildren<Renderer>();

            rendererInfos = renderers.Select(rendererComponent =>
            {
                var rendererInfo = new RendererInfo
                {
                    renderer = rendererComponent,
                    materials = rendererComponent.sharedMaterials.Select(material =>
                    {
                        var matInfo = new MaterialInfo
                        {
                            isColor1 = material.HasProperty("_Color"),
                            isPattern1 = material.HasProperty("_patternuv1"),
                            isEmission = material.HasProperty("_Emission"),
                            isAlpha = material.shader.name.Contains("Alpha"), // TODO: make this as utility and better detection of transparent shader.
                            isGlass = false, // Glass? 
                            isColor2 = material.HasProperty("_Color2"),
                            isPattern2 = material.HasProperty("_patternuv2"),
                            isColor3 = material.HasProperty("_Color3"),
                            isPattern3 = material.HasProperty("_patternuv3")
                        };
                        return matInfo;
                    }).ToArray()
                };
                return rendererInfo;
            }).ToArray();

            info = new Info[3];
            for (var i = 0; i < 3; i++) info[i] = new Info {defColor = Color.white};
        }

        [ButtonMethod]
        public void InitializeAnimations()
        {
            var animator = gameObject.GetComponent<Animator>();
            var controller = animator.runtimeAnimatorController;
            var clips = controller.animationClips;

            if (clips.Length <= 0)
            {
                isAnime = false;
                return;
            }

            var anims = new AnimeInfo[clips.Length];
            var index = 0;
            foreach (var clip in clips)
            {
                var animInfo = new AnimeInfo();

                // Make name not-developer friendly.
                var niceName = clip.name;
                if (niceName.IndexOf("|") > 0)
                    niceName = niceName.Substring(niceName.IndexOf("|") + 1);
                niceName = Regex.Replace(niceName, @"([a-z])([A-Z])", "$1 $2");
                niceName = Regex.Replace(niceName, @"([_-])", " ");
                niceName = Regex.Replace(niceName, @"(^| )[a-z]", m => m.ToString().ToUpper());

                // But put those in developer friendly form.
                animInfo.name = niceName;
                animInfo.state = clip.name;
                anims[index] = animInfo;
                index++;

                // Debug if you need em'
                //Debug.Log(niceName);
            }

            animeInfos = anims;
        }
#endif
    }
}