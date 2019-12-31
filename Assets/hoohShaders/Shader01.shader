// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/ClotheReplicaAlpha"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_DetailNormalMap2("DetailNormalMap2", 2D) = "bump" {}
		_DetailNormalMap("DetailNormalMap", 2D) = "bump" {}
		_Color1_2("Color1_2", Color) = (1,1,1,1)
		_Color1("Color1", Color) = (1,1,1,1)
		_Color2("Color2", Color) = (1,1,1,1)
		_Color3("Color3", Color) = (1,1,1,1)
		_Color3_2("Color3_2", Color) = (1,1,1,1)
		_Emission("Emission", Color) = (1,1,1,1)
		_Color2_2("Color2_2", Color) = (1,1,1,1)
		_BaseColor("BaseColor", Color) = (0.7075472,0.7075472,0.7075472,1)
		_BumpMap("BumpMap", 2D) = "bump" {}
		_DetailGlossMap("DetailGlossMap", 2D) = "white" {}
		_DetailMainTex("DetailMainTex", 2D) = "white" {}
		_DetailMask("DetailMask", 2D) = "white" {}
		_MetalicGlossMap("MetalicGlossMap", 2D) = "white" {}
		_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_WeatheringMap("WeatheringMap", 2D) = "white" {}
		_WeatheringMask("WeatheringMask", 2D) = "white" {}
		_AlphaMask("AlphaMask", 2D) = "white" {}
		_AlphaMask2("AlphaMask2", 2D) = "white" {}
		_DetailGlossMap2("DetailGlossMap2", 2D) = "white" {}
		_CutoutMap("CutoutMap", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_BumpScale("BumpScale", Range( 0 , 3)) = 1
		_Metallic2("Metallic2", Range( 0 , 1)) = 0.2
		_Metallic3("Metallic3", Range( 0 , 1)) = 0.2
		_Metallic4("Metallic4", Range( 0 , 1)) = 0.2
		_Metallic("Metallic", Range( 0 , 1)) = 0.2
		_DetailNormalMapScale("DetailNormalMapScale", Range( 0 , 3)) = 1
		_DetailNormalMapScale2("DetailNormalMapScale2", Range( 0 , 1)) = 0.2
		_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
		_Glossiness4("Glossiness4", Range( 0 , 1)) = 0.2
		_Glossiness("Glossiness", Range( 0 , 1)) = 0.2
		_Glossiness3("Glossiness3", Range( 0 , 1)) = 0.2
		_Glossiness2("Glossiness2", Range( 0 , 1)) = 0.2
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Metallic2;
		uniform sampler2D _AlphaMask;
		uniform float4 _Color1;
		uniform sampler2D _WeatheringMap;
		uniform float _Glossiness2;
		uniform sampler2D _DetailMask;
		uniform float4 _Color1_2;
		uniform float4 _Color3;
		uniform float _Metallic4;
		uniform float4 _Color2;
		uniform sampler2D _DetailGlossMap;
		uniform sampler2D _WeatheringMask;
		uniform sampler2D _DetailMainTex;
		uniform sampler2D _AlphaMask2;
		uniform float4 _Color3_2;
		uniform sampler2D _MetalicGlossMap;
		uniform float _Glossiness3;
		uniform float4 _Emission;
		uniform float4 _Color2_2;
		uniform float _Metallic3;
		uniform float _Glossiness4;
		uniform sampler2D _DetailGlossMap2;
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _DetailNormalMapScale;
		uniform sampler2D _DetailNormalMap;
		uniform float4 _DetailNormalMap_ST;
		uniform float _DetailNormalMapScale2;
		uniform sampler2D _DetailNormalMap2;
		uniform float4 _DetailNormalMap2_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _BaseColor;
		uniform float _Metallic;
		uniform float _Glossiness;
		uniform sampler2D _OcclusionMap;
		uniform float4 _OcclusionMap_ST;
		uniform float _OcclusionStrength;
		uniform sampler2D _CutoutMap;
		uniform float4 _CutoutMap_ST;
		uniform float _Cutoff = 0.5;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			float2 uv_DetailNormalMap2 = i.uv_texcoord * _DetailNormalMap2_ST.xy + _DetailNormalMap2_ST.zw;
			o.Normal = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), _DetailNormalMapScale ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap2, uv_DetailNormalMap2 ), _DetailNormalMapScale2 ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( tex2DNode1 * _BaseColor ).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			float4 temp_cast_1 = 1;
			float2 uv_OcclusionMap = i.uv_texcoord * _OcclusionMap_ST.xy + _OcclusionMap_ST.zw;
			float4 lerpResult69 = lerp( temp_cast_1 , tex2D( _OcclusionMap, uv_OcclusionMap ) , _OcclusionStrength);
			o.Occlusion = lerpResult69.r;
			o.Alpha = tex2DNode1.a;
			float2 uv_CutoutMap = i.uv_texcoord * _CutoutMap_ST.xy + _CutoutMap_ST.zw;
			clip( tex2D( _CutoutMap, uv_CutoutMap ).r - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
-1913;-1937;1905;730;1690.026;380.1673;2.13054;True;True
Node;AmplifyShaderEditor.RangedFloatNode;51;-2118.916,-62.86623;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;33;0;Create;True;0;0;False;0;1;0.45;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2131.859,-302.5865;Inherit;False;Property;_BumpScale;BumpScale;28;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;52;-2001.255,274.3195;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;34;0;Create;True;0;0;False;0;0.2;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1717.162,-347.8716;Inherit;True;Property;_BumpMap;BumpMap;10;0;Create;True;0;0;False;0;-1;None;0028c31e31481254ea3c037d7ccde824;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1723.702,-112.9841;Inherit;True;Property;_DetailNormalMap;DetailNormalMap;1;0;Create;True;0;0;False;0;-1;None;bbd5ac879498bb547a9170693cc51993;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1012.219,-754.2643;Inherit;True;Property;_MainTex;MainTex;22;0;Create;True;0;0;False;0;-1;None;747e680417ff5bf4db3ce6cbf21a461f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;258.1215,1155.488;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;38;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;67;100.4666,898.226;Inherit;False;Constant;_Int0;Int 0;50;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;73;-1657.974,214.0459;Inherit;True;Property;_DetailNormalMap2;DetailNormalMap2;0;0;Create;True;0;0;False;0;-1;None;e91090039642d45428dca1c1349499be;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;10;-1303.691,-205.7733;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;23;-50.6803,1005.243;Inherit;True;Property;_OcclusionMap;OcclusionMap;15;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-976.389,-535.9379;Inherit;False;Property;_BaseColor;BaseColor;9;0;Create;True;0;0;False;0;0.7075472,0.7075472,0.7075472,1;0.7075471,0.7075471,0.7075471,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;34;1512.875,-1080.157;Inherit;False;Property;_Color3_2;Color3_2;6;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;-1033.582,-1554.721;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;11;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;40.90875,-1447.877;Inherit;True;Property;_WeatheringMask;WeatheringMask;17;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-30.78015,1234.206;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;39;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;-1036.952,-1346.64;Inherit;True;Property;_DetailMainTex;DetailMainTex;12;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;46;1866.791,-346.636;Inherit;False;Property;_Cutoff;Cutoff;27;0;Create;True;0;0;False;0;0.2;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;42;1580.33,-1919.8;Inherit;False;Property;_patternuvbase;patternuvbase;48;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;49;-541.2062,227.7506;Inherit;False;Property;_DetailMetalicScale;DetailMetalicScale;36;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;28;-1034.887,-1955.337;Inherit;True;Property;_AlphaMask2;AlphaMask2;19;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;32;1236.875,-1084.157;Inherit;False;Property;_Color2_2;Color2_2;8;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;41;1582.33,-1787.8;Inherit;False;Property;_patternuv3;patternuv3;50;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;59;-143.4027,640.3181;Inherit;False;Property;_Glossiness3;Glossiness3;43;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;1815.808,-1072.987;Inherit;False;Property;_Emission;Emission;7;0;Create;True;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;35;-229.1248,-1370.157;Inherit;False;Property;_DetailUV;DetailUV;52;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;12;-140.7693,328.8997;Inherit;False;Property;_Metallic;Metallic;32;0;Create;True;0;0;False;0;0.2;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;74;537.8779,445.2287;Inherit;True;Property;_CutoutMap;CutoutMap;21;0;Create;True;0;0;False;0;-1;None;99d494db04e0f7d418de6c3f6a4c6a17;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;55;-31.78015,1322.206;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;40;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-145.1027,730.4181;Inherit;False;Property;_Glossiness4;Glossiness4;41;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;20;-1041.582,-1762.721;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;20;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;-531.5721,352.4899;Inherit;True;Property;_MetalicGlossMap;MetalicGlossMap;14;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;1582.33,-1654.8;Inherit;False;Property;_patternuv2;patternuv2;49;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;50;-546.3928,135.4199;Inherit;False;Property;_DetailMetalicScale2;DetailMetalicScale2;35;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;1297.178,-555.5657;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;23;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-506.3232,683.9952;Inherit;False;Property;_DetailGlossScale2;DetailGlossScale2;37;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;967.696,-1288.545;Inherit;False;Property;_Color1;Color1;3;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;-143.9841,237.8811;Inherit;False;Property;_Metallic2;Metallic2;29;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-1053.538,-2160.5;Inherit;True;Property;_AlphaMask;AlphaMask;18;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;69;666.4666,919.226;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-504.3232,593.9952;Inherit;False;Property;_DetailGlossScale1;DetailGlossScale1;45;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-140.3932,468.9678;Inherit;False;Property;_Glossiness;Glossiness;42;0;Create;True;0;0;True;0;0.2;0.321;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;1863.791,-440.636;Inherit;False;Property;_CarvatureStrength;CarvatureStrength;26;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;72;-1027.216,-95.0914;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;36;-220.1248,-1162.648;Inherit;False;Property;_DetailUV2;DetailUV2;46;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;24;44.67894,-1230.011;Inherit;True;Property;_WeatheringMap;WeatheringMap;16;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-480.3586,-616.3608;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;21;-1025.582,-1136.721;Inherit;True;Property;_DetailMask;DetailMask;13;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;30;966.0936,-1084.565;Inherit;False;Property;_Color1_2;Color1_2;2;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;38;1245.718,-1522.207;Inherit;False;Property;_UVScalePattern;UVScalePattern;51;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;33;1511.875,-1282.157;Inherit;False;Property;_Color3;Color3;5;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;39;1581.33,-1526.8;Inherit;False;Property;_patternuv1;patternuv1;47;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;57;1293.178,-637.5657;Inherit;False;Property;_DetailUV2Rotator;DetailUV2Rotator;24;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-141.9841,41.8811;Inherit;False;Property;_Metallic4;Metallic4;31;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;1226.875,-1285.157;Inherit;False;Property;_Color2;Color2;4;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;1861.973,-528.9818;Inherit;False;Property;_AlphaEx;AlphaEx;25;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-150.4027,554.3181;Inherit;False;Property;_Glossiness2;Glossiness2;44;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;62;-137.9841,135.8811;Inherit;False;Property;_Metallic3;Metallic3;30;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1141.342,180.9524;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;hooh/ClotheReplicaAlpha;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;5;44;0
WireConnection;9;5;51;0
WireConnection;73;5;52;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;25;1;35;0
WireConnection;69;0;67;0
WireConnection;69;1;23;0
WireConnection;69;2;70;0
WireConnection;72;0;10;0
WireConnection;72;1;73;0
WireConnection;24;1;36;0
WireConnection;8;0;1;0
WireConnection;8;1;5;0
WireConnection;0;0;8;0
WireConnection;0;1;72;0
WireConnection;0;3;12;0
WireConnection;0;4;11;0
WireConnection;0;5;69;0
WireConnection;0;9;1;4
WireConnection;0;10;74;0
ASEEND*/
//CHKSM=28E09A88E27F5869D38A23C9360FA18B3D2697C7