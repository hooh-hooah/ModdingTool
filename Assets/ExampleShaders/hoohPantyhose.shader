// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/PantyhoseSpecial"
{
	Properties
	{
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
		_MainTex("MainTex", 2D) = "white" {}
		_BumpScale("BumpScale", Range( 0 , 3)) = 1
		_Metallic2("Metallic2", Range( 0 , 1)) = 0.2
		_Metallic3("Metallic3", Range( 0 , 1)) = 0.2
		_Metallic4("Metallic4", Range( 0 , 1)) = 0.2
		_Metallic("Metallic", Range( 0 , 1)) = 0.2
		_DetailNormalMapScale("DetailNormalMapScale", Range( 0 , 3)) = 1
		_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
		_Glossiness4("Glossiness4", Range( 0 , 1)) = 0.2
		_Glossiness("Glossiness", Range( 0 , 1)) = 0.2
		_Glossiness3("Glossiness3", Range( 0 , 1)) = 0.2
		_Glossiness2("Glossiness2", Range( 0 , 1)) = 0.2
		_FresnelPower("FresnelPower", Range( 0 , 5)) = 2.050264
		_FresnelScale("FresnelScale", Range( 0 , 2)) = 1
		_FresnelBias("FresnelBias", Range( 0 , 2)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _DetailGlossMap;
		uniform sampler2D _WeatheringMap;
		uniform sampler2D _MetalicGlossMap;
		uniform float4 _Color3;
		uniform float4 _Color2_2;
		uniform float4 _Color1_2;
		uniform float4 _Color3_2;
		uniform sampler2D _DetailMainTex;
		uniform float _Glossiness3;
		uniform sampler2D _WeatheringMask;
		uniform float _Metallic3;
		uniform sampler2D _DetailGlossMap2;
		uniform sampler2D _DetailMask;
		uniform sampler2D _AlphaMask2;
		uniform float _Metallic2;
		uniform sampler2D _AlphaMask;
		uniform float4 _Emission;
		uniform float _Glossiness4;
		uniform float _Glossiness2;
		uniform float _Metallic4;
		uniform float4 _Color2;
		uniform float4 _Color1;
		uniform float _BumpScale;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _DetailNormalMapScale;
		uniform sampler2D _DetailNormalMap;
		uniform float4 _DetailNormalMap_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _BaseColor;
		uniform float _Metallic;
		uniform float _Glossiness;
		uniform sampler2D _OcclusionMap;
		uniform float4 _OcclusionMap_ST;
		uniform float _OcclusionStrength;
		uniform float _FresnelBias;
		uniform float _FresnelScale;
		uniform float _FresnelPower;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			o.Normal = BlendNormals( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), _BumpScale ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), _DetailNormalMapScale ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( tex2DNode1 * _BaseColor ).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			float4 temp_cast_1 = 1;
			float2 uv_OcclusionMap = i.uv_texcoord * _OcclusionMap_ST.xy + _OcclusionMap_ST.zw;
			float4 lerpResult69 = lerp( temp_cast_1 , tex2D( _OcclusionMap, uv_OcclusionMap ) , _OcclusionStrength);
			o.Occlusion = lerpResult69.r;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV75 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode75 = ( _FresnelBias + _FresnelScale * pow( 1.0 - fresnelNdotV75, _FresnelPower ) );
			o.Alpha = ( tex2DNode1.a + ( tex2DNode1.a * fresnelNode75 ) );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

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
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
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
-1913;-2211;1905;1004;1887.679;433.4819;1.109186;True;True
Node;AmplifyShaderEditor.RangedFloatNode;81;-624.297,-346.2964;Inherit;False;Property;_FresnelScale;FresnelScale;52;0;Create;True;0;0;False;0;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;82;-631.3126,-271.9512;Inherit;False;Property;_FresnelPower;FresnelPower;51;0;Create;True;0;0;False;0;2.050264;1;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;80;-639.8182,-431.2171;Inherit;False;Property;_FresnelBias;FresnelBias;53;0;Create;True;0;0;False;0;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1576.488,-184.0421;Inherit;False;Property;_BumpScale;BumpScale;26;0;Create;True;0;0;False;0;1;0.2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;75;-310.3832,-348.8605;Inherit;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-1046.423,-754.2643;Inherit;True;Property;_MainTex;MainTex;20;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;51;-1563.545,55.67804;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;31;0;Create;True;0;0;False;0;1;0.2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-50.6803,1005.243;Inherit;True;Property;_OcclusionMap;OcclusionMap;14;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;5;-976.389,-535.9379;Inherit;False;Property;_BaseColor;BaseColor;8;0;Create;True;0;0;False;0;0.7075472,0.7075472,0.7075472,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-1168.33,5.560172;Inherit;True;Property;_DetailNormalMap;DetailNormalMap;0;0;Create;True;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;258.1215,1155.488;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;36;0;Create;True;0;0;False;0;1;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;67;100.4666,898.226;Inherit;False;Constant;_Int0;Int 0;50;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;7;-1161.79,-229.3273;Inherit;True;Property;_BumpMap;BumpMap;9;0;Create;True;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;84;-26.34368,-289.2581;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;32;1236.875,-1084.157;Inherit;False;Property;_Color2_2;Color2_2;7;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;15;-1036.952,-1346.64;Inherit;True;Property;_DetailMainTex;DetailMainTex;11;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;52;-1572.545,298.678;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;32;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-140.3932,468.9678;Inherit;False;Property;_Glossiness;Glossiness;40;0;Create;True;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-31.78015,1322.206;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;38;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;38;1245.718,-1522.207;Inherit;False;Property;_UVScalePattern;UVScalePattern;49;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;42;1580.33,-1919.8;Inherit;False;Property;_patternuvbase;patternuvbase;46;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;49;-541.2062,227.7506;Inherit;False;Property;_DetailMetalicScale;DetailMetalicScale;34;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;-1053.538,-2160.5;Inherit;True;Property;_AlphaMask;AlphaMask;17;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;47;-504.3232,593.9952;Inherit;False;Property;_DetailGlossScale1;DetailGlossScale1;43;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;57;1293.178,-637.5657;Inherit;False;Property;_DetailUV2Rotator;DetailUV2Rotator;22;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;1582.33,-1787.8;Inherit;False;Property;_patternuv3;patternuv3;48;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;35;-229.1248,-1370.157;Inherit;False;Property;_DetailUV;DetailUV;50;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;30;966.0936,-1084.565;Inherit;False;Property;_Color1_2;Color1_2;1;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;59;-143.4027,640.3181;Inherit;False;Property;_Glossiness3;Glossiness3;41;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;60;-145.1027,730.4181;Inherit;False;Property;_Glossiness4;Glossiness4;39;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-140.7693,328.8997;Inherit;False;Property;_Metallic;Metallic;30;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-546.3928,135.4199;Inherit;False;Property;_DetailMetalicScale2;DetailMetalicScale2;33;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;33;1511.875,-1282.157;Inherit;False;Property;_Color3;Color3;4;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;37;1815.808,-1072.987;Inherit;False;Property;_Emission;Emission;6;0;Create;True;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;48;-506.3232,683.9952;Inherit;False;Property;_DetailGlossScale2;DetailGlossScale2;35;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;967.696,-1288.545;Inherit;False;Property;_Color1;Color1;2;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;1582.33,-1654.8;Inherit;False;Property;_patternuv2;patternuv2;47;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-356.201,-692.2275;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;36;-220.1248,-1162.648;Inherit;False;Property;_DetailUV2;DetailUV2;44;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;20;-1041.582,-1762.721;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;19;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;28;-1034.887,-1955.337;Inherit;True;Property;_AlphaMask2;AlphaMask2;18;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;22;-531.5721,352.4899;Inherit;True;Property;_MetalicGlossMap;MetalicGlossMap;13;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;58;-150.4027,554.3181;Inherit;False;Property;_Glossiness2;Glossiness2;42;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;1226.875,-1285.157;Inherit;False;Property;_Color2;Color2;3;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;1863.791,-440.636;Inherit;False;Property;_CarvatureStrength;CarvatureStrength;24;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;40.90875,-1447.877;Inherit;True;Property;_WeatheringMask;WeatheringMask;16;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;54;-30.78015,1234.206;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;37;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-1025.582,-1136.721;Inherit;True;Property;_DetailMask;DetailMask;12;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;62;-137.9841,135.8811;Inherit;False;Property;_Metallic3;Metallic3;28;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;69;666.4666,919.226;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;1866.791,-346.636;Inherit;False;Property;_Cutoff;Cutoff;25;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;39;1581.33,-1526.8;Inherit;False;Property;_patternuv1;patternuv1;45;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;24;44.67894,-1230.011;Inherit;True;Property;_WeatheringMap;WeatheringMap;15;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;19;-1033.582,-1554.721;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;10;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;34;1512.875,-1080.157;Inherit;False;Property;_Color3_2;Color3_2;5;0;Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;43;1861.973,-528.9818;Inherit;False;Property;_AlphaEx;AlphaEx;23;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;1297.178,-555.5657;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;21;0;Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-143.9841,237.8811;Inherit;False;Property;_Metallic2;Metallic2;27;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;10;-748.318,-85.60513;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-141.9841,41.8811;Inherit;False;Property;_Metallic4;Metallic4;29;0;Create;False;0;0;True;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;83;143.9629,-313.7464;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;957.342,-222.0476;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;hooh/PantyhoseSpecial;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;75;1;80;0
WireConnection;75;2;81;0
WireConnection;75;3;82;0
WireConnection;9;5;51;0
WireConnection;7;5;44;0
WireConnection;84;0;1;4
WireConnection;84;1;75;0
WireConnection;8;0;1;0
WireConnection;8;1;5;0
WireConnection;25;1;35;0
WireConnection;69;0;67;0
WireConnection;69;1;23;0
WireConnection;69;2;70;0
WireConnection;24;1;36;0
WireConnection;10;0;7;0
WireConnection;10;1;9;0
WireConnection;83;0;1;4
WireConnection;83;1;84;0
WireConnection;0;0;8;0
WireConnection;0;1;10;0
WireConnection;0;3;12;0
WireConnection;0;4;11;0
WireConnection;0;5;69;0
WireConnection;0;9;83;0
ASEEND*/
//CHKSM=2471FF235D31DA43DA00642CA975BF833D7BCF27