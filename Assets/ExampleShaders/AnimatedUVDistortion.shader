// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/AnimatedUVDistort"
{
	Properties
	{
		_MainTexture("Main Texture", 2D) = "white" {}
		_DistortTexture("Distort Texture", 2D) = "bump" {}
		[HDR]_TintColor("Tint Color", Color) = (1,0.4196078,0,1)
		_Speed("Speed", Float) = 0
		_UVDistortIntensity("UV Distort Intensity", Range( 0 , 0.04)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityStandardUtils.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float4 _TintColor;
		uniform sampler2D _MainTexture;
		uniform float _Speed;
		uniform float _UVDistortIntensity;
		uniform sampler2D _DistortTexture;
		uniform float4 _DistortTexture_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime10 = _Time.y * _Speed;
			float2 panner11 = ( float2( 0,0 ) + mulTime10 * float2( -1,-1 ));
			float2 uv_TexCoord9 = i.uv_texcoord * float2( 1,1 ) + panner11;
			float2 uv_DistortTexture = i.uv_texcoord * _DistortTexture_ST.xy + _DistortTexture_ST.zw;
			float3 tex2DNode6 = UnpackScaleNormal( tex2D( _DistortTexture, uv_DistortTexture ) ,_UVDistortIntensity );
			float mulTime15 = _Time.y * _Speed;
			float2 panner17 = ( float2( 0,0 ) + mulTime15 * float2( 1,0.5 ));
			float2 uv_TexCoord18 = i.uv_texcoord * float2( 1,1 ) + panner17;
			float4 temp_output_20_0 = ( _TintColor * ( tex2D( _MainTexture, ( float3( uv_TexCoord9 ,  0.0 ) + tex2DNode6 ).xy ) * tex2D( _MainTexture, ( float3( uv_TexCoord18 ,  0.0 ) + tex2DNode6 ).xy ) ) );
			o.Albedo = temp_output_20_0.rgb;
			o.Emission = temp_output_20_0.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14004
256;92;954;673;1641.768;643.5834;2.138303;True;False
Node;AmplifyShaderEditor.RangedFloatNode;23;-2400.123,58.86468;Float;False;Property;_Speed;Speed;3;0;Create;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;15;-1722.107,490.1429;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-1643.784,-111.7641;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;11;-1449.904,-251.4571;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-1,-1;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;17;-1493.972,362.5278;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0.5;False;1;FLOAT;1.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-1916.708,106.293;Float;False;Property;_UVDistortIntensity;UV Distort Intensity;4;0;Create;0;0;0.04;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1225.597,-252.8895;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;18;-1272.574,354.2421;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-1558.098,90.11827;Float;True;Property;_DistortTexture;Distort Texture;1;0;Create;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-978.4656,-159.0065;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1013.526,448.6211;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1;-856.8282,-182.0895;Float;True;Property;_MainTexture;Main Texture;0;0;Create;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-850.0068,1.76078;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;7;-851.9389,-413.8653;Float;False;Property;_TintColor;Tint Color;2;1;[HDR];Create;1,0.4196078,0,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-530.4052,-105.6451;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-301.6053,-187.0681;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;267.9615,-227.9616;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/AnimatedUVDistort;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;23;0
WireConnection;10;0;23;0
WireConnection;11;1;10;0
WireConnection;17;1;15;0
WireConnection;9;1;11;0
WireConnection;18;1;17;0
WireConnection;6;5;13;0
WireConnection;12;0;9;0
WireConnection;12;1;6;0
WireConnection;19;0;18;0
WireConnection;19;1;6;0
WireConnection;1;1;12;0
WireConnection;14;1;19;0
WireConnection;8;0;1;0
WireConnection;8;1;14;0
WireConnection;20;0;7;0
WireConnection;20;1;8;0
WireConnection;0;0;20;0
WireConnection;0;2;20;0
ASEEND*/
//CHKSM=54B0A3DA592A093B205898AFCC5DF2B002781784
