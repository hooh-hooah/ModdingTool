// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/ColorableObjectReplica"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
		_Color2("Color2", Color) = (0,0,0,0)
		_Color3("Color3", Color) = (0,0,0,0)
		_Color4("Color4", Color) = (0,0,0,0)
		_Diffuse("Diffuse", 2D) = "white" {}
		_ColorMask("ColorMask", 2D) = "black" {}
		_Metalic("Metalic", Range( 0 , 1)) = 0
		_Glossiness("Glossiness", Range( 0 , 1)) = 0
		_NormalMap("NormalMap", 2D) = "bump" {}
		_GlossinessTexture("Glossiness Texture", 2D) = "white" {}
		_MetalicTexture("Metalic Texture", 2D) = "white" {}
		_AmbientOcclusion("AmbientOcclusion", 2D) = "white" {}
		_Emission("Emission", 2D) = "black" {}
		_BlendNormalMap("BlendNormalMap", 2D) = "bump" {}
		_BlendNormalMapStrength("BlendNormalMapStrength", Range( 0 , 10)) = 0
		_DetailNormalMap("DetailNormalMap", 2D) = "bump" {}
		_DetailNormalMapStrength("DetailNormalMapStrength", Range( 0 , 10)) = 0
		_EmissionBoost("Emission Boost", Range( 0 , 10)) = 1
		_AmbientOcclusionstrength("AmbientOcclusionstrength", Range( 0 , 1)) = 0
		_NormalMapStrength("NormalMapStrength", Range( 0 , 10)) = 0
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
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float4 _Color;
		uniform sampler2D _ColorMask;
		uniform float4 _ColorMask_ST;
		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform float4 _Color4;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _EmissionBoost;
		uniform sampler2D _MetalicTexture;
		uniform float4 _MetalicTexture_ST;
		uniform float _Metalic;
		uniform sampler2D _GlossinessTexture;
		uniform float4 _GlossinessTexture_ST;
		uniform float _Glossiness;
		uniform sampler2D _AmbientOcclusion;
		uniform float4 _AmbientOcclusion_ST;
		uniform float _AmbientOcclusionstrength;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 uv_BlendNormalMap = i.uv_texcoord * _BlendNormalMap_ST.xy + _BlendNormalMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			o.Normal = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalMapStrength ) , UnpackScaleNormal( tex2D( _BlendNormalMap, uv_BlendNormalMap ), _BlendNormalMapStrength ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ), _DetailNormalMapStrength ) );
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float4 tex2DNode5 = tex2D( _Diffuse, uv_Diffuse );
			float2 uv_ColorMask = i.uv_texcoord * _ColorMask_ST.xy + _ColorMask_ST.zw;
			float4 tex2DNode36 = tex2D( _ColorMask, uv_ColorMask );
			o.Albedo = ( ( tex2DNode5 * _Color * ( 1.0 - min( ( tex2DNode36.r + tex2DNode36.g + tex2DNode36.b ) , 1.0 ) ) ) + ( tex2DNode5 * _Color2 * tex2DNode36.r ) + ( tex2DNode5 * _Color3 * tex2DNode36.g ) + ( tex2DNode5 * _Color4 * tex2DNode36.b ) ).rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			o.Emission = ( tex2D( _Emission, uv_Emission ) * _EmissionBoost ).rgb;
			float2 uv_MetalicTexture = i.uv_texcoord * _MetalicTexture_ST.xy + _MetalicTexture_ST.zw;
			o.Metallic = ( tex2D( _MetalicTexture, uv_MetalicTexture ) * _Metalic ).r;
			float2 uv_GlossinessTexture = i.uv_texcoord * _GlossinessTexture_ST.xy + _GlossinessTexture_ST.zw;
			o.Smoothness = ( tex2D( _GlossinessTexture, uv_GlossinessTexture ) * _Glossiness ).r;
			float2 uv_AmbientOcclusion = i.uv_texcoord * _AmbientOcclusion_ST.xy + _AmbientOcclusion_ST.zw;
			float4 temp_cast_4 = 1;
			float4 lerpResult55 = lerp( tex2D( _AmbientOcclusion, uv_AmbientOcclusion ) , temp_cast_4 , _AmbientOcclusionstrength);
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
-1911;-2214.428;1903;826;1741.266;-554.0757;1.3;True;True
Node;AmplifyShaderEditor.SamplerNode;36;-1332.505,-701.3339;Inherit;True;Property;_ColorMask;ColorMask;5;0;Create;True;0;0;False;0;-1;None;aea34122812c2e746a2f0fed29c68cf2;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-995.0341,-1380.151;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-2005.198,7.217694;Inherit;False;Property;_BlendNormalMapStrength;BlendNormalMapStrength;14;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1995.455,-214.175;Inherit;False;Property;_NormalMapStrength;NormalMapStrength;19;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMinOpNode;74;-800.0353,-1374.951;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1327.87,-1721.806;Inherit;True;Property;_Diffuse;Diffuse;4;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;46;-1271.753,-1082.33;Inherit;False;Property;_Color3;Color3;2;0;Create;False;0;0;False;0;0,0,0,0;0.05319411,1,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;44;-1267.532,-1483.091;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;47;-1272.965,-895.3301;Inherit;False;Property;_Color4;Color4;3;0;Create;True;0;0;False;0;0,0,0,0;0,0.02520418,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;73;-606.3354,-1369.751;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;45;-1268.93,-1286.303;Inherit;False;Property;_Color2;Color2;1;0;Create;False;0;0;False;0;0,0,0,0;1,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;14;-408.1124,1448.078;Inherit;True;Property;_AmbientOcclusion;AmbientOcclusion;11;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-1600.453,-38.65481;Inherit;True;Property;_BlendNormalMap;BlendNormalMap;13;0;Create;True;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;56;-245.8317,1663.718;Inherit;False;Constant;_Int0;Int 0;20;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-401.1599,1752.389;Inherit;False;Property;_AmbientOcclusionstrength;AmbientOcclusionstrength;18;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;26;-1994.492,230.2742;Inherit;False;Property;_DetailNormalMapStrength;DetailNormalMapStrength;16;0;Create;True;0;0;False;0;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1590.71,-260.0475;Inherit;True;Property;_NormalMap;NormalMap;8;0;Create;True;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-309.0906,-1554.139;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;12;-1156.551,1165.571;Inherit;True;Property;_GlossinessTexture;Glossiness Texture;9;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;28;-1216.562,-124.2777;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-292.3624,-800.1703;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;11;-1143.125,400.7725;Inherit;True;Property;_Emission;Emission;12;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;55;1.032815,1605.041;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-813.7646,790.5439;Inherit;True;Property;_MetalicTexture;Metalic Texture;10;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;18;-1153.148,1366.958;Inherit;False;Property;_Glossiness;Glossiness;7;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;27;-1589.747,184.4017;Inherit;True;Property;_DetailNormalMap;DetailNormalMap;15;0;Create;True;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;22;-1139.824,589.0338;Inherit;False;Property;_EmissionBoost;Emission Boost;17;0;Create;True;0;0;False;0;1;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-807.7045,995.7675;Inherit;False;Property;_Metalic;Metalic;6;0;Create;False;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;50;-285.0477,-1252.242;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-289.3738,-1032.854;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-477.1748,935.2695;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;53;60.74355,-1152.935;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;-794.7302,1273.251;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.BlendNormalsNode;29;-733.8535,37.82979;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-805.3729,520.623;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;57;618.7651,1544.026;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;54;-1.254958,327.1514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1399.757,437.0677;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;hooh/ColorableObjectReplica;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;True;Opaque;;Geometry;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;0;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;71;0;36;1
WireConnection;71;1;36;2
WireConnection;71;2;36;3
WireConnection;74;0;71;0
WireConnection;73;0;74;0
WireConnection;25;5;24;0
WireConnection;6;5;10;0
WireConnection;43;0;5;0
WireConnection;43;1;44;0
WireConnection;43;2;73;0
WireConnection;28;0;6;0
WireConnection;28;1;25;0
WireConnection;52;0;5;0
WireConnection;52;1;47;0
WireConnection;52;2;36;3
WireConnection;55;0;14;0
WireConnection;55;1;56;0
WireConnection;55;2;16;0
WireConnection;27;5;26;0
WireConnection;50;0;5;0
WireConnection;50;1;45;0
WireConnection;50;2;36;1
WireConnection;51;0;5;0
WireConnection;51;1;46;0
WireConnection;51;2;36;2
WireConnection;21;0;13;0
WireConnection;21;1;20;0
WireConnection;53;0;43;0
WireConnection;53;1;50;0
WireConnection;53;2;51;0
WireConnection;53;3;52;0
WireConnection;19;0;12;0
WireConnection;19;1;18;0
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;23;0;11;0
WireConnection;23;1;22;0
WireConnection;57;0;55;0
WireConnection;54;0;5;3
WireConnection;0;0;53;0
WireConnection;0;1;29;0
WireConnection;0;2;23;0
WireConnection;0;3;21;0
WireConnection;0;4;19;0
WireConnection;0;5;57;0
WireConnection;0;9;54;0
ASEEND*/
//CHKSM=D81FD194F06290B482FBB6CE6E40F5418A8DF98E