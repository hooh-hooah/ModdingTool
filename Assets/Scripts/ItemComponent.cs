using System;
using System.Linq;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.UI;

namespace Studio
{
	[AddComponentMenu("AI_Shoujo ItemComponent")]
	public class ItemComponent : MonoBehaviour
	{
		[Serializable]
		public class MaterialInfo
		{
			public bool isColor1;

			public bool isPattern1;

			public bool isColor2;

			public bool isPattern2;

			public bool isColor3;

			public bool isPattern3;

			public bool isEmission;

			public bool isAlpha;

			public bool isGlass;

			public bool CheckColor(int _idx)
			{
				if (_idx == 0)
				{
					return this.isColor1;
				}
				if (_idx != 1)
				{
					return _idx == 2 && this.isColor3;
				}
				return this.isColor2;
			}

			public bool CheckPattern(int _idx)
			{
				if (_idx == 0)
				{
					return this.isPattern1;
				}
				if (_idx != 1)
				{
					return _idx == 2 && this.isPattern3;
				}
				return this.isPattern2;
			}
		}

		[Serializable]
		public class RendererInfo
		{
			public Renderer renderer;

			public ItemComponent.MaterialInfo[] materials;

			public bool IsNormal
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isColor1 || m.isColor2 || m.isColor3 || m.isEmission);
				}
			}

			public bool IsAlpha
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isAlpha);
				}
			}

			public bool IsGlass
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isGlass);
				}
			}

			public bool IsColor
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isColor1 || m.isColor2 || m.isColor3);
				}
			}

			public bool IsColor1
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isColor1);
				}
			}

			public bool IsColor2
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isColor2);
				}
			}

			public bool IsColor3
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isColor3);
				}
			}

			public bool IsPattern
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isPattern1 || m.isPattern2 || m.isPattern3);
				}
			}

			public bool IsPattern1
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isPattern1);
				}
			}

			public bool IsPattern2
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isPattern2);
				}
			}

			public bool IsPattern3
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isPattern3);
				}
			}

			public bool IsEmission
			{
				[CompilerGenerated]
				get
				{
					return this.materials.Any((ItemComponent.MaterialInfo m) => m.isEmission);
				}
			}
		}

		[Serializable]
		public class Info
		{
			[Header("Default Color")]
			public Color defColor = Color.white;

			[Header("Use Metalic?")]
			public bool useMetallic;

			public float defMetallic;

			public float defGlossiness;

			[Header("Use Color Pattern?")]
			public Color defColorPattern = Color.white;

			public bool defClamp = true;

			public Vector4 defUV = Vector4.zero;

			public float defRot;

			public float ut
			{
				get
				{
					return this.defUV.z;
				}
				set
				{
					this.defUV.z = value;
				}
			}

			public float vt
			{
				get
				{
					return this.defUV.w;
				}
				set
				{
					this.defUV.w = value;
				}
			}

			public float us
			{
				get
				{
					return this.defUV.x;
				}
				set
				{
					this.defUV.x = value;
				}
			}

			public float vs
			{
				get
				{
					return this.defUV.y;
				}
				set
				{
					this.defUV.y = value;
				}
			}
		}

		[Serializable]
		public class OptionInfo
		{
			public GameObject[] objectsOn;

			public GameObject[] objectsOff;

			public bool Visible
			{
				set
				{
					if (value)
					{
						this.SetVisible(this.objectsOff, false);
						this.SetVisible(this.objectsOn, true);
					}
					else
					{
						this.SetVisible(this.objectsOn, false);
						this.SetVisible(this.objectsOff, true);
					}
				}
			}

			private void SetVisible(GameObject[] _objects, bool _value)
			{
				// Set things invisible.
			}
		}

		[Serializable]
		public class AnimeInfo
		{
			public string name = string.Empty;

			public string state = string.Empty;

			public bool Check
			{
                // check shits in game
                get {
                    return true;
                }
			}
		}

		[Header("Renderer Lists: Put all renderers in here.")]
		public ItemComponent.RendererInfo[] rendererInfos;

		[Header("Item Informations"), Space]
		public ItemComponent.Info[] info;

		public float alpha = 1f;

		[Header("Glass Information")]
		public Color defGlass = Color.white;

		[ColorUsage(false, true), Header("Emission Information")]
		public Color defEmissionColor = Color.clear;

		public float defEmissionStrength;

		public float defLightCancel;

		[Header("Child Root Transform")]
		public Transform childRoot;

		[Header("Animation Information"), Tooltip("Does item have animation?")]
		public bool isAnime;

		public ItemComponent.AnimeInfo[] animeInfos;

		[Header("Does item scalable")]
		public bool isScale = true;

		[Header("Options")]
		public ItemComponent.OptionInfo[] optionInfos;

        // we're not going to use it (mostly.)
        [Header("Does it utilizes sea shader? (Mostly unused)")]
		private GameObject objSeaParent;

        private Renderer[] renderersSea;

        [Header("Sea shader color")]
        private int setcolor;

		public bool check
		{
			get
			{
                // check shits in game
                return true;
			}
		}

		public bool checkAlpha
		{
			get {
                // check shits in game
                return true;
            }
		}

		public bool checkGlass
		{
			get {
                // check shits in game
                return true;
            }
		}

		public bool checkEmissionColor
		{
			[CompilerGenerated]
			get {
                // check shits in game
                return true;
            }
		}

		public bool checkEmissionStrength
		{
			[CompilerGenerated]
			get {
                // check shits in game
                return true;
            }
		}

		public bool CheckEmission
		{
			get {
                // check shits in game
                return true;
            }
		}

		public bool checkLightCancel
		{
			[CompilerGenerated]
			get {
                // check shits in game
                return true;
            }
		}

		public bool CheckOption
		{
			[CompilerGenerated]
			get {
                // check shits in game
                return true;
            }
		}

		public bool CheckAnimePattern
		{
			[CompilerGenerated]
			get {
                // check shits in game
                return true;
            }
		}

		public Color[] defColorMain
		{
			get {
                // check shits in game
                return new Color[1];
            }
		}

		public Color[] defColorPattern
		{
			get {
                // check shits in game
                return new Color[1];
            }
		}

		public bool[] useColor {
            get {
                // check shits in game
                return new bool[1];
            }
        }

		public bool[] useMetallic
		{
			get {
                // check shits in game
                return new bool[1];
            }
		}

		public bool[] usePattern
		{
			get {
                // check shits in game
                return new bool[1];
            }
		}

		public Color DefEmissionColor
		{
			[CompilerGenerated]
			get
			{
				return new Color();
			}
		}

		public ItemComponent.Info this[int _idx]
		{
			get
			{
                return new ItemComponent.Info();
			}
		}

		public void UpdateColor()
		{
            // Update colors from this.rendererInfos
		}

		public void SetPatternTex(int _idx, Texture2D _texture)
		{
            // Update patterns from this.rendererInfos
            // From ItemShader PatternMasks
		}

		public void SetOptionVisible(bool _value)
		{
            // set all option infos not visible.
		}

		public void SetOptionVisible(int _idx, bool _value)
		{
            // set all option infos visble.
		}

		public void SetColor()
		{
            // get all renderer from rendererInfos
			//bool[] array = Enumerable.Repeat<bool>(false, 7).ToArray<bool>();
			//foreach (ItemComponent.RendererInfo current in from r in this.rendererInfos
			//where r.renderer != null && !r.materials.IsNullOrEmpty<ItemComponent.MaterialInfo>()
			//where r.materials.Any((ItemComponent.MaterialInfo _m) => _m.isColor1)
			//select r)
			//{
			//	if (!array.Take(3).All((bool _b) => _b))
			//	{
			//		foreach (Tuple<ItemComponent.MaterialInfo, int> current2 in current.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isColor1))
			//		{
			//			Material material = current.renderer.sharedMaterials.SafeGet(current2.Item2);
			//			if (!(material == null))
			//			{
			//				if (!array[0] && material.HasProperty("_Color"))
			//				{
			//					this.info[0].defColor = material.GetColor("_Color");
			//					array[0] = true;
			//				}
			//				if (!array[1] && material.HasProperty("_Metallic"))
			//				{
			//					this.info[0].defMetallic = material.GetFloat("_Metallic");
			//					array[1] = true;
			//				}
			//				if (!array[2] && material.HasProperty("_Glossiness"))
			//				{
			//					this.info[0].defGlossiness = material.GetFloat("_Glossiness");
			//					array[2] = true;
			//				}
			//				if (array.Take(3).All((bool _b) => _b))
			//				{
			//					break;
			//				}
			//			}
			//		}
			//	}
			//	if (!array.Skip(3).All((bool _b) => _b))
			//	{
			//		foreach (Tuple<ItemComponent.MaterialInfo, int> current3 in current.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isColor1 && v.Item1.isPattern1))
			//		{
			//			Material material2 = current.renderer.sharedMaterials.SafeGet(current3.Item2);
			//			if (!(material2 == null))
			//			{
			//				if (!array[3] && material2.HasProperty("_Color1_2"))
			//				{
			//					this.info[0].defColorPattern = material2.GetColor("_Color1_2");
			//					array[3] = true;
			//				}
			//				if (!array[4] && material2.HasProperty("_patternuv1"))
			//				{
			//					this.info[0].defUV = material2.GetVector("_patternuv1");
			//					array[4] = true;
			//				}
			//				if (!array[5] && material2.HasProperty("_patternuv1Rotator"))
			//				{
			//					this.info[0].defRot = material2.GetFloat("_patternuv1Rotator");
			//					array[5] = true;
			//				}
			//				if (!array[6] && material2.HasProperty("_patternclamp1"))
			//				{
			//					this.info[0].defClamp = (material2.GetFloat("_patternclamp1") != 0f);
			//					array[6] = true;
			//				}
			//				if (array.Skip(3).All((bool _b) => _b))
			//				{
			//					break;
			//				}
			//			}
			//		}
			//	}
			//	if (array.All((bool _b) => _b))
			//	{
			//		break;
			//	}
			//}
			//bool[] array2 = Enumerable.Repeat<bool>(false, 7).ToArray<bool>();
			//foreach (ItemComponent.RendererInfo current4 in from r in this.rendererInfos
			//where r.renderer != null && !r.materials.IsNullOrEmpty<ItemComponent.MaterialInfo>()
			//where r.materials.Any((ItemComponent.MaterialInfo _m) => _m.isColor2)
			//select r)
			//{
			//	if (!array2.Take(3).All((bool _b) => _b))
			//	{
			//		foreach (Tuple<ItemComponent.MaterialInfo, int> current5 in current4.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isColor2))
			//		{
			//			Material material3 = current4.renderer.sharedMaterials.SafeGet(current5.Item2);
			//			if (!(material3 == null))
			//			{
			//				if (!array2[0] && material3.HasProperty("_Color2"))
			//				{
			//					this.info[1].defColor = material3.GetColor("_Color2");
			//					array2[0] = true;
			//				}
			//				if (!array2[1] && material3.HasProperty("_Metallic2"))
			//				{
			//					this.info[1].defMetallic = material3.GetFloat("_Metallic2");
			//					array2[1] = true;
			//				}
			//				if (!array2[2] && material3.HasProperty("_Glossiness2"))
			//				{
			//					this.info[1].defGlossiness = material3.GetFloat("_Glossiness2");
			//					array2[2] = true;
			//				}
			//				if (array2.Take(3).All((bool _b) => _b))
			//				{
			//					break;
			//				}
			//			}
			//		}
			//	}
			//	if (!array2.Skip(3).All((bool _b) => _b))
			//	{
			//		foreach (Tuple<ItemComponent.MaterialInfo, int> current6 in current4.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isColor2 && v.Item1.isPattern2))
			//		{
			//			Material material4 = current4.renderer.sharedMaterials.SafeGet(current6.Item2);
			//			if (!(material4 == null))
			//			{
			//				if (!array2[3] && material4.HasProperty("_Color2_2"))
			//				{
			//					this.info[1].defColorPattern = material4.GetColor("_Color2_2");
			//					array2[3] = true;
			//				}
			//				if (!array2[4] && material4.HasProperty("_patternuv2"))
			//				{
			//					this.info[1].defUV = material4.GetVector("_patternuv2");
			//					array2[4] = true;
			//				}
			//				if (!array2[5] && material4.HasProperty("_patternuv2Rotator"))
			//				{
			//					this.info[1].defRot = material4.GetFloat("_patternuv2Rotator");
			//					array2[5] = true;
			//				}
			//				if (!array2[6] && material4.HasProperty("_patternclamp2"))
			//				{
			//					this.info[1].defClamp = (material4.GetFloat("_patternclamp2") != 0f);
			//					array2[6] = true;
			//				}
			//				if (array2.Skip(3).All((bool _b) => _b))
			//				{
			//					break;
			//				}
			//			}
			//		}
			//	}
			//	if (array2.All((bool _b) => _b))
			//	{
			//		break;
			//	}
			//}
			//bool[] array3 = Enumerable.Repeat<bool>(false, 7).ToArray<bool>();
			//foreach (ItemComponent.RendererInfo current7 in from r in this.rendererInfos
			//where r.renderer != null && !r.materials.IsNullOrEmpty<ItemComponent.MaterialInfo>()
			//where r.materials.Any((ItemComponent.MaterialInfo _m) => _m.isColor3)
			//select r)
			//{
			//	if (!array3.Take(3).All((bool _b) => _b))
			//	{
			//		foreach (Tuple<ItemComponent.MaterialInfo, int> current8 in current7.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isColor3))
			//		{
			//			Material material5 = current7.renderer.sharedMaterials.SafeGet(current8.Item2);
			//			if (!(material5 == null))
			//			{
			//				if (!array3[0] && material5.HasProperty("_Color3"))
			//				{
			//					this.info[2].defColor = material5.GetColor("_Color3");
			//					array3[0] = true;
			//				}
			//				if (!array3[1] && material5.HasProperty("_Metallic3"))
			//				{
			//					this.info[2].defMetallic = material5.GetFloat("_Metallic3");
			//					array3[1] = true;
			//				}
			//				if (!array3[2] && material5.HasProperty("_Glossiness3"))
			//				{
			//					this.info[2].defGlossiness = material5.GetFloat("_Glossiness3");
			//					array3[2] = true;
			//				}
			//				if (array3.Take(3).All((bool _b) => _b))
			//				{
			//					break;
			//				}
			//			}
			//		}
			//	}
			//	if (!array3.Skip(3).All((bool _b) => _b))
			//	{
			//		foreach (Tuple<ItemComponent.MaterialInfo, int> current9 in current7.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isColor3 && v.Item1.isPattern3))
			//		{
			//			Material material6 = current7.renderer.sharedMaterials.SafeGet(current9.Item2);
			//			if (!(material6 == null))
			//			{
			//				if (!array3[3] && material6.HasProperty("_Color3_2"))
			//				{
			//					this.info[2].defColorPattern = material6.GetColor("_Color3_2");
			//					array3[3] = true;
			//				}
			//				if (!array3[4] && material6.HasProperty("_patternuv3"))
			//				{
			//					this.info[2].defUV = material6.GetVector("_patternuv3");
			//					array3[4] = true;
			//				}
			//				if (!array3[5] && material6.HasProperty("_patternuv3Rotator"))
			//				{
			//					this.info[2].defRot = material6.GetFloat("_patternuv3Rotator");
			//					array3[5] = true;
			//				}
			//				if (!array3[6] && material6.HasProperty("_patternclamp3"))
			//				{
			//					this.info[2].defClamp = (material6.GetFloat("_patternclamp3") != 0f);
			//					array3[6] = true;
			//				}
			//				if (array3.Skip(3).All((bool _b) => _b))
			//				{
			//					break;
			//				}
			//			}
			//		}
			//	}
			//	if (array3.All((bool _b) => _b))
			//	{
			//		break;
			//	}
			//}
			//ItemComponent.RendererInfo rendererInfo = (from r in this.rendererInfos
			//where r.renderer != null && !r.materials.IsNullOrEmpty<ItemComponent.MaterialInfo>()
			//select r).FirstOrDefault((ItemComponent.RendererInfo _i) => _i.materials.Any((ItemComponent.MaterialInfo _m) => _m.isAlpha));
			//if (rendererInfo != null)
			//{
			//	Material[] sharedMaterials = rendererInfo.renderer.sharedMaterials;
			//	for (int i = 0; i < sharedMaterials.Length; i++)
			//	{
			//		ItemComponent.MaterialInfo materialInfo = rendererInfo.materials.SafeGet(i);
			//		if (materialInfo != null && materialInfo.isAlpha)
			//		{
			//			if (null != sharedMaterials[i] && sharedMaterials[i].HasProperty("_alpha"))
			//			{
			//				this.alpha = sharedMaterials[i].GetFloat("_alpha");
			//			}
			//		}
			//	}
			//}
			//ItemComponent.RendererInfo rendererInfo2 = (from r in this.rendererInfos
			//where r.renderer != null && !r.materials.IsNullOrEmpty<ItemComponent.MaterialInfo>()
			//select r).FirstOrDefault((ItemComponent.RendererInfo _i) => _i.materials.Any((ItemComponent.MaterialInfo _m) => _m.isGlass));
			//if (rendererInfo2 != null)
			//{
			//	Material[] sharedMaterials2 = rendererInfo2.renderer.sharedMaterials;
			//	for (int j = 0; j < sharedMaterials2.Length; j++)
			//	{
			//		ItemComponent.MaterialInfo materialInfo2 = rendererInfo2.materials.SafeGet(j);
			//		if (materialInfo2 != null && materialInfo2.isGlass)
			//		{
			//			if (null != sharedMaterials2[j] && sharedMaterials2[j].HasProperty("_Color4"))
			//			{
			//				this.defGlass = sharedMaterials2[j].GetColor("_Color4");
			//			}
			//		}
			//	}
			//}
			//this.SetEmission();
		}

		public void SetEmission()
		{
			//bool[] array = new bool[3];
			//foreach (ItemComponent.RendererInfo current in from v in this.rendererInfos
			//where v.materials.Any((ItemComponent.MaterialInfo m) => m.isEmission)
			//select v)
			//{
			//	foreach (Tuple<ItemComponent.MaterialInfo, int> current2 in current.materials.Select((ItemComponent.MaterialInfo _m, int index) => new Tuple<ItemComponent.MaterialInfo, int>(_m, index)).Where((Tuple<ItemComponent.MaterialInfo, int> v) => v.Item1.isEmission))
			//	{
			//		Material material = current.renderer.sharedMaterials[current2.Item2];
			//		if (!(material == null))
			//		{
			//			if (!array[0] && material.HasProperty("_EmissionColor"))
			//			{
			//				this.defEmissionColor = material.GetColor("_EmissionColor");
			//				array[0] = true;
			//			}
			//			if (!array[1] && material.HasProperty("_EmissionStrength"))
			//			{
			//				this.defEmissionStrength = material.GetFloat("_EmissionStrength");
			//				array[1] = true;
			//			}
			//			if (!array[2] && material.HasProperty("_LightCancel"))
			//			{
			//				this.defLightCancel = material.GetFloat("_LightCancel");
			//				array[2] = true;
			//			}
			//			if (array.All((bool _b) => _b))
			//			{
			//				break;
			//			}
			//		}
			//	}
			//	if (array.All((bool _b) => _b))
			//	{
			//		break;
			//	}
			//}
		}

		public void SetSeaRenderer()
		{
			//if (this.objSeaParent == null)
			//{
			//	return;
			//}
			//this.renderersSea = this.objSeaParent.GetComponentsInChildren<Renderer>();
		}

		public void SetupSea()
		{
			//if (this.renderersSea.IsNullOrEmpty<Renderer>())
			//{
			//	return;
			//}
			//foreach (Renderer current in from v in this.renderersSea
			//where v != null
			//select v)
			//{
			//	Material material = current.material;
			//	material.DisableKeyword("USINGWATERVOLUME");
			//	current.material = material;
			//}
		}

		private bool HasProperty(Renderer[] _renderer, int _nameID)
		{
			return _renderer.Any((Renderer r) => r.materials.Any((Material m) => m.HasProperty(_nameID)));
		}

		private bool HasEmissionColor()
		{
			//foreach (ItemComponent.RendererInfo current in from v in this.rendererInfos
			//where v.materials.Any((ItemComponent.MaterialInfo m) => m.isEmission)
			//select v)
			//{
			//	Material[] materials = current.renderer.materials;
			//	for (int i = 0; i < materials.Length; i++)
			//	{
			//		ItemComponent.MaterialInfo materialInfo = current.materials.SafeGet(i);
			//		if (materialInfo != null && materialInfo.isEmission)
			//		{
			//			if (materials[i].HasProperty(ItemShader._EmissionColor))
			//			{
			//				return true;
			//			}
			//		}
			//	}
			//}
			return false;
		}

		private bool HasEmissionStrength()
		{
			//foreach (ItemComponent.RendererInfo current in from v in this.rendererInfos
			//where v.materials.Any((ItemComponent.MaterialInfo m) => m.isEmission)
			//select v)
			//{
			//	Material[] materials = current.renderer.materials;
			//	for (int i = 0; i < materials.Length; i++)
			//	{
			//		ItemComponent.MaterialInfo materialInfo = current.materials.SafeGet(i);
			//		if (materialInfo != null && materialInfo.isEmission)
			//		{
			//			if (materials[i].HasProperty(ItemShader._EmissionStrength))
			//			{
			//				return true;
			//			}
			//		}
			//	}
			//}
			return false;
		}
	}
}
