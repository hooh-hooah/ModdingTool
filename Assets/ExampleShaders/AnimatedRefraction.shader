// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Stencil Example/AnimatedRefraction"
{
	Properties
	{
		_PortalColor("PortalColor", Color) = (0.003838672,0.5220588,0.243292,0)
		_Distortion("Distortion", Range( 0 , 1)) = 0.292
		_BrushedMetalNormal("BrushedMetalNormal", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+100" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _GrabTexture;
		uniform sampler2D _BrushedMetalNormal;
		uniform float4 _BrushedMetalNormal_ST;
		uniform float _Distortion;
		uniform float4 _PortalColor;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPos39 = ase_screenPos;
			#if UNITY_UV_STARTS_AT_TOP
			float scale39 = -1.0;
			#else
			float scale39 = 1.0;
			#endif
			float halfPosW39 = ase_screenPos39.w * 0.5;
			ase_screenPos39.y = ( ase_screenPos39.y - halfPosW39 ) * _ProjectionParams.x* scale39 + halfPosW39;
			ase_screenPos39.xyzw /= ase_screenPos39.w;
			float4 normalizedClip21 = ase_screenPos39;
			float2 uv_BrushedMetalNormal = i.uv_texcoord * _BrushedMetalNormal_ST.xy + _BrushedMetalNormal_ST.zw;
			float cos33 = cos( _Time.y );
			float sin33 = sin( _Time.y );
			float2 rotator33 = mul( uv_BrushedMetalNormal - float2( 0.5,0.5 ) , float2x2( cos33 , -sin33 , sin33 , cos33 )) + float2( 0.5,0.5 );
			float4 screenColor8 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ( normalizedClip21 + float4( ( UnpackNormal( tex2D( _BrushedMetalNormal, rotator33 ) ) * _Distortion ) , 0.0 ) ) ) );
			o.Emission = ( screenColor8 * _PortalColor ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13803
566;511;900;507;252.9078;123.9781;1.324137;True;False
Node;AmplifyShaderEditor.Vector2Node;35;-1152,304;Float;False;Constant;_Vector0;Vector 0;-1;0;0.5,0.5;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;34;-1152,176;Float;False;0;29;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TimeNode;36;-1153.522,435.0121;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RotatorNode;33;-831.5794,259.398;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1.0;False;1;FLOAT2
Node;AmplifyShaderEditor.GrabScreenPosition;39;-521.3355,-27.96944;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;31;-544,400;Float;False;Property;_Distortion;Distortion;1;0;0.292;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;29;-542.58,195.399;Float;True;Property;_BrushedMetalNormal;BrushedMetalNormal;2;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-128.7738,261.0988;Float;False;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;21;-256,-16;Float;False;normalizedClip;-1;False;1;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;30;36.62508,137.2995;Float;False;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT3;0;False;1;FLOAT4
Node;AmplifyShaderEditor.ScreenColorNode;8;224.0004,85.8997;Float;False;Global;_ScreenGrab0;Screen Grab 0;-1;0;Object;-1;False;1;0;FLOAT4;0,0,0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;37;231.2177,270.9001;Float;False;Property;_PortalColor;PortalColor;0;0;0.003838672,0.5220588,0.243292,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;504.2176,117.4984;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;704.4994,-13;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Stencil Example/AnimatedRefraction;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;3;False;0;0;Transparent;0.5;True;True;100;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;33;0;34;0
WireConnection;33;1;35;0
WireConnection;33;2;36;2
WireConnection;29;1;33;0
WireConnection;32;0;29;0
WireConnection;32;1;31;0
WireConnection;21;0;39;0
WireConnection;30;0;21;0
WireConnection;30;1;32;0
WireConnection;8;0;30;0
WireConnection;38;0;8;0
WireConnection;38;1;37;0
WireConnection;0;2;38;0
ASEEND*/
//CHKSM=6D6C321FB02BE457256E5A07C6464863BCD261AD
