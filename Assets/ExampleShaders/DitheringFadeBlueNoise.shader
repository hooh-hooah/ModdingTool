// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Dithering Fade Blue Noise"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.74
		_Albedo("Albedo", 2D) = "white" {}
		[NoScaleOffset]_Normal("Normal", 2D) = "bump" {}
		[NoScaleOffset]_Specular("Specular", 2D) = "white" {}
		[NoScaleOffset]_Occlusion("Occlusion", 2D) = "white" {}
		[NoScaleOffset]_BlueNoise("Blue Noise", 2D) = "white" {}
		_StartDitheringFade("Start Dithering Fade", Float) = 0
		_EndDitheringFade("End Dithering Fade", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			fixed2 uv_texcoord;
			fixed eyeDepth;
			fixed4 screenPosition;
		};

		uniform sampler2D _Normal;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Specular;
		uniform sampler2D _Occlusion;
		uniform fixed _StartDitheringFade;
		uniform fixed _EndDitheringFade;
		uniform sampler2D _BlueNoise;
		uniform float4 _BlueNoise_TexelSize;
		uniform float _Cutoff = 0.74;


		inline float DitherNoiseTex( float4 screenPos, sampler2D noiseTexture, float4 noiseTexelSize )
		{
			float dither = tex2Dlod( noiseTexture, float4( screenPos.xy * _ScreenParams.xy * noiseTexelSize.xy, 0, 0 ) ).g;
			float ditherRate = noiseTexelSize.x * noiseTexelSize.y;
			dither = ( 1 - ditherRate ) * dither + ditherRate;
			return dither;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.eyeDepth = -UnityObjectToViewPos( v.vertex.xyz ).z;
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Albedo ) );
			o.Albedo = tex2D( _Albedo, uv_Albedo ).rgb;
			o.Specular = tex2D( _Specular, uv_Albedo ).rgb;
			o.Occlusion = tex2D( _Occlusion, uv_Albedo ).r;
			o.Alpha = 1;
			float temp_output_65_0 = ( _StartDitheringFade + _ProjectionParams.y );
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float dither26 = DitherNoiseTex( ase_screenPosNorm, _BlueNoise, _BlueNoise_TexelSize);
			clip( ( ( ( i.eyeDepth + -temp_output_65_0 ) / ( _EndDitheringFade - temp_output_65_0 ) ) - dither26 ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15205
1927;-166;1066;709;103.1421;-95.306;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;36;-622.9761,91.39496;Float;False;1047.541;403.52;Scale depth from start to end;8;30;65;28;29;34;31;33;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;37;-609.7847,546.5101;Float;False;297.1897;243;Correction for near plane clipping;1;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ProjectionParams;19;-537.0848,595.81;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-584.0002,374.09;Float;False;Property;_StartDitheringFade;Start Dithering Fade;6;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;65;-298.5083,377.6221;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-117.5356,335.0947;Float;False;Property;_EndDitheringFade;End Dithering Fade;7;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SurfaceDepthNode;15;-557.4172,189.5072;Float;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;33;-107.1209,253.7414;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;28;101.9639,194.1952;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;29;99.26421,348.9946;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;47;-62.14664,-384.9758;Float;False;0;44;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;68;192,512;Float;True;Property;_BlueNoise;Blue Noise;5;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SamplerNode;44;384,-688;Float;True;Property;_Albedo;Albedo;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DitheringNode;26;464,512;Float;False;2;2;0;FLOAT;0;False;1;SAMPLER2D;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;34;285.764,250.6948;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;45;384,-496;Float;True;Property;_Normal;Normal;2;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;48;384,-112;Float;True;Property;_Occlusion;Occlusion;4;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;384,-304;Float;True;Property;_Specular;Specular;3;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;49;847.9045,48.44281;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;27;736,256;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;67;852.93,-28.48083;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;51;857.5114,-90.67801;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;52;867.2929,-172.9061;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;999.2003,-69.70003;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;0;StandardSpecular;ASESampleShaders/Dithering Fade Blue Noise;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;0;False;0;Masked;0.74;True;True;0;False;TransparentCutout;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;-1;False;-1;-1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;65;0;30;0
WireConnection;65;1;19;2
WireConnection;33;0;65;0
WireConnection;28;0;15;0
WireConnection;28;1;33;0
WireConnection;29;0;31;0
WireConnection;29;1;65;0
WireConnection;44;1;47;0
WireConnection;26;1;68;0
WireConnection;34;0;28;0
WireConnection;34;1;29;0
WireConnection;45;1;47;0
WireConnection;48;1;47;0
WireConnection;46;1;47;0
WireConnection;49;0;48;1
WireConnection;27;0;34;0
WireConnection;27;1;26;0
WireConnection;67;0;46;0
WireConnection;51;0;45;0
WireConnection;52;0;44;0
WireConnection;0;0;52;0
WireConnection;0;1;51;0
WireConnection;0;3;67;0
WireConnection;0;5;49;0
WireConnection;0;10;27;0
ASEEND*/
//CHKSM=FD086D3E36F12FB9752D54D95B116B8E0A8C26A4
