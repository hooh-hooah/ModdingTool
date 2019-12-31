// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Stencil Example/StencilMask02"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZWrite Off
		Stencil
		{
			Ref 2
			Comp Always
			Pass Replace
		}
		ColorMask 0
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			fixed filler;
		};

		void surf( Input input , inout SurfaceOutputStandard output )
		{
			output.Emission = float4(1,1,0,0).rgb;
			output.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=3001
393;92;1091;695;486;341.5;1;True;False
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;True;2;Float;ASEMaterialInspector;Standard;ASESampleShaders/Stencil Example/StencilMask02;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;False;False;False;False;True;2;255;255;7;3;0;0;False;0;4;10;25;True;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;OBJECT;0.0;OBJECT;0.0;OBJECT;0.0;OBJECT;0.0;FLOAT3;0,0,0
Node;AmplifyShaderEditor.ColorNode;1;-255,21.5;Float;Constant;_Color0;Color 0;-1;1,1,0,0
WireConnection;0;2;1;0
ASEEND*/
//CHKSM=F08639D94395B1A89D27D59A71D29484A458F24B
