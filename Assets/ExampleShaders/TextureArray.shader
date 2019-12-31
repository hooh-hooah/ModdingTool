// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/TextureArray"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_TextureArrayAlbedo("Texture Array Albedo", 2DArray ) = "" {}
		_TextureArrayNormal("Texture Array Normal", 2DArray ) = "" {}
		_NormalScale("Normal Scale", Float) = 1
		_RoughScale("Rough Scale", Range( 0 , 1)) = 0.1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 3.5
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform UNITY_DECLARE_TEX2DARRAY( _TextureArrayNormal );
		uniform float4 _TextureArrayNormal_ST;
		uniform float _NormalScale;
		uniform UNITY_DECLARE_TEX2DARRAY( _TextureArrayAlbedo );
		uniform float4 _TextureArrayAlbedo_ST;
		uniform float _RoughScale;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_TextureArrayNormal = i.uv_texcoord * _TextureArrayNormal_ST.xy + _TextureArrayNormal_ST.zw;
			o.Normal = UnpackScaleNormal( UNITY_SAMPLE_TEX2DARRAY(_TextureArrayNormal, float3(uv_TextureArrayNormal, 0.0)  ) ,_NormalScale );
			float2 uv_TextureArrayAlbedo = i.uv_texcoord * _TextureArrayAlbedo_ST.xy + _TextureArrayAlbedo_ST.zw;
			o.Albedo = UNITY_SAMPLE_TEX2DARRAY(_TextureArrayAlbedo, float3(uv_TextureArrayAlbedo, 3.0)  ).xyz;
			o.Smoothness = ( UNITY_SAMPLE_TEX2DARRAY(_TextureArrayAlbedo, float3(uv_TextureArrayAlbedo, 0.0)  ).x * _RoughScale );
			o.Occlusion = UNITY_SAMPLE_TEX2DARRAY(_TextureArrayAlbedo, float3(uv_TextureArrayAlbedo, 1.0)  ).x;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=5106
351;364;1130;669;1124.783;702.0178;1.84876;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;407.6068,-183.0747;Float;False;True;3;Float;ASEMaterialInspector;StandardSpecular;ASESampleShaders/TextureArray;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0.0,0,0;False;13;OBJECT;0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
Node;AmplifyShaderEditor.TextureArrayNode;105;-310.502,63.60038;Float;True;Property;_TextureArray2;Texture Array 2;1;0;None;0;Instance;108;Auto;False;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;117;99.54906,25.52966;Float;False;0;FLOAT;0.0;False;1;FLOAT;0.0;False
Node;AmplifyShaderEditor.RangedFloatNode;113;-553.9034,-373.3005;Float;False;Constant;_AlbedoIndex;Albedo Index;1;0;3;0;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-544,320;Float;False;Constant;_OcclusionIndex;Occlusion Index;1;0;1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-560,-176;Float;False;Constant;_NormalIndex;Normal Index;1;0;0;0;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-560,-80;Float;False;Property;_NormalScale;Normal Scale;2;0;1;0;0
Node;AmplifyShaderEditor.TextureArrayNode;103;-304,-192;Float;True;Property;_TextureArrayNormal;Texture Array Normal;1;0;None;0;Object;-1;Auto;True;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False
Node;AmplifyShaderEditor.TextureArrayNode;108;-306.7961,-432.2489;Float;True;Property;_TextureArrayAlbedo;Texture Array Albedo;0;0;None;0;Object;-1;Auto;False;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False
Node;AmplifyShaderEditor.RangedFloatNode;118;-304,240;Float;False;Property;_RoughScale;Rough Scale;3;0;0.1;0;1
Node;AmplifyShaderEditor.TextureArrayNode;104;-320,320;Float;True;Property;_TextureArray3;Texture Array 3;1;0;None;0;Instance;108;Auto;False;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;1.0;False
Node;AmplifyShaderEditor.RangedFloatNode;109;-560,64;Float;False;Constant;_RoughnessIndex;Roughness Index;1;0;0;0;0
WireConnection;0;0;108;0
WireConnection;0;1;103;0
WireConnection;0;4;117;0
WireConnection;0;5;104;1
WireConnection;105;1;109;0
WireConnection;117;0;105;1
WireConnection;117;1;118;0
WireConnection;103;1;111;0
WireConnection;103;3;123;0
WireConnection;108;1;113;0
WireConnection;104;1;110;0
ASEEND*/
//CHKSM=2F4BD82319337791A38FEF962468BF4A3E96D093
