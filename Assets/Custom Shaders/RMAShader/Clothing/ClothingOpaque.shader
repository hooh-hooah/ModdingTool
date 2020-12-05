// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/Clothing/RMA/Opqaue"
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
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull [_CullMode]
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
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
			float4 tex2DNode2_g67 = tex2D( _BumpMapMask, uv_BumpMapMask );
			float2 uv_BumpMap = i.uv_texcoord * _BumpMap_ST.xy + _BumpMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			float2 uv_DetailNormalMap2 = i.uv_texcoord * _DetailNormalMap2_ST.xy + _DetailNormalMap2_ST.zw;
			o.Normal = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap ), ( _BumpScale * tex2DNode2_g67.r ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), ( _DetailNormalIntensity * tex2DNode2_g67.g ) ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap2, uv_DetailNormalMap2 ), ( _DetailNormalIntensity2 * tex2DNode2_g67.b ) ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode1_g70 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( tex2DNode1_g70 * _BaseColor ).rgb;
			float2 uv_DetailMainTex = i.uv_texcoord * _DetailMainTex_ST.xy + _DetailMainTex_ST.zw;
			float4 tex2DNode1_g69 = tex2D( _DetailMainTex, uv_DetailMainTex );
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode1_g66 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			o.Metallic = saturate( ( tex2DNode1_g69.r + tex2DNode1_g66.g ) );
			o.Smoothness = saturate( ( tex2DNode1_g66.r + tex2DNode1_g69.b + _ExGloss ) );
			float lerpResult7_g66 = lerp( 0.0 , tex2DNode1_g66.b , _OcclusionStrength);
			o.Occlusion = lerpResult7_g66;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
2660;3744;1749;896;153.1884;51.9299;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;149;117.7067,516.8613;Inherit;False;215;159;Amplify Shader Option Link;1;148;;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;166;166.8732,167.2507;Inherit;False;AIHSClothingShaderBase;0;;66;b5c925f1513c6904ea4c4fb3e2a43aa6;0;0;6;COLOR;17;FLOAT;18;FLOAT3;16;FLOAT;0;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.IntNode;148;162.7067,575.8613;Inherit;False;Property;_CullMode;CullMode;25;1;[Enum];Create;False;3;Back;0;Front;1;All;2;0;True;0;0;0;0;1;INT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;118;1164.45,181.1496;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;hooh/Clothing/RMA/Opqaue;False;False;False;False;False;False;True;False;True;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;True;148;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;118;0;166;17
WireConnection;118;1;166;16
WireConnection;118;3;166;0
WireConnection;118;4;166;14
WireConnection;118;5;166;15
ASEEND*/
//CHKSM=38A984C565812762D6A38E31EFB3E6A114089B3B