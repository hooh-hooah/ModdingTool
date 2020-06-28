using System;
using MyBox;
using UnityEngine;

namespace AIChara
{
	[DisallowMultipleComponent]
	public class CmpAccessory : CmpBase
	{
		public CmpAccessory() : base(true)
		{
		}
		
		[Separator("General Informations")]
		public bool typeHair;
		public Renderer[] rendNormal;

		[Separator("Color Informations")]
		[Header("BaseColor")]
		public bool useColor01;
		[ConditionalField(nameof(useColor01))] public bool useGloss01 = true;
		[ConditionalField(nameof(useColor01))] public bool useMetallic01 = true;
		[ConditionalField(nameof(useColor01))] public Color defColor01 = Color.white;
		[ConditionalField(nameof(useColor01))] public float defGlossPower01 = 0.5f;
		[ConditionalField(nameof(useColor01))] public float defMetallicPower01 = 0.5f;

		[Header("TopColor")]
		public bool useColor02;
		[ConditionalField(nameof(useColor02))] public bool useGloss02 = true;
		[ConditionalField(nameof(useColor02))] public bool useMetallic02 = true;
		[ConditionalField(nameof(useColor02))] public Color defColor02 = Color.white;
		[ConditionalField(nameof(useColor02))] public float defGlossPower02 = 0.5f;
		[ConditionalField(nameof(useColor02))] public float defMetallicPower02 = 0.5f;

		[Header("UnderColor")]
		public bool useColor03;
		[ConditionalField(nameof(useColor03))] public bool useGloss03 = true;
		[ConditionalField(nameof(useColor03))] public bool useMetallic03 = true;
		[ConditionalField(nameof(useColor03))] public Color defColor03 = Color.white;
		[ConditionalField(nameof(useColor03))] public float defGlossPower03 = 0.5f;
		[ConditionalField(nameof(useColor03))] public float defMetallicPower03 = 0.5f;

		[Header("Fixed Color")]
		public Renderer[] rendAlpha;
		public bool useGloss04 = true;
		public bool useMetallic04 = true;
		public Color defColor04 = Color.white;
		public float defGlossPower04 = 0.5f;
		public float defMetallicPower04 = 0.5f;
		
		[Separator("Adjustment Transform")]
		public Transform trfMove01;
		public Transform trfMove02;

		[HideInInspector]
		public int setcolor;
		
		public override void SetReferenceObject()
		{
			FindAssist findAssist = new FindAssist();
			findAssist.Initialize(base.transform);
			this.trfMove01 = findAssist.GetTransformFromName("N_move");
			this.trfMove02 = findAssist.GetTransformFromName("N_move2");
			this.SetColor();
		}
		
		public void SetColor()
		{
			if (this.rendNormal != null && this.rendNormal.Length != 0)
			{
				Material sharedMaterial = this.rendNormal[0].sharedMaterial;
				if (null != sharedMaterial)
				{
					if (sharedMaterial.HasProperty("_Color"))
					{
						this.defColor01 = sharedMaterial.GetColor("_Color");
					}
					if (sharedMaterial.HasProperty("_Glossiness"))
					{
						this.defGlossPower01 = sharedMaterial.GetFloat("_Glossiness");
					}
					if (sharedMaterial.HasProperty("_Metallic"))
					{
						this.defMetallicPower01 = sharedMaterial.GetFloat("_Metallic");
					}
					if (sharedMaterial.HasProperty("_Color2"))
					{
						this.defColor02 = sharedMaterial.GetColor("_Color2");
					}
					if (sharedMaterial.HasProperty("_Glossiness2"))
					{
						this.defGlossPower02 = sharedMaterial.GetFloat("_Glossiness2");
					}
					if (sharedMaterial.HasProperty("_Metallic2"))
					{
						this.defMetallicPower02 = sharedMaterial.GetFloat("_Metallic2");
					}
					if (sharedMaterial.HasProperty("_Color3"))
					{
						this.defColor03 = sharedMaterial.GetColor("_Color3");
					}
					if (sharedMaterial.HasProperty("_Glossiness3"))
					{
						this.defGlossPower03 = sharedMaterial.GetFloat("_Glossiness3");
					}
					if (sharedMaterial.HasProperty("_Metallic3"))
					{
						this.defMetallicPower03 = sharedMaterial.GetFloat("_Metallic3");
					}
				}
			}
			if (this.rendAlpha != null && this.rendAlpha.Length != 0)
			{
				Material sharedMaterial2 = this.rendAlpha[0].sharedMaterial;
				if (null != sharedMaterial2)
				{
					if (sharedMaterial2.HasProperty("_Color"))
					{
						this.defColor04 = sharedMaterial2.GetColor("_Color");
					}
					if (sharedMaterial2.HasProperty("_Glossiness4"))
					{
						this.defGlossPower04 = sharedMaterial2.GetFloat("_Glossiness4");
					}
					if (sharedMaterial2.HasProperty("_Metallic4"))
					{
						this.defMetallicPower04 = sharedMaterial2.GetFloat("_Metallic4");
					}
				}
			}
		}
	}
}
