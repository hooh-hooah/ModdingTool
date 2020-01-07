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
		_DetailMainTex("DetailMainTex", 2D) = "gray" {}
		_DetailMask("DetailMask", 2D) = "white" {}
		_MetalicGlossMap("MetalicGlossMap", 2D) = "black" {}
		_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_WeatheringMap("WeatheringMap", 2D) = "white" {}
		_WeatheringMask("WeatheringMask", 2D) = "white" {}
		_AlphaMask("AlphaMask", 2D) = "white" {}
		_AlphaMask2("AlphaMask2", 2D) = "white" {}
		_DetailGlossMap2("DetailGlossMap2", 2D) = "white" {}
		_CutoutMap("CutoutMap", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_BumpScale("BumpScale", Range( 0 , 3)) = 1
		_DetailNormalMapScale("DetailNormalMapScale", Range( 0 , 3)) = 1
		_DetailNormalMapScale2("DetailNormalMapScale2", Range( 0 , 1)) = 0.2
		_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
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

		uniform float4 _Color2;
		uniform sampler2D _WeatheringMap;
		uniform sampler2D _AlphaMask;
		uniform float4 _Emission;
		uniform sampler2D _AlphaMask2;
		uniform sampler2D _WeatheringMask;
		uniform sampler2D _MetalicGlossMap;
		uniform float4 _Color1_2;
		uniform float4 _Color2_2;
		uniform sampler2D _DetailMask;
		uniform sampler2D _DetailGlossMap2;
		uniform sampler2D _DetailGlossMap;
		uniform float4 _Color3_2;
		uniform float4 _Color3;
		uniform float4 _Color1;
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
		uniform sampler2D _DetailMainTex;
		uniform float4 _DetailMainTex_ST;
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
			float2 uv_DetailMainTex = i.uv_texcoord * _DetailMainTex_ST.xy + _DetailMainTex_ST.zw;
			float4 tex2DNode15 = tex2D( _DetailMainTex, uv_DetailMainTex );
			o.Metallic = tex2DNode15.r;
			o.Smoothness = tex2DNode15.b;
			float4 temp_cast_1 = 1;
			float2 uv_OcclusionMap = i.uv_texcoord * _OcclusionMap_ST.xy + _OcclusionMap_ST.zw;
			float4 lerpResult69 = lerp( temp_cast_1 , tex2D( _OcclusionMap, uv_OcclusionMap ) , _OcclusionStrength);
			o.Occlusion = lerpResult69.r;
			o.Alpha = ( tex2DNode1.a * _BaseColor.a );
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
-1913;-2184;1905;796;22.72879;-70.99868;1;True;True
Node;AmplifyShaderEditor.RangedFloatNode;44;-2086.255,-226.5799;Inherit;False;Property;_BumpScale;BumpScale;28;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-2073.312,13.14045;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;29;0;Create;True;0;0;False;0;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-894.7416,1655.13;Inherit;True;Property;_OcclusionMap;OcclusionMap;15;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1678.098,-36.97742;Inherit;True;Property;_DetailNormalMap;DetailNormalMap;1;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-585.9402,1805.375;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;34;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;67;-743.5947,1548.113;Inherit;False;Constant;_Int0;Int 0;50;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.ColorNode;5;-976.389,-535.9379;Inherit;False;Property;_BaseColor;BaseColor;9;0;Create;True;0;0;False;0;0.7075472,0.7075472,0.7075472,1;0.2924526,0.2924526,0.2924526,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1012.219,-754.2643;Inherit;True;Property;_MainTex;MainTex;22;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-1671.558,-271.8651;Inherit;True;Property;_BumpMap;BumpMap;10;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;-2022.888,231.0533;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;30;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;10;-1289.241,-104.5183;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;69;-177.5954,1569.113;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-495.2633,-470.8815;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;73;-1679.607,170.7798;Inherit;True;Property;_DetailNormalMap2;DetailNormalMap2;0;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;42;1780.077,-3311.584;Inherit;False;Property;_patternuvbase;patternuvbase;40;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;32;1436.622,-2475.94;Inherit;False;Property;_Color2_2;Color2_2;8;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;21;789.2504,-2470.832;Inherit;True;Property;_DetailMask;DetailMask;13;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;20;485.5143,-2677.69;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;20;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;49;-541.2062,227.7506;Inherit;False;Property;_DetailMetalicScale;DetailMetalicScale;32;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;1861.973,-528.9818;Inherit;False;Property;_AlphaEx;AlphaEx;25;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;1866.791,-346.636;Inherit;False;Property;_Cutoff;Cutoff;27;0;Create;True;0;0;False;0;0.2;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;30;1165.84,-2476.348;Inherit;False;Property;_Color1_2;Color1_2;2;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-389.8204,1096.677;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-546.3928,135.4199;Inherit;False;Property;_DetailMetalicScale2;DetailMetalicScale2;31;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;1167.443,-2680.329;Inherit;False;Property;_Color1;Color1;3;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;41;1782.077,-3179.583;Inherit;False;Property;_patternuv3;patternuv3;42;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;39;1781.077,-2918.583;Inherit;False;Property;_patternuv1;patternuv1;39;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;15;32.80762,188.9351;Inherit;True;Property;_DetailMainTex;DetailMainTex;12;0;Create;True;0;0;True;0;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;81;178.0797,554.0842;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;36;-1027.493,1243.731;Inherit;False;Property;_DetailUV2;DetailUV2;38;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;19;493.5143,-2469.69;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;11;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;34;1712.622,-2471.94;Inherit;False;Property;_Color3_2;Color3_2;6;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;1782.077,-3046.583;Inherit;False;Property;_patternuv2;patternuv2;41;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;33;1711.622,-2673.94;Inherit;False;Property;_Color3;Color3;5;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;2015.555,-2464.771;Inherit;False;Property;_Emission;Emission;7;0;Create;True;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;29;167.0124,-2686.68;Inherit;True;Property;_AlphaMask;AlphaMask;18;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;38;1967.465,-2916.99;Inherit;False;Property;_UVScalePattern;UVScalePattern;43;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;80;-64.34592,376.5418;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;28;792.7727,-2684.885;Inherit;True;Property;_AlphaMask2;AlphaMask2;19;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;31;1426.622,-2676.94;Inherit;False;Property;_Color2;Color2;4;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;74;-777.2038,721.7603;Inherit;True;Property;_CutoutMap;CutoutMap;21;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;72;-905.6556,-106.9077;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;24;-762.6906,1176.368;Inherit;True;Property;_WeatheringMap;WeatheringMap;16;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-480.3586,-616.3608;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-1618.122,533.7245;Inherit;False;Property;_DetailGlossScale1;DetailGlossScale1;37;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-1620.124,635.7786;Inherit;False;Property;_DetailGlossScale2;DetailGlossScale2;33;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;1297.178,-555.5657;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;23;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;1293.178,-637.5657;Inherit;False;Property;_DetailUV2Rotator;DetailUV2Rotator;24;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;45;1863.791,-440.636;Inherit;False;Property;_CarvatureStrength;CarvatureStrength;26;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-874.8415,1884.093;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;35;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-875.8415,1972.093;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;36;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;-766.4608,958.5021;Inherit;True;Property;_WeatheringMask;WeatheringMask;17;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;35;-1036.493,1036.222;Inherit;False;Property;_DetailUV;DetailUV;44;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;22;164.37,-2464.805;Inherit;True;Property;_MetalicGlossMap;MetalicGlossMap;14;0;Create;True;0;0;True;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1141.342,180.9524;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;hooh/ClotheReplicaAlpha;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;5;51;0
WireConnection;7;5;44;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;69;0;67;0
WireConnection;69;1;23;0
WireConnection;69;2;70;0
WireConnection;77;0;1;4
WireConnection;77;1;5;4
WireConnection;73;5;52;0
WireConnection;81;0;69;0
WireConnection;80;0;77;0
WireConnection;72;0;10;0
WireConnection;72;1;73;0
WireConnection;24;1;36;0
WireConnection;8;0;1;0
WireConnection;8;1;5;0
WireConnection;25;1;35;0
WireConnection;0;0;8;0
WireConnection;0;1;72;0
WireConnection;0;3;15;1
WireConnection;0;4;15;3
WireConnection;0;5;81;0
WireConnection;0;9;80;0
WireConnection;0;10;74;0
ASEEND*/
//CHKSM=41448C93F566A8BD91976FA2A7BF9FC6325CE533