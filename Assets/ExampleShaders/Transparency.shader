// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Transparency"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_UVOffset1("UVOffset1", Vector) = (-0.1,-0.1,-0.1,0)
		_TextureSample3("Texture Sample 3", CUBE) = "white" {}
		_Opacity("Opacity", Range( 0 , 1)) = 1
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_TextureSample1("Texture Sample 1", CUBE) = "white" {}
		_char_woodman_normals("char_woodman_normals", 2D) = "bump" {}
		_Cubemap("Cubemap", CUBE) = "white" {}
		_UVOffset0("UVOffset0", Vector) = (0.07,0.1,0.1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
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
			float2 uv_texcoord;
			float3 worldRefl;
			INTERNAL_DATA
		};

		uniform sampler2D _char_woodman_normals;
		uniform float4 _char_woodman_normals_ST;
		uniform samplerCUBE _TextureSample1;
		uniform float3 _UVOffset0;
		uniform samplerCUBE _Cubemap;
		uniform samplerCUBE _TextureSample3;
		uniform float3 _UVOffset1;
		uniform float _Smoothness;
		uniform float _Opacity;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_char_woodman_normals = i.uv_texcoord * _char_woodman_normals_ST.xy + _char_woodman_normals_ST.zw;
			o.Normal = UnpackNormal( tex2D( _char_woodman_normals, uv_char_woodman_normals ) );
			o.Albedo = float4(1,1,1,0).rgb;
			float3 tex2DNode10 = UnpackNormal( tex2D( _char_woodman_normals, uv_char_woodman_normals ) );
			float3 worldrefVec9 = WorldReflectionVector( i , tex2DNode10 );
			float3 appendResult32 = (float3(texCUBE( _TextureSample1, ( worldrefVec9 + _UVOffset0 ) ).r , texCUBE( _Cubemap, worldrefVec9 ).g , texCUBE( _TextureSample3, ( worldrefVec9 + _UVOffset1 ) ).b));
			o.Emission = appendResult32;
			o.Metallic = 1.0;
			o.Smoothness = _Smoothness;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

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
			# include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
				o.worldPos = worldPos;
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
				surfIN.uv_texcoord.xy = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldRefl = -worldViewDir;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=12003
0;92;1541;926;1371.115;369.9559;1.6;False;False
Node;AmplifyShaderEditor.SamplerNode;10;-1400.201,-39.50001;Float;True;Property;_char_woodman_normals;char_woodman_normals;-1;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldReflectionVector;9;-1042.699,194.6001;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;25;-1009.816,641.7439;Float;False;Property;_UVOffset1;UVOffset1;-1;0;-0.1,-0.1,-0.1;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector3Node;24;-1001.816,470.7439;Float;False;Property;_UVOffset0;UVOffset0;-1;0;0.07,0.1,0.1;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-741.8156,623.7439;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-742.4155,168.1439;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;1;-568.5999,323.5997;Float;True;Property;_Cubemap;Cubemap;-1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;0,0;False;1;FLOAT3;1.0;False;2;FLOAT;1.0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;20;-566.8156,525.7439;Float;True;Property;_TextureSample3;Texture Sample 3;-1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;0,0;False;1;FLOAT3;1.0;False;2;FLOAT;1.0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;19;-554.3158,130.5439;Float;True;Property;_TextureSample1;Texture Sample 1;-1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;0,0;False;1;FLOAT3;1.0;False;2;FLOAT;1.0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;32;-158.3146,278.6447;Float;False;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;17;67.48333,164.5437;Float;False;Constant;_Metallic;Metallic;-1;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;33;57.68502,89.24414;Float;False;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.ColorNode;16;94.68337,-258.8558;Float;False;Constant;_Color0;Color 0;-1;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;18;75.28323,256.344;Float;False;Property;_Smoothness;Smoothness;-1;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;14;82.88092,353.6438;Float;False;Property;_Opacity;Opacity;-1;0;1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;559.4,-96.99998;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;ASESampleShaders/Transparency;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;3;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0;False;2;FLOAT3;0.0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0.0;False;7;FLOAT3;0.0;False;8;FLOAT;0.0;False;9;FLOAT;0,0,0;False;10;OBJECT;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;10;0
WireConnection;26;0;9;0
WireConnection;26;1;25;0
WireConnection;23;0;9;0
WireConnection;23;1;24;0
WireConnection;1;1;9;0
WireConnection;20;1;26;0
WireConnection;19;1;23;0
WireConnection;32;0;19;1
WireConnection;32;1;1;2
WireConnection;32;2;20;3
WireConnection;33;0;32;0
WireConnection;0;0;16;0
WireConnection;0;1;10;0
WireConnection;0;2;33;0
WireConnection;0;3;17;0
WireConnection;0;4;18;0
WireConnection;0;9;14;0
ASEEND*/
//CHKSM=EA918958D151C229CBAECAFC7F62CCF6E9541F85
