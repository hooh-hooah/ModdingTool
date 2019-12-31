// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Water/WaterSample"
{
	Properties
	{
		_WaterNormal("Water Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Float) = 0
		_DeepColor("Deep Color", Color) = (0,0,0,0)
		_ShalowColor("Shalow Color", Color) = (1,1,1,0)
		_WaterDepth("Water Depth", Float) = 0
		_WaterFalloff("Water Falloff", Float) = 0
		_WaterSpecular("Water Specular", Float) = 0
		_WaterSmoothness("Water Smoothness", Float) = 0
		_Distortion("Distortion", Float) = 0.5
		_Foam("Foam", 2D) = "white" {}
		_FoamDepth("Foam Depth", Float) = 0
		_FoamFalloff("Foam Falloff", Float) = 0
		_FoamSpecular("Foam Specular", Float) = 0
		_FoamSmoothness("Foam Smoothness", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#if defined(UNITY_STEREO_INSTANCING_ENABLED) || defined(UNITY_STEREO_MULTIVIEW_ENABLED)
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex);
		#else
		#define ASE_DECLARE_SCREENSPACE_TEXTURE(tex) UNITY_DECLARE_SCREENSPACE_TEXTURE(tex)
		#endif
		#pragma surface surf StandardSpecular keepalpha 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _WaterNormal;
		uniform float _NormalScale;
		uniform float4 _WaterNormal_ST;
		uniform float4 _DeepColor;
		uniform float4 _ShalowColor;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _WaterDepth;
		uniform float _WaterFalloff;
		uniform float _FoamDepth;
		uniform float _FoamFalloff;
		uniform sampler2D _Foam;
		uniform float4 _Foam_ST;
		ASE_DECLARE_SCREENSPACE_TEXTURE( _GrabTexture )
		uniform float _Distortion;
		uniform float _WaterSpecular;
		uniform float _FoamSpecular;
		uniform float _WaterSmoothness;
		uniform float _FoamSmoothness;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv0_WaterNormal = i.uv_texcoord * _WaterNormal_ST.xy + _WaterNormal_ST.zw;
			half2 panner22 = ( 1.0 * _Time.y * float2( -0.03,0 ) + uv0_WaterNormal);
			half2 panner19 = ( 1.0 * _Time.y * float2( 0.04,0.04 ) + uv0_WaterNormal);
			half3 temp_output_24_0 = BlendNormals( UnpackScaleNormal( tex2D( _WaterNormal, panner22 ), _NormalScale ) , UnpackScaleNormal( tex2D( _WaterNormal, panner19 ), _NormalScale ) );
			o.Normal = temp_output_24_0;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			half eyeDepth1 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			half temp_output_89_0 = abs( ( eyeDepth1 - ase_screenPos.w ) );
			half temp_output_94_0 = saturate( pow( ( temp_output_89_0 + _WaterDepth ) , _WaterFalloff ) );
			half4 lerpResult13 = lerp( _DeepColor , _ShalowColor , temp_output_94_0);
			float2 uv0_Foam = i.uv_texcoord * _Foam_ST.xy + _Foam_ST.zw;
			half2 panner116 = ( 1.0 * _Time.y * float2( -0.01,0.01 ) + uv0_Foam);
			half temp_output_114_0 = ( saturate( pow( ( temp_output_89_0 + _FoamDepth ) , _FoamFalloff ) ) * tex2D( _Foam, panner116 ).r );
			half4 lerpResult117 = lerp( lerpResult13 , float4(1,1,1,0) , temp_output_114_0);
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			half4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
			float4 screenColor65 = UNITY_SAMPLE_SCREENSPACE_TEXTURE(_GrabTexture,( half3( (ase_grabScreenPosNorm).xy ,  0.0 ) + ( temp_output_24_0 * _Distortion ) ).xy);
			half4 lerpResult93 = lerp( lerpResult117 , screenColor65 , temp_output_94_0);
			o.Albedo = lerpResult93.rgb;
			half lerpResult130 = lerp( _WaterSpecular , _FoamSpecular , temp_output_114_0);
			half3 temp_cast_3 = (lerpResult130).xxx;
			o.Specular = temp_cast_3;
			half lerpResult133 = lerp( _WaterSmoothness , _FoamSmoothness , temp_output_114_0);
			o.Smoothness = lerpResult133;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
-1519;-2112.857;1169;1010;2372.745;556.3604;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;152;-2053.601,-256.6997;Inherit;False;843.903;553.8391;Screen depth difference to get intersection and fading effect with terrain and objects;5;89;3;1;2;166;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ScreenPosInputsNode;166;-2010.745,-176.8604;Float;False;0;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;2;-1993.601,-9.1996;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;1;-1781.601,-155.6997;Inherit;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-1574.201,-110.3994;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;151;-935.9057,-1082.484;Inherit;False;1281.603;457.1994;Blend panning normals to fake noving ripples;7;19;23;24;21;22;17;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;89;-1389.004,-112.5834;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;21;-885.9058,-1005.185;Inherit;False;0;17;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;159;-863.7005,-467.5007;Inherit;False;1113.201;508.3005;Depths controls and colors;11;87;94;12;13;156;157;11;88;10;6;143;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;155;-1106.507,7.515848;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;153;-843.9032,402.718;Inherit;False;1083.102;484.2006;Foam controls and texture;9;116;105;106;115;111;110;112;113;114;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;158;-1075.608,-163.0834;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;48;-557.3063,-795.3858;Float;False;Property;_NormalScale;Normal Scale;1;0;Create;True;0;0;False;0;0;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;22;-613.2062,-1032.484;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.03,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;154;-922.7065,390.316;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;19;-610.9061,-919.9849;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.04,0.04;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-813.7005,-128.1996;Float;False;Property;_WaterDepth;Water Depth;4;0;Create;True;0;0;False;0;0;0.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;111;-722.2024,526.6185;Float;False;Property;_FoamDepth;Foam Depth;10;0;Create;True;0;0;False;0;0;0.94;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;-542.0016,452.718;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;106;-793.9032,700.119;Inherit;False;0;105;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;112;-531.4025,588.5187;Float;False;Property;_FoamFalloff;Foam Falloff;11;0;Create;True;0;0;False;0;0;-60;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-636.2005,-79.20019;Float;False;Property;_WaterFalloff;Water Falloff;5;0;Create;True;0;0;False;0;0;-3.6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;17;-256.3054,-814.2847;Inherit;True;Property;_WaterNormal;Water Normal;0;0;Create;True;0;0;False;0;-1;None;dd2fd2df93418444c8e280f1d34deeb5;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;88;-632.0056,-204.5827;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-269.2061,-1024.185;Inherit;True;Property;_Normal2;Normal2;0;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Instance;17;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;12;-697.5002,-417.5007;Float;False;Property;_DeepColor;Deep Color;2;0;Create;True;0;0;False;0;0,0,0,0;0,0.04310164,0.2499982,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;24;170.697,-879.6849;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PowerNode;87;-455.8059,-118.1832;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-455.0999,-328.3;Float;False;Property;_ShalowColor;Shalow Color;3;0;Create;True;0;0;False;0;1,1,1,0;0,0.8088232,0.8088235,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;150;467.1957,-1501.783;Inherit;False;985.6011;418.6005;Get screen color for refraction and disturbe it with normals;7;96;97;98;65;149;164;165;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;110;-357.2024,461.6185;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;116;-573.2014,720.3181;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;-0.01,0.01;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;97;710.096,-1203.183;Float;False;Property;_Distortion;Distortion;8;0;Create;True;0;0;False;0;0.5;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;105;-304.4021,674.9185;Inherit;True;Property;_Foam;Foam;9;0;Create;True;0;0;False;0;-1;None;d01457b88b1c5174ea4235d140b5fab8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GrabScreenPosition;164;511.3026,-1442.425;Inherit;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;94;-249.5044,-96.98394;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;113;-136.0011,509.618;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;156;-151.0076,-354.5834;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;157;-149.1077,-261.9834;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;149;487.4943,-1188.882;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;114;80.19891,604.0181;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;165;814.6503,-1385.291;Inherit;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.LerpOp;13;60.50008,-220.6998;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;108;58.99682,146.0182;Float;False;Constant;_Color0;Color 0;-1;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;888.1974,-1279.783;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;143;95.69542,-321.0839;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;1041.296,-1346.683;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;117;323.797,77.91843;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;104;753.9969,-565.4819;Float;False;Property;_WaterSpecular;Water Specular;6;0;Create;True;0;0;False;0;0;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;161;660.4934,-750.6837;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;26;920.1959,-279.1855;Float;False;Property;_WaterSmoothness;Water Smoothness;7;0;Create;True;0;0;False;0;0;0.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;131;756.1969,-467.1806;Float;False;Property;_FoamSpecular;Foam Specular;12;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;162;1312.293,-894.3823;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;65;1232.797,-1350.483;Float;False;Global;_WaterGrab;WaterGrab;-1;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;132;914.3978,-199.48;Float;False;Property;_FoamSmoothness;Foam Smoothness;13;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;93;1559.196,-1006.285;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;133;1139.597,-182.68;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;130;955.7971,-465.8806;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1838.601,-748.1998;Half;False;True;-1;2;ASEMaterialInspector;0;0;StandardSpecular;ASESampleShaders/Water/WaterSample;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;False;-1;0;False;-1;False;0;Translucent;0.5;True;False;0;False;Opaque;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1;0;166;0
WireConnection;3;0;1;0
WireConnection;3;1;2;4
WireConnection;89;0;3;0
WireConnection;155;0;89;0
WireConnection;158;0;89;0
WireConnection;22;0;21;0
WireConnection;154;0;155;0
WireConnection;19;0;21;0
WireConnection;115;0;154;0
WireConnection;115;1;111;0
WireConnection;17;1;19;0
WireConnection;17;5;48;0
WireConnection;88;0;158;0
WireConnection;88;1;6;0
WireConnection;23;1;22;0
WireConnection;23;5;48;0
WireConnection;24;0;23;0
WireConnection;24;1;17;0
WireConnection;87;0;88;0
WireConnection;87;1;10;0
WireConnection;110;0;115;0
WireConnection;110;1;112;0
WireConnection;116;0;106;0
WireConnection;105;1;116;0
WireConnection;94;0;87;0
WireConnection;113;0;110;0
WireConnection;156;0;12;0
WireConnection;157;0;11;0
WireConnection;149;0;24;0
WireConnection;114;0;113;0
WireConnection;114;1;105;1
WireConnection;165;0;164;0
WireConnection;13;0;156;0
WireConnection;13;1;157;0
WireConnection;13;2;94;0
WireConnection;98;0;149;0
WireConnection;98;1;97;0
WireConnection;143;0;94;0
WireConnection;96;0;165;0
WireConnection;96;1;98;0
WireConnection;117;0;13;0
WireConnection;117;1;108;0
WireConnection;117;2;114;0
WireConnection;161;0;117;0
WireConnection;162;0;143;0
WireConnection;65;0;96;0
WireConnection;93;0;161;0
WireConnection;93;1;65;0
WireConnection;93;2;162;0
WireConnection;133;0;26;0
WireConnection;133;1;132;0
WireConnection;133;2;114;0
WireConnection;130;0;104;0
WireConnection;130;1;131;0
WireConnection;130;2;114;0
WireConnection;0;0;93;0
WireConnection;0;1;24;0
WireConnection;0;3;130;0
WireConnection;0;4;133;0
ASEEND*/
//CHKSM=E1A470BC0A623AD0B089439BFA7DC9857EA73AF8