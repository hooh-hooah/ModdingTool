// Upgrade NOTE: upgraded instancing buffer 'ASESampleShadersSimpleGPUInstancing' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Simple/SimpleGPUInstancing"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Color("Color", Color) = (1,1,1,1)
		_Checkers("Checkers", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Checkers;
		uniform float4 _Checkers_ST;

		UNITY_INSTANCING_BUFFER_START(ASESampleShadersSimpleGPUInstancing)
			UNITY_DEFINE_INSTANCED_PROP(float4, _Color)
#define _Color_arr ASESampleShadersSimpleGPUInstancing
		UNITY_INSTANCING_BUFFER_END(ASESampleShadersSimpleGPUInstancing)

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Checkers = i.uv_texcoord * _Checkers_ST.xy + _Checkers_ST.zw;
			float4 _Color_Instance = UNITY_ACCESS_INSTANCED_PROP(_Color_arr, _Color);
			o.Albedo = ( tex2D( _Checkers, uv_Checkers ) * _Color_Instance ).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10011
412;100;931;639;773.5;230.5;1;True;False
Node;AmplifyShaderEditor.SamplerNode;1;-518.5,-163.5;Float;True;Property;_Checkers;Checkers;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;2;-464.5,65.5;Float;False;InstancedProperty;_Color;Color;0;0;1,1,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-153.5,-50.5;Float;False;2;2;0;FLOAT4;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;23,-97;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;ASESampleShaders/Simple/SimpleGPUInstancing;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0.0;False;7;FLOAT3;0.0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;0;0;3;0
ASEEND*/
//CHKSM=4077B481F57EDCA19D5FBA4BF134CDDBF1D3C323
