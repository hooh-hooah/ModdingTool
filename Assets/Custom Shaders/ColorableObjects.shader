// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/ColorableObjectReplica"
{
	Properties
	{
		_NormalMap("NormalMap", 2D) = "bump" {}
		_BlendNormalMap("BlendNormalMap", 2D) = "bump" {}
		_BlendNormalMapStrength("BlendNormalMapStrength", Range( 0 , 10)) = 0
		_DetailNormalMap("DetailNormalMap", 2D) = "bump" {}
		_DetailNormalMapStrength("DetailNormalMapStrength", Range( 0 , 10)) = 0
		_NormalMapStrength("NormalMapStrength", Range( 0 , 10)) = 1
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Metallic2("Metallic 2", Range( 0 , 1)) = 0
		_Metallic3("Metallic 3", Range( 0 , 1)) = 0
		_Metallic4("Metallic 4", Range( 0 , 1)) = 0
		_Glossiness("Glossiness 1", Range( 0 , 1)) = 0
		_Glossiness2("Glossiness 2", Range( 0 , 1)) = 0
		_Glossiness3("Glossiness 3", Range( 0 , 1)) = 0
		_Glossiness4("Glossiness 4", Range( 0 , 1)) = 0
		_Color("Color 1", Color) = (0,0,0,0)
		_Color2("Color 2", Color) = (0,0,0,0)
		_Color3("Color 3", Color) = (0,0,0,0)
		_Color4("Color 4", Color) = (0,0,0,0)
		_MainTex("MainTex", 2D) = "white" {}
		_MetallicSmoothness("MetallicSmoothness", 2D) = "black" {}
		_ColorMask("ColorMask", 2D) = "black" {}
		_AmbientOcclusion("AmbientOcclusion", 2D) = "white" {}
		_Emission("Emission", 2D) = "black" {}
		_NormalizedNormalLerp("NormalizedNormalLerp", Range( 0 , 1)) = 0
		_EmissionBoost("Emission Boost", Range( 0 , 10)) = 1
		_AmbientOcclusionstrength("AmbientOcclusionstrength", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#pragma target 5.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _NormalMapStrength;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float _BlendNormalMapStrength;
		uniform sampler2D _BlendNormalMap;
		uniform float4 _BlendNormalMap_ST;
		uniform float _DetailNormalMapStrength;
		uniform sampler2D _DetailNormalMap;
		uniform float4 _DetailNormalMap_ST;
		uniform float _NormalizedNormalLerp;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform float4 _Color4;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _EmissionBoost;
		uniform sampler2D _MetallicSmoothness;
		uniform float4 _MetallicSmoothness_ST;
		uniform float _Metallic;
		uniform float _Metallic2;
		uniform float _Metallic3;
		uniform float _Metallic4;
		uniform float _Glossiness;
		uniform float _Glossiness2;
		uniform float _Glossiness3;
		uniform float _Glossiness4;
		uniform sampler2D _AmbientOcclusion;
		uniform float4 _AmbientOcclusion_ST;
		uniform float _AmbientOcclusionstrength;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 uv_BlendNormalMap = i.uv_texcoord * _BlendNormalMap_ST.xy + _BlendNormalMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			float3 temp_output_116_0 = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalMapStrength ) , UnpackScaleNormal( tex2D( _BlendNormalMap, uv_BlendNormalMap ), _BlendNormalMapStrength ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), _DetailNormalMapStrength ) );
			float3 lerpResult80 = lerp( temp_output_116_0 , saturate( temp_output_116_0 ) , _NormalizedNormalLerp);
			o.Normal = lerpResult80;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 temp_output_18_0_g38 = tex2D( _MainTex, uv_MainTex );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 tex2DNode36 = tex2D( _ColorMask, uv_ColorMask );
			float4 break17_g38 = tex2DNode36;
			o.Albedo = saturate( ( ( temp_output_18_0_g38 * _Color * ( 1.0 - min( ( break17_g38.x + break17_g38.y + break17_g38.z ) , 1.0 ) ) ) + ( temp_output_18_0_g38 * _Color2 * break17_g38.x ) + ( temp_output_18_0_g38 * _Color3 * break17_g38.y ) + ( temp_output_18_0_g38 * _Color4 * break17_g38.z ) ) ).xyz;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( tex2D( _Emission, uv_Emission ) * _EmissionBoost ).rgb;
			float2 uv_MetallicSmoothness = i.uv_texcoord * _MetallicSmoothness_ST.xy + _MetallicSmoothness_ST.zw;
			float4 tex2DNode91 = tex2D( _MetallicSmoothness, uv_MetallicSmoothness );
			float temp_output_25_0_g41 = ( _Metallic2 * tex2DNode36.x );
			float temp_output_26_0_g41 = ( _Metallic3 * tex2DNode36.x );
			float temp_output_27_0_g41 = ( _Metallic4 * tex2DNode36.x );
			o.Metallic = saturate( ( ( ( tex2DNode91 + _Metallic ) * ( 1.0 - min( ( temp_output_25_0_g41 + temp_output_26_0_g41 + temp_output_27_0_g41 ) , 1.0 ) ) ) + temp_output_25_0_g41 + temp_output_26_0_g41 + temp_output_27_0_g41 ) ).x;
			float4 temp_cast_11 = (tex2DNode91.a).xxxx;
			float temp_output_25_0_g40 = ( _Glossiness2 * tex2DNode36.x );
			float temp_output_26_0_g40 = ( _Glossiness3 * tex2DNode36.x );
			float temp_output_27_0_g40 = ( _Glossiness4 * tex2DNode36.x );
			o.Smoothness = saturate( ( ( ( temp_cast_11 + _Glossiness ) * ( 1.0 - min( ( temp_output_25_0_g40 + temp_output_26_0_g40 + temp_output_27_0_g40 ) , 1.0 ) ) ) + temp_output_25_0_g40 + temp_output_26_0_g40 + temp_output_27_0_g40 ) ).x;
			float4 temp_cast_14 = 1;
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			float4 lerpResult55 = lerp( temp_cast_14 , tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) , _AmbientOcclusionstrength);
			o.Occlusion = lerpResult55.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
210.6667;150.6667;1898;1073;933.1;-107.6913;1.295207;True;False
Node;AmplifyShaderEditor.FunctionNode;116;-258.2054,-345.1763;Inherit;False;NormalMapThreeChannels;0;;33;c7da7c2a6dcfcf04f82411620a87f278;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;11;10.9097,54.23141;Inherit;True;Property;_Emission;Emission;26;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;91;-755.7692,846.7809;Inherit;True;Property;_MetallicSmoothness;MetallicSmoothness;23;0;Create;True;0;0;False;0;-1;None;6ae5bc2d6c2f69c48a2235249da9ded7;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;56;492.978,1475.172;Inherit;False;Constant;_Int0;Int 0;20;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;79;10.11114,-186.522;Inherit;False;Property;_NormalizedNormalLerp;NormalizedNormalLerp;27;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;11.49076,276.9063;Inherit;False;Property;_EmissionBoost;Emission Boost;28;0;Create;True;0;0;False;0;1;1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;88;-760.869,671.1176;Inherit;False;ColorFourChannelVariables;17;;35;cd7b7d1cfa8cb9e47b8fc2bd9a27beae;0;0;4;COLOR;7;COLOR;6;COLOR;0;COLOR;8
Node;AmplifyShaderEditor.FunctionNode;98;-800.092,1224.023;Inherit;False;SmoothnessFourChannelVariables;12;;36;07800ea0383de594f8ec6537a56a6da0;0;0;4;FLOAT;13;FLOAT;14;FLOAT;15;FLOAT;16
Node;AmplifyShaderEditor.RangedFloatNode;16;352.6492,1794.844;Inherit;False;Property;_AmbientOcclusionstrength;AmbientOcclusionstrength;29;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;14;337.5222,1585.686;Inherit;True;Property;_AmbientOcclusion;AmbientOcclusion;25;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;36;-1244.385,843.6664;Inherit;True;Property;_ColorMask;ColorMask;24;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;81;132.698,-275.3711;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;99;-771.9075,1066.079;Inherit;False;MetallicFourChannelVariables;7;;34;fd0bbd716ca150f47960fc8fb1d81fb0;0;0;4;FLOAT;7;FLOAT;6;FLOAT;0;FLOAT;8
Node;AmplifyShaderEditor.SamplerNode;5;-753.8533,438.3854;Inherit;True;Property;_MainTex;MainTex;22;0;Create;True;0;0;False;0;-1;None;3dca6ca26dbc829478373e36d6792b43;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;122;316.8494,936.3783;Inherit;False;PBRMaskFourChannel;-1;;40;ac609f9c1f72911469a487c1b2a944b2;0;6;16;FLOAT4;0,0,0,0;False;18;FLOAT4;0,0,0,0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;55;754.8425,1647.495;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;80;357.8331,-345.0218;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;377.2957,206.0836;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;119;314.2155,502.9959;Inherit;False;ColorMaskFourChannel;-1;;38;ededbe991c9bb084b98a4a40a1bbfe61;0;6;16;FLOAT4;0,0,0,0;False;18;FLOAT4;0,0,0,0;False;19;FLOAT4;0,0,0,0;False;20;FLOAT4;0,0,0,0;False;21;FLOAT4;0,0,0,0;False;22;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;123;318.1008,724.2886;Inherit;False;PBRMaskFourChannel;-1;;41;ac609f9c1f72911469a487c1b2a944b2;0;6;16;FLOAT4;0,0,0,0;False;18;FLOAT4;0,0,0,0;False;19;FLOAT;0;False;20;FLOAT;0;False;21;FLOAT;0;False;22;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1399.757,437.0677;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;hooh/ColorableObjectReplica;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;81;0;116;0
WireConnection;122;16;36;0
WireConnection;122;18;91;4
WireConnection;122;19;98;13
WireConnection;122;20;98;14
WireConnection;122;21;98;15
WireConnection;122;22;98;16
WireConnection;55;0;56;0
WireConnection;55;1;14;0
WireConnection;55;2;16;0
WireConnection;80;0;116;0
WireConnection;80;1;81;0
WireConnection;80;2;79;0
WireConnection;23;0;11;0
WireConnection;23;1;22;0
WireConnection;119;16;36;0
WireConnection;119;18;5;0
WireConnection;119;19;88;7
WireConnection;119;20;88;6
WireConnection;119;21;88;0
WireConnection;119;22;88;8
WireConnection;123;16;36;0
WireConnection;123;18;91;0
WireConnection;123;19;99;7
WireConnection;123;20;99;6
WireConnection;123;21;99;0
WireConnection;123;22;99;8
WireConnection;0;0;119;0
WireConnection;0;1;80;0
WireConnection;0;2;23;0
WireConnection;0;3;123;0
WireConnection;0;4;122;0
WireConnection;0;5;55;0
ASEEND*/
//CHKSM=748D5537A399B6911146F622CB747CF9D65C251A