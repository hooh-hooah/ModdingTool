// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Terrain/SimpleTerrainAddPass"
{
	Properties
	{
		[HideInInspector]_Control("Control", 2D) = "white" {}
		[HideInInspector]_Splat3("Splat3", 2D) = "white" {}
		[HideInInspector]_Splat2("Splat2", 2D) = "white" {}
		[HideInInspector]_Splat1("Splat1", 2D) = "white" {}
		[HideInInspector]_Splat0("Splat0", 2D) = "white" {}
		[HideInInspector]_Normal0("Normal0", 2D) = "white" {}
		[HideInInspector]_Normal1("Normal1", 2D) = "white" {}
		[HideInInspector]_Normal2("Normal2", 2D) = "white" {}
		[HideInInspector]_Normal3("Normal3", 2D) = "white" {}
		[HideInInspector]_Smoothness3("Smoothness3", Range( 0 , 1)) = 1
		[HideInInspector]_Smoothness1("Smoothness1", Range( 0 , 1)) = 1
		[HideInInspector]_Smoothness0("Smoothness0", Range( 0 , 1)) = 1
		[HideInInspector]_Smoothness2("Smoothness2", Range( 0 , 1)) = 1
		_Wetness("Wetness", Float) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-99" "IgnoreProjector"="True" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_fog
		#define TERRAIN_SPLAT_ADDPASS
		#define TERRAIN_STANDARD_SHADER
		#pragma exclude_renderers gles 
		#pragma surface surf Standard keepalpha vertex:vertexDataFunc  decal:add finalcolor:SplatmapFinalColor
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _Control;
		uniform float4 _Control_ST;
		uniform sampler2D _Normal0;
		uniform sampler2D _Splat0;
		uniform float4 _Splat0_ST;
		uniform sampler2D _Normal1;
		uniform sampler2D _Splat1;
		uniform float4 _Splat1_ST;
		uniform sampler2D _Normal2;
		uniform sampler2D _Splat2;
		uniform float4 _Splat2_ST;
		uniform sampler2D _Normal3;
		uniform sampler2D _Splat3;
		uniform float4 _Splat3_ST;
		uniform float _Smoothness0;
		uniform float _Smoothness1;
		uniform float _Smoothness2;
		uniform float _Smoothness3;
		uniform float _Metallic;
		uniform float _Wetness;


		void SplatmapFinalColor( Input SurfaceIn , SurfaceOutputStandard SurfaceOut , inout fixed4 FinalColor )
		{
			FinalColor *= SurfaceOut.Alpha;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float localCalculateTangents16_g11 = ( 0.0 );
			v.tangent.xyz = cross ( v.normal, float3( 0, 0, 1 ) );
			v.tangent.w = -1;
			float3 temp_cast_0 = (localCalculateTangents16_g11).xxx;
			v.vertex.xyz += temp_cast_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Control = i.uv_texcoord * _Control_ST.xy + _Control_ST.zw;
			float4 tex2DNode5_g11 = tex2D( _Control, uv_Control );
			float dotResult20_g11 = dot( tex2DNode5_g11 , float4(1,1,1,1) );
			float SplatWeight22_g11 = dotResult20_g11;
			float localSplatClip74_g11 = ( SplatWeight22_g11 );
			float SplatWeight74_g11 = SplatWeight22_g11;
			#if !defined(SHADER_API_MOBILE) && defined(TERRAIN_SPLAT_ADDPASS)
				clip(SplatWeight74_g11 == 0.0f ? -1 : 1);
			#endif
			float4 SplatControl26_g11 = ( tex2DNode5_g11 / ( localSplatClip74_g11 + 0.001 ) );
			float4 temp_output_59_0_g11 = SplatControl26_g11;
			float2 uv_Splat0 = i.uv_texcoord * _Splat0_ST.xy + _Splat0_ST.zw;
			float2 uv_Splat1 = i.uv_texcoord * _Splat1_ST.xy + _Splat1_ST.zw;
			float2 uv_Splat2 = i.uv_texcoord * _Splat2_ST.xy + _Splat2_ST.zw;
			float2 uv_Splat3 = i.uv_texcoord * _Splat3_ST.xy + _Splat3_ST.zw;
			float4 weightedBlendVar8_g11 = temp_output_59_0_g11;
			float4 weightedBlend8_g11 = ( weightedBlendVar8_g11.x*tex2D( _Normal0, uv_Splat0 ) + weightedBlendVar8_g11.y*tex2D( _Normal1, uv_Splat1 ) + weightedBlendVar8_g11.z*tex2D( _Normal2, uv_Splat2 ) + weightedBlendVar8_g11.w*tex2D( _Normal3, uv_Splat3 ) );
			o.Normal = UnpackNormal( weightedBlend8_g11 );
			float4 appendResult33_g11 = (float4(1.0 , 1.0 , 1.0 , _Smoothness0));
			float4 appendResult36_g11 = (float4(1.0 , 1.0 , 1.0 , _Smoothness1));
			float4 appendResult39_g11 = (float4(1.0 , 1.0 , 1.0 , _Smoothness2));
			float4 appendResult42_g11 = (float4(1.0 , 1.0 , 1.0 , _Smoothness3));
			float4 weightedBlendVar9_g11 = temp_output_59_0_g11;
			float4 weightedBlend9_g11 = ( weightedBlendVar9_g11.x*( appendResult33_g11 * tex2D( _Splat0, uv_Splat0 ) ) + weightedBlendVar9_g11.y*( appendResult36_g11 * tex2D( _Splat1, uv_Splat1 ) ) + weightedBlendVar9_g11.z*( appendResult39_g11 * tex2D( _Splat2, uv_Splat2 ) ) + weightedBlendVar9_g11.w*( appendResult42_g11 * tex2D( _Splat3, uv_Splat3 ) ) );
			float4 MixDiffuse28_g11 = weightedBlend9_g11;
			o.Albedo = MixDiffuse28_g11.xyz;
			o.Metallic = _Metallic;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			o.Smoothness = saturate( pow( ( 1.0 - ase_vertex3Pos.y ) , _Wetness ) );
			o.Alpha = SplatWeight22_g11;
		}

		ENDCG
	}
	Fallback "Hidden/TerrainEngine/Splatmap/Diffuse-AddPass"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15312
263;100;754;590;540.0595;267.8899;1.3;True;True
Node;AmplifyShaderEditor.PosVertexDataNode;37;-423.6948,402.6638;Float;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;36;-126.6948,411.1436;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-105.9117,557.5325;Float;False;Property;_Wetness;Wetness;19;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;38;114.0559,459.6325;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;50;-344.3317,49.79149;Float;False;Four Splats First Pass Terrain;1;;11;37452fdfb732e1443b7e39720d05b708;0;6;59;FLOAT4;0,0,0,0;False;60;FLOAT4;0,0,0,0;False;61;FLOAT3;0,0,0;False;57;FLOAT;0;False;58;FLOAT;0;False;62;FLOAT;0;False;6;FLOAT4;0;FLOAT3;14;FLOAT;56;FLOAT;45;FLOAT;19;FLOAT;17
Node;AmplifyShaderEditor.RangedFloatNode;21;134.9534,153.83;Float;False;Property;_Metallic;Metallic;20;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;29;115.0688,271.207;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;46;-329.9529,-92.93633;Float;False;FinalColor *= SurfaceOut.Alpha@;7;False;3;True;SurfaceIn;OBJECT;0;In;Input;True;SurfaceOut;OBJECT;0;In;SurfaceOutputStandard;True;FinalColor;OBJECT;0;InOut;fixed4;SplatmapFinalColor;False;True;4;0;FLOAT;0;False;1;OBJECT;0;False;2;OBJECT;0;False;3;OBJECT;0;False;2;FLOAT;0;OBJECT;4
Node;AmplifyShaderEditor.SaturateNode;41;391.3052,383.6638;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;657.0565,40.11808;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Terrain/SimpleTerrainAddPass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;-99;True;Opaque;;Geometry;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Hidden/TerrainEngine/Splatmap/Diffuse-AddPass;0;-1;-1;-1;1;IgnoreProjector=True;False;0;0;False;-1;-1;0;False;-1;3;Pragma;multi_compile_fog;Define;TERRAIN_SPLAT_ADDPASS;Define;TERRAIN_STANDARD_SHADER;2;decal:add;finalcolor:SplatmapFinalColor;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;36;0;37;2
WireConnection;38;0;36;0
WireConnection;38;1;39;0
WireConnection;29;0;50;17
WireConnection;41;0;38;0
WireConnection;0;0;50;0
WireConnection;0;1;50;14
WireConnection;0;3;21;0
WireConnection;0;4;41;0
WireConnection;0;9;50;19
WireConnection;0;11;29;0
ASEEND*/
//CHKSM=5A9BB9811B8450FF67AF3F02E0C5F54FD10EA292
