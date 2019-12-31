// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Community/TFHC/Low Poly Water"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_WaterColor("Water Color", Color) = (0.4926471,0.8740366,1,1)
		_WaveGuide("Wave Guide", 2D) = "white" {}
		_WaveSpeed("Wave Speed", Range( 0 , 5)) = 0
		_WaveHeight("Wave Height", Range( 0 , 5)) = 0
		_FoamColor("Foam Color", Color) = (1,1,1,0)
		_Foam("Foam", 2D) = "white" {}
		_FoamDistortion("Foam Distortion", 2D) = "white" {}
		_FoamDist("Foam Dist", Range( 0 , 1)) = 0.1
		_Opacity("Opacity", Range( 0 , 1)) = 0
		[Toggle]_LowPoly("Low Poly", Float) = 1
		_NormalOnlyNoPolyMode("Normal (Only No Poly Mode)", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float4 screenPos;
			float2 texcoord_0;
		};

		uniform float _LowPoly;
		uniform sampler2D _NormalOnlyNoPolyMode;
		uniform float4 _NormalOnlyNoPolyMode_ST;
		uniform float4 _WaterColor;
		uniform float4 _FoamColor;
		uniform sampler2D _Foam;
		uniform float _WaveSpeed;
		uniform float4 _Foam_ST;
		uniform sampler2D _FoamDistortion;
		uniform sampler2D _CameraDepthTexture;
		uniform float _FoamDist;
		uniform float _Opacity;
		uniform sampler2D _WaveGuide;
		uniform float _WaveHeight;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 speed = ( _Time * _WaveSpeed );
			float componentMask118 = v.vertex.xyz.y;
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + ( speed + componentMask118 ).xy;
			float3 VertexAnimation = ( ( tex2Dlod( _WaveGuide, float4( o.texcoord_0, 0.0 , 0.0 ) ).r - 0.5 ) * ( v.normal * _WaveHeight ) );
			v.vertex.xyz += VertexAnimation;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalOnlyNoPolyMode = i.uv_texcoord * _NormalOnlyNoPolyMode_ST.xy + _NormalOnlyNoPolyMode_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 Normal = lerp(UnpackNormal( tex2D( _NormalOnlyNoPolyMode, uv_NormalOnlyNoPolyMode ) ),normalize( ( cross( ddx( ase_worldPos ) , ddy( ase_worldPos ) ) + float3( 1E-09,0,0 ) ) ),_LowPoly);
			o.Normal = Normal;
			float4 Albedo = _WaterColor;
			o.Albedo = Albedo.rgb;
			float4 speed = ( _Time * _WaveSpeed );
			float2 uv_Foam = i.uv_texcoord * _Foam_ST.xy + _Foam_ST.zw;
			float cos182 = cos( speed );
			float sin182 = sin( speed );
			float2 rotator182 = mul((abs( uv_Foam+speed.x * float2(0.5,0.5 ))) - float2( 0,0 ), float2x2(cos182,-sin182,sin182,cos182)) + float2( 0,0 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float screenDepth164 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth164 = abs( ( screenDepth164 - LinearEyeDepth( ase_screenPos.z/ ase_screenPos.w ) ) / _FoamDist );
			float4 Emission = lerp( ( _FoamColor * tex2D( _Foam, rotator182 ) ) , float4(0,0,0,0) , clamp( ( clamp( tex2D( _FoamDistortion, rotator182 ).r , 0.0 , 1.0 ) * distanceDepth164 ) , 0.0 , 1.0 ) );
			o.Emission = Emission.rgb;
			o.Alpha = _Opacity;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10011
646;227;1066;638;4840.811;1685.321;4.844291;True;False
Node;AmplifyShaderEditor.CommentaryNode;199;-2827.374,-925.0059;Float;False;914.394;362.5317;Comment;4;89;15;88;183;Wave Speed;0;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-2777.374,-677.473;Float;False;Property;_WaveSpeed;Wave Speed;2;0;0;0;5;0;1;FLOAT
Node;AmplifyShaderEditor.TimeNode;89;-2706.477,-875.0057;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-2377.44,-739.9845;Float;False;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.CommentaryNode;192;-2804.44,147.8661;Float;False;2009.663;867.9782;Comment;16;176;177;182;179;181;161;174;169;191;159;170;157;162;164;167;184;Emission;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-2755.296,577.5368;Float;False;183;0;1;FLOAT4
Node;AmplifyShaderEditor.TextureCoordinatesNode;176;-2786.44,327.7948;Float;False;0;169;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;197;-2751.606,-436.2369;Float;False;2321.461;426.9865;Comment;12;53;118;47;96;86;43;54;44;36;29;127;195;Vertex Animation;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;183;-2155.98,-832.3298;Float;False;speed;-1;True;1;0;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.PannerNode;177;-2454.748,382.3567;Float;False;0.5;0.5;2;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.PosVertexDataNode;53;-2701.606,-286.774;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;204;-1883.495,-920.8318;Float;False;1244.412;443.4576;Comment;9;119;121;120;122;202;123;200;124;205;Normal;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;195;-2377.985,-347.0552;Float;False;183;0;1;FLOAT4
Node;AmplifyShaderEditor.RotatorNode;182;-2377.307,563.6425;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;0.5;False;1;FLOAT2
Node;AmplifyShaderEditor.ComponentMaskNode;118;-2462.842,-267.5019;Float;False;False;True;False;True;1;0;FLOAT3;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;119;-1872,-656;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;167;-2382.478,814.4856;Float;False;Property;_FoamDist;Foam Dist;7;0;0.1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-2177.163,-350.3377;Float;False;2;2;0;FLOAT4;0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;179;-2143.537,609.8837;Float;True;Property;_FoamDistortion;Foam Distortion;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DdxOpNode;120;-1664,-672;Float;False;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.DdyOpNode;121;-1664,-576;Float;False;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.DepthFade;164;-2020.088,829.655;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;181;-1851.366,695.3312;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.CrossProductOpNode;122;-1536,-640;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.TextureCoordinatesNode;96;-1988.552,-386.2369;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;169;-1928.3,373.9261;Float;True;Property;_Foam;Foam;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;43;-1398.183,-124.2504;Float;False;Property;_WaveHeight;Wave Height;3;0;0;0;5;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;161;-1881.812,197.8662;Float;False;Property;_FoamColor;Foam Color;4;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;86;-1709.089,-380.2153;Float;True;Property;_WaveGuide;Wave Guide;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;205;-1367.996,-605.7512;Float;False;2;2;0;FLOAT3;0.0;False;1;FLOAT3;1E-09,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;174;-1683.11,819.9097;Float;False;2;2;0;FLOAT;0.075;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.NormalVertexDataNode;54;-1353.867,-280.0608;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;36;-1021.508,-352.6445;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;159;-1656.591,619.5612;Float;False;Constant;_Color0;Color 0;9;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;203;-2809.492,-1303.385;Float;False;566.4452;257;Comment;2;2;131;Albedo;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-1513.108,437.6683;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;202;-1509.38,-870.8318;Float;True;Property;_NormalOnlyNoPolyMode;Normal (Only No Poly Mode);10;0;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.NormalizeNode;123;-1232,-576;Float;False;1;0;FLOAT3;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.ClampOpNode;191;-1486.683,783.1451;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1026.813,-198.9792;Float;False;2;2;0;FLOAT3;1.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;157;-1218.507,670.1462;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.ToggleSwitchNode;200;-1084.856,-668.6083;Float;False;Property;_LowPoly;Low Poly;9;1;[Toggle];1;2;0;FLOAT3;0.0;False;1;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-859.5037,-220.1143;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT3;0;False;1;FLOAT3
Node;AmplifyShaderEditor.ColorNode;2;-2759.492,-1253.385;Float;False;Property;_WaterColor;Water Color;0;0;0.4926471,0.8740366,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;124;-882.0831,-657.6036;Float;False;Normal;-1;True;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;128;-657.9543,520.383;Float;False;127;0;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;-2486.047,-1232.555;Float;False;Albedo;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;125;-619.788,244.9404;Float;False;124;0;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;-706.1451,-228.0923;Float;False;VertexAnimation;-1;True;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;163;-631.3639,329.4067;Float;False;162;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;134;-632.9377,159.7002;Float;False;131;0;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;11;-673.6442,428.0303;Float;False;Property;_Opacity;Opacity;8;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;162;-1037.777,716.2555;Float;False;Emission;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-358.2882,224.1705;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;ASESampleShaders/Community/TFHC/Low Poly Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;Off;0;3;False;0;0;Transparent;0.5;True;False;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;False;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;88;0;89;0
WireConnection;88;1;15;0
WireConnection;183;0;88;0
WireConnection;177;0;176;0
WireConnection;177;1;184;0
WireConnection;182;0;177;0
WireConnection;182;2;184;0
WireConnection;118;0;53;0
WireConnection;47;0;195;0
WireConnection;47;1;118;0
WireConnection;179;1;182;0
WireConnection;120;0;119;0
WireConnection;121;0;119;0
WireConnection;164;0;167;0
WireConnection;181;0;179;1
WireConnection;122;0;120;0
WireConnection;122;1;121;0
WireConnection;96;1;47;0
WireConnection;169;1;182;0
WireConnection;86;1;96;0
WireConnection;205;0;122;0
WireConnection;174;0;181;0
WireConnection;174;1;164;0
WireConnection;36;0;86;1
WireConnection;170;0;161;0
WireConnection;170;1;169;0
WireConnection;123;0;205;0
WireConnection;191;0;174;0
WireConnection;44;0;54;0
WireConnection;44;1;43;0
WireConnection;157;0;170;0
WireConnection;157;1;159;0
WireConnection;157;2;191;0
WireConnection;200;0;202;0
WireConnection;200;1;123;0
WireConnection;29;0;36;0
WireConnection;29;1;44;0
WireConnection;124;0;200;0
WireConnection;131;0;2;0
WireConnection;127;0;29;0
WireConnection;162;0;157;0
WireConnection;0;0;134;0
WireConnection;0;1;125;0
WireConnection;0;2;163;0
WireConnection;0;9;11;0
WireConnection;0;11;128;0
ASEEND*/
//CHKSM=AC042A40689F4582F90D90FE0088911E85499A2E
