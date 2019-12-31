// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/UV Light Reveal"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_BaseTexture("Base Texture", 2D) = "white" {}
		_UVTexture("UV Texture", 2D) = "white" {}
		_ColortoBeFiltered("Color to Be Filtered", Color) = (0.4039216,0,1,1)
		_DifferenceThreshold("Difference Threshold", Range( 0 , 0.05)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustomLighting keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		struct SurfaceOutputCustomLightingCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _BaseTexture;
		uniform float4 _BaseTexture_ST;
		uniform sampler2D _UVTexture;
		uniform float4 _UVTexture_ST;
		uniform float4 _ColortoBeFiltered;
		uniform float _DifferenceThreshold;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#if DIRECTIONAL
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			float2 uv_BaseTexture = i.uv_texcoord * _BaseTexture_ST.xy + _BaseTexture_ST.zw;
			float4 temp_output_59_0 = ( ase_lightAtten * _LightColor0 );
			float2 uv_UVTexture = i.uv_texcoord * _UVTexture_ST.xy + _UVTexture_ST.zw;
			float3 componentMask91 = ( _LightColor0 * _WorldSpaceLightPos0.w ).rgb;
			float3 componentMask92 = _ColortoBeFiltered.rgb;
			c.rgb = ( ( tex2D( _BaseTexture, uv_BaseTexture ) * saturate( temp_output_59_0 ) ) + ( tex2D( _UVTexture, uv_UVTexture ).r * ( ( temp_output_59_0 * _WorldSpaceLightPos0.w ) *  ( dot( normalize( componentMask91 ) , normalize( componentMask92 ) ) - _DifferenceThreshold > 1.0 ? 0.0 : dot( normalize( componentMask91 ) , normalize( componentMask92 ) ) - _DifferenceThreshold <= 1.0 && dot( normalize( componentMask91 ) , normalize( componentMask92 ) ) + _DifferenceThreshold >= 1.0 ? 1.0 : 0.0 )  ) ) ).xyz;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10011
441;100;1028;639;1643.645;408.058;1.698814;True;False
Node;AmplifyShaderEditor.WorldSpaceLightPos;54;-1219.7,205.2679;Float;False;0;3;FLOAT4;FLOAT3;FLOAT
Node;AmplifyShaderEditor.LightColorNode;84;-1132.925,359.0915;Float;False;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;85;-915.9946,345.3203;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;87;-1057.309,513.7495;Float;False;Property;_ColortoBeFiltered;Color to Be Filtered;2;0;0.4039216,0,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;92;-734.5231,485.7451;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.ComponentMaskNode;91;-731.6473,379.2185;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LightAttenuation;53;-896.7832,16.67318;Float;False;0;1;FLOAT
Node;AmplifyShaderEditor.LightColorNode;58;-875.2192,128.332;Float;False;0;1;COLOR
Node;AmplifyShaderEditor.NormalizeNode;116;-467.2045,386.9525;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.NormalizeNode;117;-461.5048,470.5531;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;98;-678.827,588.9836;Float;False;Constant;_Float1;Float 1;4;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-681.7908,71.68948;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;90;-721.6726,682.4335;Float;False;Property;_DifferenceThreshold;Difference Threshold;3;0;0;0;0.05;0;1;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;96;-303.6713,411.4413;Float;False;2;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-421.8257,228.5361;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.TFHCIf;100;-145.8477,538.6387;Float;False;6;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;52;-240.3876,51.70139;Float;True;Property;_UVTexture;UV Texture;1;0;Assets/AmplifyShaderEditor/Examples/Official/UVLightReveal/UVLight.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;51;-616.3525,-208.0113;Float;True;Property;_BaseTexture;Base Texture;0;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/SceneTextures/WoodDiffuse.tif;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;92.92843,269.5623;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SaturateNode;79;-189.8604,-60.81562;Float;False;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;80;98.50198,-126.1641;Float;False;2;2;0;FLOAT4;0.0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;295.7195,105.5482;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;78;476.3192,-97.63742;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;647.1755,-147.5417;Float;False;True;2;Float;ASEMaterialInspector;0;CustomLighting;ASESampleShaders/UV Light Reveal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;14;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;85;0;84;0
WireConnection;85;1;54;2
WireConnection;92;0;87;0
WireConnection;91;0;85;0
WireConnection;116;0;91;0
WireConnection;117;0;92;0
WireConnection;59;0;53;0
WireConnection;59;1;58;0
WireConnection;96;0;116;0
WireConnection;96;1;117;0
WireConnection;55;0;59;0
WireConnection;55;1;54;2
WireConnection;100;0;96;0
WireConnection;100;1;98;0
WireConnection;100;3;98;0
WireConnection;100;5;90;0
WireConnection;99;0;55;0
WireConnection;99;1;100;0
WireConnection;79;0;59;0
WireConnection;80;0;51;0
WireConnection;80;1;79;0
WireConnection;57;0;52;1
WireConnection;57;1;99;0
WireConnection;78;0;80;0
WireConnection;78;1;57;0
WireConnection;0;2;78;0
ASEEND*/
//CHKSM=054D002F9CACBF3A4E7EF243F95951AF04647AA5
