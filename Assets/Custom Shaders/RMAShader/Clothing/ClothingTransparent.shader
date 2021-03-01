// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/Clothing/RMA/Transparent"
{
	Properties
	{
		_BaseColor("BaseColor (Not Adjustable in Game)", Color) = (0.7075472,0.7075472,0.7075472,1)
		_MainTex("MainTex", 2D) = "white" {}
		_ExGloss("ExGloss - Controlled By Game", Range( 0 , 1)) = 0
		[HideInInspector]_DetailMainTex("Gloss Render Texture", 2D) = "black" {}
		_BumpMap("Normal Map", 2D) = "bump" {}
		_DetailNormalMap("First Detail Normal Map", 2D) = "bump" {}
		_DetailNormalMap2("Second Detail Normal Map", 2D) = "bump" {}
		_BumpMapMask("Normal Map Mask (R:Main,G:Detail1,B:Detail2) - def:white", 2D) = "white" {}
		_MetallicGlossMap("PackedMap (Gloss,Metal,AO)", 2D) = "gray" {}
		_DetailNormalIntensity("Detail 1 Intensity ", Range( 0 , 3)) = 1
		_DetailNormalIntensity2("Detail 2 Intensity ", Range( 0 , 1)) = 0.2
		_OcclusionStrength("Occlusion Strength", Range( 0 , 1)) = 1
		_BumpScale("Normal Map Scale", Range( 0 , 2)) = 1
		[Enum(Back,0,Front,1,All,2)]_CullMode("CullMode", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull [_CullMode]
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform int _CullMode;
		uniform float _BumpScale;
		uniform sampler2D _BumpMapMask;
		uniform float4 _BumpMapMask_ST;
		uniform sampler2D _BumpMap;
		uniform float4 _BumpMap_ST;
		uniform float _DetailNormalIntensity;
		uniform sampler2D _DetailNormalMap;
		uniform float4 _DetailNormalMap_ST;
		uniform float _DetailNormalIntensity2;
		uniform sampler2D _DetailNormalMap2;
		uniform float4 _DetailNormalMap2_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _BaseColor;
		uniform sampler2D _DetailMainTex;
		uniform float4 _DetailMainTex_ST;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform float _ExGloss;
		uniform float _OcclusionStrength;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMapMask = i.uv_texcoord * _BumpMapMask_ST.xy + _BumpMapMask_ST.zw;
			float4 tex2DNode2_g58 = tex2D( _BumpMapMask, uv_BumpMapMask );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			float2 uv_DetailNormalMap2 = i.uv_texcoord * _DetailNormalMap2_ST.xy + _DetailNormalMap2_ST.zw;
			o.Normal = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), ( _BumpScale * tex2DNode2_g58.r ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), ( _DetailNormalIntensity * tex2DNode2_g58.g ) ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap2, uv_DetailNormalMap2 ), ( _DetailNormalIntensity2 * tex2DNode2_g58.b ) ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1_g57 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( tex2DNode1_g57 * _BaseColor ).rgb;
			float2 uv_DetailMainTex = i.uv_texcoord * _DetailMainTex_ST.xy + _DetailMainTex_ST.zw;
			float4 tex2DNode1_g60 = tex2D( _DetailMainTex, uv_DetailMainTex );
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1_g56 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			o.Metallic = saturate( ( tex2DNode1_g60.r + tex2DNode1_g56.g ) );
			o.Smoothness = saturate( ( tex2DNode1_g56.r + tex2DNode1_g60.b + _ExGloss ) );
			float lerpResult7_g56 = lerp( 0.0 , tex2DNode1_g56.b , _OcclusionStrength);
			o.Occlusion = lerpResult7_g56;
			o.Alpha = ( tex2DNode1_g57.a * _BaseColor.a );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows nolightmap  nodirlightmap 

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
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
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
2660;3744;1749;896;-373.8116;125.9299;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;149;798.7067,406.8613;Inherit;False;212;159;Amplify Shader Option Link;1;148;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;148;843.7067,465.8613;Inherit;False;Property;_CullMode;CullMode;25;1;[Enum];Create;False;3;Back;0;Front;1;All;2;0;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;164;758.8732,181.2507;Inherit;False;AIHSClothingShaderBase;0;;56;b5c925f1513c6904ea4c4fb3e2a43aa6;0;0;7;COLOR;17;FLOAT;18;FLOAT;25;FLOAT3;16;FLOAT;0;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;118;1587.45,144.1496;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;hooh/Clothing/RMA/Transparent;False;False;False;False;False;False;True;False;True;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;148;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;118;0;164;17
WireConnection;118;1;164;16
WireConnection;118;3;164;0
WireConnection;118;4;164;14
WireConnection;118;5;164;15
WireConnection;118;9;164;25
ASEEND*/
//CHKSM=7B15135B8B04E9F047767A1B7DC912922D9592B6