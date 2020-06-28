using System;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Runtime.Remoting.Messaging;
using System.Text.RegularExpressions;
using JetBrains.Annotations;
using UnityEngine;
using MyBox;

namespace Studio
{
	[AddComponentMenu("AIHS2 ItemComponent")]
	public class ItemComponent : MonoBehaviour
	{
		[Serializable]
		public class MaterialInfo
		{
			public bool isColor1;
			public bool isPattern1;
			public bool isEmission;
			public bool isAlpha;
			public bool isGlass;
			public bool isColor2;
			public bool isPattern2;
			public bool isColor3;
			public bool isPattern3;
		}

		[Serializable]
		public class RendererInfo
		{
			[MustBeAssigned]
			public Renderer renderer;
			public ItemComponent.MaterialInfo[] materials;
		}

		[Serializable]
		public class Info
		{
			[Header("Material Properties")]
			public Color defColor = Color.white;
			public bool useMetallic;
			[ConditionalField(nameof(useMetallic)), Range(0f, 1f)]
			public float defMetallic;
			[Range(0f, 1f)]
			public float defGlossiness;
			[Header("Pattern Properties"), Space]
			public Color defColorPattern = Color.white;
			public bool defClamp = true;
			public Vector4 defUV = Vector4.zero;
			public float defRot;
		}

		[Serializable]
		public class OptionInfo
		{
			[Tooltip("The objects that go visible when option is turned on")]
			public GameObject[] objectsOn;
			[Tooltip("The objects that go invisible when option is turned off")]
			public GameObject[] objectsOff;
		}

		[Serializable]
		public class AnimeInfo
		{
			public string name = string.Empty;
			public string state = string.Empty;
		}

		/*
		 * Renderer Properties
		 */
		[Separator("Renderer Information")]
		public ItemComponent.RendererInfo[] rendererInfos;
		
		/*
		 * Color Properties
		 */
		[Separator("Color Information")]
		public ItemComponent.Info[] info = new ItemComponent.Info[3];
		[Range(0f, 1f)]
		public float alpha = 1f;
		public Color defGlass = Color.white;
		[ColorUsage(false, true)]
		public Color defEmissionColor = Color.clear;
		[Range(0f, 1f)]
		public float defEmissionStrength;
		[Range(0f, 1f)]
		public float defLightCancel;

		/*
		 * Animation Properties
		 */
		[Separator("Animation Information")]
		public bool isAnime;
		[ConditionalField(nameof(isAnime))]
		public ItemComponent.AnimeInfo[] animeInfos;
		
		/*
		 * Option Properties
		 */
		[Separator("Option Information")]
		public Transform childRoot;
		public bool isScale = true;
		public ItemComponent.OptionInfo[] optionInfos;

		/*
		 *  Widely Unused Properties
		 */
        [HideInInspector]
		public GameObject objSeaParent;
		[HideInInspector]
        public Renderer[] renderersSea;
        [HideInInspector]
        public int setcolor;

        [ButtonMethod]
        public void InitializeItem()
        {
	        gameObject.layer = 10;

	        if (gameObject != null)
	        {
		        var renderers = gameObject.GetComponentsInChildren<Renderer>();
		        rendererInfos = new RendererInfo[renderers.Length];
		        for (var i = 0; i < renderers.Length; i++)
		        {
			        var renderer = renderers[i];
			        renderer.gameObject.layer = 10;
			        rendererInfos[i] = new RendererInfo();
			        rendererInfos[i].renderer = renderer;
			        rendererInfos[i].materials = new MaterialInfo[renderer.sharedMaterials.Length];
			        for (var k = 0; k < renderer.sharedMaterials.Length; k++)
			        {
				        rendererInfos[i].materials[k] = new MaterialInfo();
				        rendererInfos[i].materials[k].isColor1 = true;
			        }
		        }

		        info = new Info[3];
		        for (var i = 0; i < 3; i++)
		        {
			        info[i] = new Info();
			        info[i].defColor = Color.white;
		        }
	        }
        }
        
        [ButtonMethod]
        public void InitializeAnimations()
        {
            Animator animator = gameObject.GetComponent<Animator>();
            RuntimeAnimatorController controller = animator.runtimeAnimatorController;
            AnimationClip[] clips = controller.animationClips;
            
            ItemComponent.AnimeInfo[] anims = new ItemComponent.AnimeInfo[clips.Length];
            int index = 0;
            foreach (var clip in clips) {
                ItemComponent.AnimeInfo animInfo = new ItemComponent.AnimeInfo();
                
                // Make name not-developer friendly.
                string niceName = clip.name;
                if (niceName.IndexOf("|") > 0)
                    niceName = niceName.Substring(niceName.IndexOf("|")+1);
                niceName = Regex.Replace(niceName, @"([a-z])([A-Z])", "$1 $2");
                niceName = Regex.Replace(niceName, @"([_-])", " ");
                niceName = Regex.Replace(niceName, @"(^| )[a-z]", m => m.ToString().ToUpper());

                // But put those shit in developer friendly form.
                animInfo.name = niceName;
                animInfo.state = clip.name;
                anims[index] = animInfo;
                index++;

                // Debug if you need em'
                //Debug.Log(niceName);
            }
            animeInfos = anims;
        }
	}
}
