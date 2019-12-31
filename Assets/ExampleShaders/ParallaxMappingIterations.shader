// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Parallax/ParallaxMappingIterations"
{
	Properties
	{
		_Tiling("Tiling", Float) = 4
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 2)) = 1
		_Metallic("Metallic", 2D) = "white" {}
		_MetallicAmount("Metallic Amount", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", 2D) = "white" {}
		_SmoothnessScale("Smoothness Scale", Float) = 0
		_Occlusion("Occlusion", 2D) = "white" {}
		_HeightMap("HeightMap", 2D) = "white" {}
		_Parallax("Parallax", Range( 0 , 0.1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			fixed2 uv_texcoord;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform fixed _NormalScale;
		uniform sampler2D _Normal;
		uniform fixed _Tiling;
		uniform sampler2D _HeightMap;
		uniform float4 _HeightMap_ST;
		uniform fixed _Parallax;
		uniform sampler2D _Albedo;
		uniform sampler2D _Metallic;
		uniform fixed _MetallicAmount;
		uniform sampler2D _Smoothness;
		uniform fixed _SmoothnessScale;
		uniform sampler2D _Occlusion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			fixed2 temp_cast_0 = (_Tiling).xx;
			float2 uv_TexCoord117 = i.uv_texcoord * temp_cast_0 + float2( 0,0 );
			float2 uv_HeightMap = i.uv_texcoord * _HeightMap_ST.xy + _HeightMap_ST.zw;
			float2 Offset4 = ( ( tex2D( _HeightMap, uv_HeightMap ).r - 1 ) * i.viewDir.xy * _Parallax ) + uv_TexCoord117;
			float2 Offset49 = ( ( tex2D( _HeightMap, Offset4 ).r - 1 ) * i.viewDir.xy * _Parallax ) + Offset4;
			float2 Offset52 = ( ( tex2D( _HeightMap, Offset49 ).r - 1 ) * i.viewDir.xy * _Parallax ) + Offset49;
			float2 Offset54 = ( ( tex2D( _HeightMap, Offset52 ).r - 1 ) * i.viewDir.xy * _Parallax ) + Offset52;
			float2 Offset13 = Offset54;
			o.Normal = UnpackScaleNormal( tex2D( _Normal, Offset13 ) ,_NormalScale );
			o.Albedo = tex2D( _Albedo, Offset13 ).rgb;
			o.Metallic = ( tex2D( _Metallic, Offset13 ).r + _MetallicAmount );
			o.Smoothness = ( tex2D( _Smoothness, Offset13 ).r * _SmoothnessScale );
			o.Occlusion = tex2D( _Occlusion, Offset13 ).r;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14402
452;117;1066;676;2924.886;522.644;3.111037;False;False
Node;AmplifyShaderEditor.RangedFloatNode;21;-2596,-60.60016;Float;False;Property;_Tiling;Tiling;0;0;Create;True;4;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;117;-2409.904,-72.99911;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;9;-2816,256;Float;False;Property;_Parallax;Parallax;10;0;Create;True;0;0.01;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;8;-2688,384;Float;False;Tangent;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WireNode;58;-2197.793,130.0009;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;109;-2199.501,100.4011;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;47;-2167.197,-120.1994;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;48;-1862.899,-121.1993;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;10;-2139.3,-93.09997;Float;True;Property;_HeightMap;HeightMap;9;0;Create;True;None;9f8d9d9e60979574ea22974d2e2c08d4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;116;-1848.502,77.2011;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;57;-1830.593,97.00086;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ParallaxMappingNode;4;-1751.3,-56.79994;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;72;-1511.894,135.3009;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;71;-2187.494,157.7008;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;74;-1488.893,151.6009;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;110;-2203.3,362.2014;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;62;-2204.794,385.8004;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;73;-1784.594,179.3009;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;50;-2163.993,189.9015;Float;True;Property;_TextureSample1;Texture Sample 1;9;0;Create;True;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;59;-1865.193,377.1007;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;115;-1872.301,359.4012;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;49;-1765.997,212.9008;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;119;-2266.403,604.6009;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;76;-1544.393,386.9009;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;118;-2254.403,586.6009;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;64;-2213.494,639.6006;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;75;-2196.593,417.4007;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;78;-1513.194,409.0009;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;111;-2211.7,616.2009;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;51;-2167.34,442.501;Float;True;Property;_TextureSample2;Texture Sample 2;9;0;Create;True;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;63;-1871.594,632.0007;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;77;-1786.994,440.9008;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;114;-1875.101,611.4011;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ParallaxMappingNode;52;-1767.744,467.1004;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;80;-1575.393,652.8008;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;69;-2246.694,880.3996;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;112;-2238.9,852.2011;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;79;-2198.694,688.5005;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;82;-1552.193,684.6006;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;121;-2184.704,899.401;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;120;-2190.704,919.401;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;53;-2167.34,712.5007;Float;True;Property;_TextureSample3;Texture Sample 3;9;0;Create;True;None;None;True;0;False;white;Auto;False;Instance;10;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;81;-1798.893,712.3006;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;113;-1875.302,887.4011;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;70;-1862.694,910.2998;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ParallaxMappingNode;54;-1769.344,735.5002;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-1293.3,291.4999;Float;False;Offset;1;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;16;-953.9002,333.3;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;18;-929.2001,538.4998;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;12;-592,544;Float;True;Property;_Smoothness;Smoothness;6;0;Create;True;None;b97db8acddac10d4c867939fcd38e487;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;38;-512,736;Float;False;Property;_SmoothnessScale;Smoothness Scale;7;0;Create;True;0;0.8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;11;-592,256;Float;True;Property;_Metallic;Metallic;4;0;Create;True;None;d4940c862b9d0f349b3eec6e0da05578;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;41;-576,448;Float;False;Property;_MetallicAmount;Metallic Amount;5;0;Create;True;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;15;-959.6002,196.5;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;17;-947.5999,783.0004;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;14;-959.6004,14.09995;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-909.7999,213.8;Float;False;Property;_NormalScale;Normal Scale;3;0;Create;True;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;7;-592,816;Float;True;Property;_Occlusion;Occlusion;8;0;Create;True;None;120ede8c4897abf488ebbcd0d0b46ede;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;40;-243.8992,299.2003;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-237.3988,473.5015;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-592,-128;Float;True;Property;_Albedo;Albedo;1;0;Create;True;None;efd0eee9e4394a94db1426ce0bb7a902;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;5;-592,64;Float;True;Property;_Normal;Normal;2;0;Create;True;None;00e0021f9f2d77a4fb3d5957267488e7;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;FLOAT2;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;119.6998,201.8002;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Parallax/ParallaxMappingIterations;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;117;0;21;0
WireConnection;58;0;8;0
WireConnection;109;0;9;0
WireConnection;47;0;117;0
WireConnection;48;0;47;0
WireConnection;116;0;109;0
WireConnection;57;0;58;0
WireConnection;4;0;48;0
WireConnection;4;1;10;1
WireConnection;4;2;116;0
WireConnection;4;3;57;0
WireConnection;72;0;4;0
WireConnection;71;0;72;0
WireConnection;74;0;4;0
WireConnection;110;0;9;0
WireConnection;62;0;8;0
WireConnection;73;0;74;0
WireConnection;50;1;71;0
WireConnection;59;0;62;0
WireConnection;115;0;110;0
WireConnection;49;0;73;0
WireConnection;49;1;50;1
WireConnection;49;2;115;0
WireConnection;49;3;59;0
WireConnection;119;0;8;0
WireConnection;76;0;49;0
WireConnection;118;0;9;0
WireConnection;64;0;119;0
WireConnection;75;0;76;0
WireConnection;78;0;49;0
WireConnection;111;0;118;0
WireConnection;51;1;75;0
WireConnection;63;0;64;0
WireConnection;77;0;78;0
WireConnection;114;0;111;0
WireConnection;52;0;77;0
WireConnection;52;1;51;1
WireConnection;52;2;114;0
WireConnection;52;3;63;0
WireConnection;80;0;52;0
WireConnection;69;0;8;0
WireConnection;112;0;9;0
WireConnection;79;0;80;0
WireConnection;82;0;52;0
WireConnection;121;0;112;0
WireConnection;120;0;69;0
WireConnection;53;1;79;0
WireConnection;81;0;82;0
WireConnection;113;0;121;0
WireConnection;70;0;120;0
WireConnection;54;0;81;0
WireConnection;54;1;53;1
WireConnection;54;2;113;0
WireConnection;54;3;70;0
WireConnection;13;0;54;0
WireConnection;16;0;13;0
WireConnection;18;0;13;0
WireConnection;12;1;18;0
WireConnection;11;1;16;0
WireConnection;15;0;13;0
WireConnection;17;0;13;0
WireConnection;14;0;13;0
WireConnection;7;1;17;0
WireConnection;40;0;11;1
WireConnection;40;1;41;0
WireConnection;100;0;12;1
WireConnection;100;1;38;0
WireConnection;1;1;14;0
WireConnection;5;1;15;0
WireConnection;5;5;6;0
WireConnection;0;0;1;0
WireConnection;0;1;5;0
WireConnection;0;3;40;0
WireConnection;0;4;100;0
WireConnection;0;5;7;1
ASEEND*/
//CHKSM=1383808D88A85AD081A0BC0237FE40DCCA1CBED7
