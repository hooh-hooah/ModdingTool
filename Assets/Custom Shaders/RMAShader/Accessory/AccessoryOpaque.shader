// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/Accessory/RMA/Opqaue"
{
	Properties
	{
		_Color("Color 1", Color) = (1,1,1,1)
		_Color2("Color 2", Color) = (1,1,1,1)
		_Color3("Color 3", Color) = (1,1,1,1)
		_Metallic2("Metallic 2", Range( 0 , 1)) = 0
		_Metallic("Metallic 1", Range( 0 , 1)) = 0
		_Metallic3("Metallic 3", Range( 0 , 1)) = 0
		_Glossiness("Glossiness", Range( 0 , 1)) = 0
		_Glossiness2("Glossiness 2", Range( 0 , 1)) = 0
		_Glossiness3("Glossiness 3", Range( 0 , 1)) = 0
		_BumpMap("Normal Map", 2D) = "bump" {}
		_DetailNormalMap("First Detail Normal Map", 2D) = "bump" {}
		_DetailNormalMap2("Second Detail Normal Map", 2D) = "bump" {}
		_BumpMapMask("Normal Map Mask (R:Main,G:Detail1,B:Detail2) - def:white", 2D) = "white" {}
		_MetallicGlossMap("PackedMap (Gloss,Metal,AO)", 2D) = "gray" {}
		_DetailNormalIntensity("Detail 1 Intensity ", Range( 0 , 3)) = 0
		_ColorMask("ColorMask", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_DetailNormalIntensity2("Detail 2 Intensity ", Range( 0 , 1)) = 0
		_OcclusionStrength("Occlusion Strength", Range( 0 , 1)) = 1
		_BumpScale("Normal Map Scale", Range( 0 , 2)) = 1
		[Toggle(_ISROUGHNESS1_ON)] _IsRoughness1("IsRoughness", Float) = 0
		[Enum(Back,0,Front,1,All,2)]_CullMode("CullMode", Int) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma shader_feature _ISROUGHNESS1_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows nolightmap  nodirlightmap 
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
		uniform float4 _Color;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform float _Metallic;
		uniform float _Metallic2;
		uniform float _Metallic3;
		uniform float _Glossiness;
		uniform float _Glossiness2;
		uniform float _Glossiness3;
		uniform float _OcclusionStrength;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMapMask = i.uv_texcoord * _BumpMapMask_ST.xy + _BumpMapMask_ST.zw;
			float4 tex2DNode2_g183 = tex2D( _BumpMapMask, uv_BumpMapMask );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			float2 uv_DetailNormalMap2 = i.uv_texcoord * _DetailNormalMap2_ST.xy + _DetailNormalMap2_ST.zw;
			o.Normal = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), ( _BumpScale * tex2DNode2_g183.r ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), ( _DetailNormalIntensity * tex2DNode2_g183.g ) ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap2, uv_DetailNormalMap2 ), ( _DetailNormalIntensity2 * tex2DNode2_g183.b ) ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode30_g180 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 tex2DNode31_g180 = tex2D( _ColorMask, uv_ColorMask );
			float4 break17_g182 = tex2DNode31_g180;
			float4 lerpResult29_g182 = lerp( float4( 1,1,1,1 ) , _Color , break17_g182.x);
			float4 lerpResult30_g182 = lerp( float4( 1,1,1,1 ) , _Color2 , break17_g182.y);
			float4 lerpResult31_g182 = lerp( float4( 1,1,1,1 ) , _Color3 , break17_g182.z);
			o.Albedo = saturate( ( tex2DNode30_g180 * lerpResult29_g182 * lerpResult30_g182 * lerpResult31_g182 ) ).xyz;
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1_g180 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			float4 break22_g185 = tex2DNode31_g180;
			o.Metallic = saturate( ( tex2DNode1_g180.g + saturate( ( ( break22_g185.x * _Metallic ) + ( break22_g185.y * _Metallic2 ) + ( break22_g185.z * _Metallic3 ) ) ) ) );
			#ifdef _ISROUGHNESS1_ON
				float staticSwitch52_g180 = ( 1.0 - tex2DNode1_g180.r );
			#else
				float staticSwitch52_g180 = tex2DNode1_g180.r;
			#endif
			float4 break22_g186 = tex2DNode31_g180;
			o.Smoothness = saturate( ( staticSwitch52_g180 + saturate( ( ( break22_g186.x * _Glossiness ) + ( break22_g186.y * _Glossiness2 ) + ( break22_g186.z * _Glossiness3 ) ) ) ) );
			float lerpResult7_g180 = lerp( 0.0 , tex2DNode1_g180.b , _OcclusionStrength);
			o.Occlusion = lerpResult7_g180;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
2660;3744;1749;896;402.1884;51.9299;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;149;798.7067,406.8613;Inherit;False;212;159;Amplify Shader Option Link;1;148;;1,1,1,1;0;0
Node;AmplifyShaderEditor.IntNode;148;843.7067,465.8613;Inherit;False;Property;_CullMode;CullMode;29;1;[Enum];Create;False;3;Back;0;Front;1;All;2;0;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode;182;627.8116,177.0701;Inherit;True;AIHSAccessoryShaderBase;0;;180;39d7d6c94fc081c4a8d375108ba4a6e6;0;0;6;FLOAT4;17;FLOAT;25;FLOAT3;16;FLOAT;0;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;118;1164.45,181.1496;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;hooh/Accessory/RMA/Opqaue;False;False;False;False;False;False;True;False;True;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;148;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;118;0;182;17
WireConnection;118;1;182;16
WireConnection;118;3;182;0
WireConnection;118;4;182;14
WireConnection;118;5;182;15
ASEEND*/
//CHKSM=F565875E1D29ED555E79DDCDAE52BBDC5169F855