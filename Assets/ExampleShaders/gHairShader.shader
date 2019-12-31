// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

/*********************************************************************************************************************/
// Genesis Hair Shader
// gHairSHader.shader
// by Olander (Don Anderson)
// Copyright (c): 2014 Stand Sure Automation
//
/*
Description:
- A fast and high quality shader that will work in many various modes as well as react to lighting.
- Forward and Deferred
- Gamma and Linear
- Developed in v5.4 (works in any Unity 5 version)

Usage:
- Please follow workflow for preparing the textures for the game hair materials

Acknowledgment:
I was able to solve this shader by help from the Unity Forums. Many of the code solutions were from Unity 4 but still
seemed to apply to Unity 5. Thank you.

*/
/*********************************************************************************************************************/

Shader "Genesis/Hair Shader"
{
	Properties
	{
		//Base UV Hair Texture. PNG with Alpha. Please follow workflow for preparing this texture
		[NoScaleOffset] _MainTex("Diffuse (RGB) Alpha (A) (PNG)", 2D) = "white" {}
		
		//Full Color Range Tinting of Hair
		_HairTint("Color Adjustment (Minor Visual Adjustment. Default White)", Color) = (1, 1, 1, 1)
		
		[Gamma] _Richness("Richness of Hair (1.0 Default)", Range(0,1)) = 1.0
		_Glossiness("Wetness/Gloss (0.25 Default)", Range(0,1)) = 0.25
		
		//Normal Map Texture. Please follow workflow for preparing this texture
		[NoScaleOffset] _BumpMap("Normal Map (PNG)", 2D) = "bump" {}
		_BumpScale("Normal Map Adjustment (1.0 Default)", Float) = 1.0

		//Add transparnecy to ends of hair
		_Cutoff("Alpha Cutoff", Range(0.01,1)) = 0.5
	}
	
	SubShader
	{
		Tags{ "Queue" = "AlphaTest" "IgnoreProjector" = "True" "RenderType" = "TransparentCutout" }
		Blend SrcAlpha OneMinusSrcAlpha
		LOD 200
		ZWrite Off
		Cull Off

		Pass
		{
			ColorMask 0
			ZWrite On

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct v2f 
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};

			sampler2D _MainTex;
			fixed _Cutoff;

			v2f vert(appdata_img v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = v.texcoord;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target
			{
				fixed4 mainColor = tex2D(_MainTex, i.texcoord);
				clip(mainColor.a - _Cutoff);
				return 0;
			}
			ENDCG
		}

		Pass
		{
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			Cull Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_shadowcaster
			#include "UnityCG.cginc"

			struct v2f 
			{
				V2F_SHADOW_CASTER;
				float2 texcoord : TEXCOORD1;
			};

			v2f vert(appdata_base v)
			{
				v2f o;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				o.texcoord = v.texcoord;
				return o;
			}

			sampler2D _MainTex;
			fixed _Cutoff;

			float4 frag(v2f i) : SV_Target
			{
				fixed4 mainColor = tex2D(_MainTex, i.texcoord);
				clip(mainColor.a - _Cutoff);
				SHADOW_CASTER_FRAGMENT(i)
			}
			ENDCG
		}

		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows alpha:fade nolightmap
		#pragma target 3.0
		
		struct Input 
		{
			float2 uv_MainTex;
			float2 uv_SpecMap;
			fixed facing : VFACE;
		};

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _SpecMap;

		fixed4 _HairTint;
		half _Glossiness;
		half _Richness;		
		half _BumpScale;
		fixed _Cutoff;

		void surf(Input IN, inout SurfaceOutputStandard o) 
		{			
			fixed4 mainColor = tex2D(_MainTex, IN.uv_MainTex) * _HairTint;
			fixed4 specTex = tex2D(_SpecMap, IN.uv_MainTex);
			o.Albedo = mainColor.rgb;
			o.Metallic = _Richness;
			o.Smoothness = _Glossiness;
						
			o.Alpha = saturate(mainColor.a / _Cutoff);

			o.Normal = UnpackScaleNormal(tex2D(_BumpMap, IN.uv_MainTex), _BumpScale);

			if (IN.facing < 0.5)
			{
				o.Normal *= -1.0;
			}
		}
		ENDCG
	}
	FallBack "Diffuse"
}