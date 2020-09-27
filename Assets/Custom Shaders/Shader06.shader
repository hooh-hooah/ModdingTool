// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/ClotheReplicaOpaqueAnisoModularCutoutAlpha"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.23
		_CutoutMap("CutoutMap", 2D) = "white" {}
		_MainTex("MainTex", 2D) = "white" {}
		_FresnelColor("FresnelColor", Color) = (0.7075472,0.7075472,0.7075472,1)
		_BaseColor("BaseColor", Color) = (0.7075472,0.7075472,0.7075472,1)
		_NormalMap("NormalMap", 2D) = "bump" {}
		_NormalMapScale("NormalMapScale", Range( 0 , 1)) = 0
		_DetailNormalMap("DetailNormalMap", 2D) = "bump" {}
		_DetailNormalMap2("DetailNormalMap2", 2D) = "bump" {}
		_DetailNormalScale2("DetailNormalScale2", Range( 0 , 1)) = 0
		_OcclusionMap("OcclusionMap", 2D) = "white" {}
		_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
		_Glossiness("Glossiness", Range( 0 , 1)) = 0
		_GlossAniso("GlossAniso", Range( 0 , 0.99)) = 0.99
		_Anisotropy("Anisotropy", Range( 0 , 1)) = 0
		_SpecularTexture("SpecularTexture", 2D) = "white" {}
		_SpecularSqr("Specular Sqr", Range( 0 , 3)) = 1
		_PiMultiplier("PiMultiplier", Range( 0.1 , 10)) = 8
		_SpecularColor("SpecularColor", Color) = (0,0,0,0)
		_TangentDirection("Tangent Direction", 2D) = "bump" {}
		_TangentContrast("Tangent Contrast", Range( 0 , 1)) = 0
		[HideInInspector]_MetalicGlossMap("MetalicGlossMap", 2D) = "black" {}
		[HideInInspector]_DetailGlossMap("DetailGlossMap", 2D) = "white" {}
		_DetailMainTex("DetailMainTex", 2D) = "gray" {}
		[HideInInspector]_Emission("Emission", Color) = (1,1,1,1)
		[HideInInspector]_Color2("Color1", Color) = (1,1,1,1)
		[HideInInspector]_Color1_3("Color1_2", Color) = (1,1,1,1)
		[HideInInspector]_Color3("Color2", Color) = (1,1,1,1)
		[HideInInspector]_Color4("Color3", Color) = (1,1,1,1)
		[HideInInspector]_Color3_3("Color3_2", Color) = (1,1,1,1)
		[HideInInspector]_Color_3("Color2_2", Color) = (1,1,1,1)
		[HideInInspector]_DetailMask("DetailMask", 2D) = "white" {}
		[HideInInspector]_AlphaMask("AlphaMask", 2D) = "white" {}
		[HideInInspector]_AlphaMask2("AlphaMask2", 2D) = "white" {}
		[HideInInspector]_DetailGlossMap2("DetailGlossMap2", 2D) = "white" {}
		_Scale("Scale", Range( 0 , 11)) = 0
		_Bias("Bias", Range( 0 , 1)) = 0
		_Power("Power", Range( 0 , 11)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform float4 _Emission;
		uniform float4 _Color3;
		uniform sampler2D _DetailMask;
		uniform sampler2D _AlphaMask;
		uniform float4 _Color3_3;
		uniform float4 _Color2;
		uniform sampler2D _AlphaMask2;
		uniform float4 _Color1_3;
		uniform float4 _Color4;
		uniform sampler2D _MetalicGlossMap;
		uniform sampler2D _DetailGlossMap2;
		uniform float4 _Color_3;
		uniform sampler2D _DetailGlossMap;
		uniform float _NormalMapScale;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _DetailNormalMap;
		uniform float4 _DetailNormalMap_ST;
		uniform float _DetailNormalScale2;
		uniform sampler2D _DetailNormalMap2;
		uniform float4 _DetailNormalMap2_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _BaseColor;
		uniform float4 _FresnelColor;
		uniform float _Bias;
		uniform float _Scale;
		uniform float _Power;
		uniform float _Anisotropy;
		uniform sampler2D _TangentDirection;
		uniform float4 _TangentDirection_ST;
		uniform float _TangentContrast;
		uniform float _GlossAniso;
		uniform sampler2D _SpecularTexture;
		uniform float4 _SpecularTexture_ST;
		uniform float _PiMultiplier;
		uniform float4 _SpecularColor;
		uniform float _SpecularSqr;
		uniform float _Glossiness;
		uniform sampler2D _DetailMainTex;
		uniform float4 _DetailMainTex_ST;
		uniform sampler2D _OcclusionMap;
		uniform float4 _OcclusionMap_ST;
		uniform float _OcclusionStrength;
		uniform sampler2D _CutoutMap;
		uniform float4 _CutoutMap_ST;
		uniform float _Cutoff = 0.23;


		inline float3x3 Transpose5_g132( float3 Tangent , float3 Bitangent , float3 Normal )
		{
			return transpose(float3x3(Tangent, Bitangent, Normal));
		}


		inline float3 VertexBasedViewDirection7_g416( float3 CameraPos , float3 VectorPos )
		{
			return normalize(CameraPos - VectorPos);
		}


		inline float3 VertexBasedViewDirection7_g412( float3 CameraPos , float3 VectorPos )
		{
			return normalize(CameraPos - VectorPos);
		}


		inline float RoughToSpec( half Glossiness )
		{
			return RoughnessToSpecPower(Glossiness);
		}


		inline half DNLDot7_g410( half3 Normal , half3 Light )
		{
			return max(0, dot(Normal, Light));
		}


		inline float NoramlizationSpec46_g408( half Spec , half PI , float PIMul )
		{
			return sqrt((Spec + 1) * ((Spec) + 1)) / (8 * PI);
		}


		inline float3 FresTerm35_g408( float DotLightHalf , float4 SpecularMap , float4 SpecularColor )
		{
			return FresnelTerm(SpecularColor.rgb * SpecularMap.rgb, DotLightHalf);
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float2 uv_DetailNormalMap = i.uv_texcoord * _DetailNormalMap_ST.xy + _DetailNormalMap_ST.zw;
			float2 uv_DetailNormalMap2 = i.uv_texcoord * _DetailNormalMap2_ST.xy + _DetailNormalMap2_ST.zw;
			float3 temp_output_506_0 = BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ), _NormalMapScale ) , UnpackNormal( tex2D( _DetailNormalMap, uv_DetailNormalMap ) ) ) , UnpackScaleNormal( tex2D( _DetailNormalMap2, uv_DetailNormalMap2 ), _DetailNormalScale2 ) );
			o.Normal = temp_output_506_0;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode532 = tex2D( _MainTex, uv_MainTex );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 newWorldNormal482 = (WorldNormalVector( i , temp_output_506_0 ));
			float fresnelNdotV567 = dot( newWorldNormal482, ase_worldViewDir );
			float fresnelNode567 = ( _Bias + _Scale * pow( 1.0 - fresnelNdotV567, _Power ) );
			o.Albedo = saturate( ( ( tex2DNode532 * _BaseColor ) + ( _FresnelColor * fresnelNode567 ) ) ).rgb;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult8_g414 = normalize( ase_worldlightDir );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 Tangent5_g132 = ase_worldTangent;
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 Bitangent5_g132 = ase_worldBitangent;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 Normal5_g132 = ase_worldNormal;
			float3x3 localTranspose5_g132 = Transpose5_g132( Tangent5_g132 , Bitangent5_g132 , Normal5_g132 );
			float3x3 temp_output_49_0_g408 = localTranspose5_g132;
			float3 lerpResult19_g408 = lerp( ase_worldTangent , mul( temp_output_49_0_g408, float3(0,1,0) ) , _Anisotropy);
			float2 uv_TangentDirection = i.uv_texcoord * _TangentDirection_ST.xy + _TangentDirection_ST.zw;
			float3 break66_g408 = UnpackNormal( tex2D( _TangentDirection, uv_TangentDirection ) );
			float4 appendResult13_g408 = (float4(break66_g408.x , break66_g408.y , 0.0 , 0.0));
			float3 appendResult15_g408 = (float3(float4( mul( temp_output_49_0_g408, appendResult13_g408.xyz ) , 0.0 ).xyz));
			float3 lerpResult37_g408 = lerp( lerpResult19_g408 , appendResult15_g408 , _TangentContrast);
			float3 normalizeResult42_g408 = normalize( lerpResult37_g408 );
			float dotResult3_g414 = dot( normalizeResult8_g414 , normalizeResult42_g408 );
			float temp_output_1_0_g409 = dotResult3_g414;
			float3 CameraPos7_g416 = _WorldSpaceCameraPos;
			float3 VectorPos7_g416 = ase_worldPos;
			float3 localVertexBasedViewDirection7_g416 = VertexBasedViewDirection7_g416( CameraPos7_g416 , VectorPos7_g416 );
			float dotResult4_g415 = dot( localVertexBasedViewDirection7_g416 , normalizeResult42_g408 );
			float temp_output_1_0_g417 = dotResult4_g415;
			float3 normalizeResult8_g413 = normalize( ase_worldlightDir );
			float dotResult3_g413 = dot( normalizeResult8_g413 , normalizeResult42_g408 );
			float3 CameraPos7_g412 = _WorldSpaceCameraPos;
			float3 VectorPos7_g412 = ase_worldPos;
			float3 localVertexBasedViewDirection7_g412 = VertexBasedViewDirection7_g412( CameraPos7_g412 , VectorPos7_g412 );
			float dotResult4_g411 = dot( localVertexBasedViewDirection7_g412 , normalizeResult42_g408 );
			float2 uv_SpecularTexture = i.uv_texcoord * _SpecularTexture_ST.xy + _SpecularTexture_ST.zw;
			float4 tex2DNode41_g408 = tex2D( _SpecularTexture, uv_SpecularTexture );
			float Glossiness33_g408 = ( 1.0 - ( _GlossAniso * tex2DNode41_g408.a ) );
			float localRoughToSpec33_g408 = RoughToSpec( Glossiness33_g408 );
			float3 temp_output_64_0_g408 = newWorldNormal482;
			half3 Normal7_g410 = temp_output_64_0_g408;
			half3 Light7_g410 = ase_worldlightDir;
			half localDNLDot7_g410 = DNLDot7_g410( Normal7_g410 , Light7_g410 );
			float Spec46_g408 = localRoughToSpec33_g408;
			float PI46_g408 = ( _PiMultiplier * UNITY_PI );
			float PIMul46_g408 = 8.0;
			float localNoramlizationSpec46_g408 = NoramlizationSpec46_g408( Spec46_g408 , PI46_g408 , PIMul46_g408 );
			float3 normalizeResult4_g421 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult3_g418 = dot( normalizeResult4_g421 , temp_output_64_0_g408 );
			float DotLightHalf35_g408 = dotResult3_g418;
			float4 SpecularMap35_g408 = float4( _SpecularColor.rgb , 0.0 );
			float4 SpecularColor35_g408 = tex2DNode41_g408;
			float3 localFresTerm35_g408 = FresTerm35_g408( DotLightHalf35_g408 , SpecularMap35_g408 , SpecularColor35_g408 );
			float temp_output_1_0_g322 = _SpecularSqr;
			o.Specular = ( ( ( saturate( pow( saturate( ( ( sqrt( ( 1.0 - ( temp_output_1_0_g409 * temp_output_1_0_g409 ) ) ) * sqrt( ( 1.0 - ( temp_output_1_0_g417 * temp_output_1_0_g417 ) ) ) ) - ( dotResult3_g413 * dotResult4_g411 ) ) ) , localRoughToSpec33_g408 ) ) * localDNLDot7_g410 ) * ( localNoramlizationSpec46_g408 * localFresTerm35_g408 ) ) * ( temp_output_1_0_g322 * temp_output_1_0_g322 ) );
			float2 uv_DetailMainTex = i.uv_texcoord * _DetailMainTex_ST.xy + _DetailMainTex_ST.zw;
			o.Smoothness = saturate( ( _Glossiness + tex2D( _DetailMainTex, uv_DetailMainTex ).r ) );
			float2 uv_OcclusionMap = i.uv_texcoord * _OcclusionMap_ST.xy + _OcclusionMap_ST.zw;
			float4 lerpResult544 = lerp( float4( 1,1,1,1 ) , tex2D( _OcclusionMap, uv_OcclusionMap ) , _OcclusionStrength);
			o.Occlusion = lerpResult544.r;
			float2 uv_CutoutMap = i.uv_texcoord * _CutoutMap_ST.xy + _CutoutMap_ST.zw;
			float4 tex2DNode559 = tex2D( _CutoutMap, uv_CutoutMap );
			o.Alpha = ( ( ( tex2DNode532.a * _BaseColor.a ) + fresnelNode567 ) * tex2DNode559 ).r;
			clip( tex2DNode559.r - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows 

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
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				half3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
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
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
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
Version=17400
0;112.6667;869;896;-2787.004;-47.42978;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;503;1790.874,701.0833;Inherit;False;Property;_DetailNormalScale2;DetailNormalScale2;9;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;494;1800.118,298.7148;Inherit;False;Property;_NormalMapScale;NormalMapScale;5;0;Create;True;0;0;False;0;0;0.864;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;502;2106.874,654.0833;Inherit;True;Property;_DetailNormalMap2;DetailNormalMap2;8;0;Create;True;0;0;False;0;-1;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;489;2108.953,456.8777;Inherit;True;Property;_DetailNormalMap;DetailNormalMap;6;0;Create;True;0;0;False;0;-1;None;36b3b16ce3155614bb9351497328bac9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;490;2109.359,254.6846;Inherit;True;Property;_NormalMap;NormalMap;4;0;Create;True;0;0;False;0;-1;None;731a796d26cc6e84db41b873fb038d87;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;505;2446.674,365.9167;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;507;2655.066,690.0902;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;506;2743.674,566.9166;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;577;3128.238,399.1942;Inherit;False;Property;_Scale;Scale;45;0;Create;True;0;0;False;0;0;3;0;11;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;576;3131.238,324.1942;Inherit;False;Property;_Bias;Bias;46;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;578;3111.238,469.1942;Inherit;False;Property;_Power;Power;47;0;Create;True;0;0;False;0;0;5.09;0;11;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;482;3080.067,659.6278;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FresnelNode;567;3710.96,435.2154;Inherit;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;531;3170.535,117.8714;Inherit;False;Property;_BaseColor;BaseColor;3;0;Create;True;0;0;False;0;0.7075472,0.7075472,0.7075472,1;0.3113207,0.3113207,0.3113207,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;532;3089.217,-94.25374;Inherit;True;Property;_MainTex;MainTex;1;0;Create;True;0;0;False;0;-1;None;620c2f271c1e1f440af5ee3f8fad35a6;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;570;3735.231,91.97133;Inherit;False;Property;_FresnelColor;FresnelColor;2;0;Create;True;0;0;False;0;0.7075472,0.7075472,0.7075472,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;534;3827.062,-48.7168;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;571;4034.228,115.3711;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;211;3079.648,1174.886;Inherit;False;Property;_SpecularColor;SpecularColor;18;0;Create;True;0;0;False;0;0,0,0,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;533;3771.158,329.7625;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;310;3018.617,1088.351;Inherit;False;Property;_TangentContrast;Tangent Contrast;20;0;Create;True;0;0;False;0;0;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;573;4182.766,-49.00845;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;192;4222.882,936.0411;Inherit;False;Property;_Glossiness;Glossiness;12;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;551;3859.842,738.3796;Float;False;Property;_SpecularSqr;Specular Sqr;16;0;Create;True;0;0;False;0;1;0.32;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;487;2960.593,888.4166;Inherit;True;Property;_TangentDirection;Tangent Direction;19;0;Create;True;0;0;False;0;-1;None;b2c62b5731c45d44f925ccb1c4a0bd61;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;251;3006.685,1509.924;Inherit;False;Property;_GlossAniso;GlossAniso;13;0;Create;True;0;0;False;0;0.99;0.489;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;266;3004.461,1425.517;Inherit;False;Property;_Anisotropy;Anisotropy;14;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;484;3055.119,1601.038;Inherit;True;Property;_SpecularTexture;SpecularTexture;15;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;270;3007.865,1345.666;Float;False;Property;_PiMultiplier;PiMultiplier;17;0;Create;True;0;0;False;0;8;0.39;0.1;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;537;4210.975,1029.696;Inherit;True;Property;_DetailMainTex;DetailMainTex;23;0;Create;True;0;0;True;0;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;417;3055.067,809.6281;Inherit;False;tangentTransform;-1;;132;6f6290745523df040a2cbc0d983ff0ae;0;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;568;4023.819,358.7666;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;553;4166.842,747.3796;Inherit;False;Sqr;-1;;322;bad2469aeb0972542b5c0e6d21840f32;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;542;4235.186,1463.123;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;11;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;559;4814.311,1562.913;Inherit;True;Property;_CutoutMap;CutoutMap;0;0;Create;True;0;0;False;0;-1;None;64ab1dd0cc1490c44bf6777491f702cd;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;541;4227.8,1254.793;Inherit;True;Property;_OcclusionMap;OcclusionMap;10;0;Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;566;3407.525,1073.519;Inherit;False;Anisotrophic Specular;-1;;408;21455c6c4cfb6514fa8fda251753b042;0;9;64;FLOAT3;0,0,0;False;49;FLOAT3x3;0,0,0,1,1,1,1,0,1;False;50;FLOAT3;0,0,0;False;51;FLOAT;0;False;52;FLOAT3;0,0,0;False;53;FLOAT;8;False;54;FLOAT;8;False;55;FLOAT;8;False;56;SAMPLER2D;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;538;4548.348,995.5741;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;574;4365.567,-48.48395;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector2Node;513;4830.445,-1147.49;Inherit;False;Property;_patternuv3;patternuv2;42;1;[HideInInspector];Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;510;4473.486,-776.3437;Inherit;False;Property;_Color3;Color2;28;1;[HideInInspector];Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;530;4903.491,-95.82648;Inherit;False;Property;_Cutoff;Cutoff;24;1;[HideInInspector];Create;True;0;0;False;0;0.2;0.23;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;522;4827.941,-1017.987;Inherit;False;Property;_patternuv2;patternuv1;40;1;[HideInInspector];Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;511;3213.876,-786.0837;Inherit;True;Property;_AlphaMask;AlphaMask;37;1;[HideInInspector];Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;527;4609.878,-164.7562;Inherit;False;Property;_DetailUV2Rotator;DetailUV2Rotator;34;1;[HideInInspector];Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;528;4903.491,-189.8265;Inherit;False;Property;_CarvatureStrength;CarvatureStrength;36;1;[HideInInspector];Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;520;4214.307,-779.7328;Inherit;False;Property;_Color2;Color1;26;1;[HideInInspector];Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;544;4620.504,1308.279;Inherit;False;3;0;COLOR;1,1,1,1;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;523;3211.234,-564.2087;Inherit;True;Property;_MetalicGlossMap;MetalicGlossMap;21;1;[HideInInspector];Create;True;0;0;True;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;539;4695.348,1007.574;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;509;3839.637,-784.2888;Inherit;True;Property;_AlphaMask2;AlphaMask2;38;1;[HideInInspector];Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;575;5066.683,189.0634;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;524;3540.378,-569.0937;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;22;1;[HideInInspector];Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;512;5062.419,-564.1747;Inherit;False;Property;_Emission;Emission;25;1;[HideInInspector];Create;True;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;529;4898.673,-278.1723;Inherit;False;Property;_AlphaEx;AlphaEx;35;1;[HideInInspector];Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;579;5336.366,993.1164;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;515;4483.486,-575.3437;Inherit;False;Property;_Color_3;Color2_2;31;1;[HideInInspector];Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;558;5399.058,652.8923;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;508;5014.329,-1016.394;Inherit;False;Property;_UVScalePattern1;UVScalePattern;44;1;[HideInInspector];Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;521;4828.941,-1278.987;Inherit;False;Property;_patternuv4;patternuv3;43;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;550;4377.674,747.2158;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;519;4758.486,-773.3437;Inherit;False;Property;_Color4;Color3;29;1;[HideInInspector];Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;518;4212.704,-575.7516;Inherit;False;Property;_Color1_3;Color1_2;27;1;[HideInInspector];Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;516;3836.115,-570.2358;Inherit;True;Property;_DetailMask;DetailMask;32;1;[HideInInspector];Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;514;4826.941,-1410.988;Inherit;False;Property;_patternuvbase1;patternuvbase;41;0;Create;False;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;495;1796.565,502.4803;Inherit;False;Property;_DetailNormalScale;DetailNormalScale;7;0;Create;True;0;0;False;0;0;0.644;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;525;4759.486,-571.3437;Inherit;False;Property;_Color3_3;Color3_2;30;1;[HideInInspector];Create;False;0;0;True;0;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;526;4613.878,-82.75616;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;33;1;[HideInInspector];Create;True;0;0;False;0;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;517;3532.378,-777.0937;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;39;1;[HideInInspector];Create;True;0;0;True;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;5673.814,1144.802;Float;False;True;-1;2;ASEMaterialInspector;0;0;StandardSpecular;hooh/ClotheReplicaOpaqueAnisoModularCutoutAlpha;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.23;True;True;0;True;TransparentCutout;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;502;5;503;0
WireConnection;490;5;494;0
WireConnection;505;0;490;0
WireConnection;505;1;489;0
WireConnection;507;0;502;0
WireConnection;506;0;505;0
WireConnection;506;1;507;0
WireConnection;482;0;506;0
WireConnection;567;0;482;0
WireConnection;567;1;576;0
WireConnection;567;2;577;0
WireConnection;567;3;578;0
WireConnection;534;0;532;0
WireConnection;534;1;531;0
WireConnection;571;0;570;0
WireConnection;571;1;567;0
WireConnection;533;0;532;4
WireConnection;533;1;531;4
WireConnection;573;0;534;0
WireConnection;573;1;571;0
WireConnection;568;0;533;0
WireConnection;568;1;567;0
WireConnection;553;1;551;0
WireConnection;566;64;482;0
WireConnection;566;49;417;0
WireConnection;566;50;487;0
WireConnection;566;51;310;0
WireConnection;566;52;211;0
WireConnection;566;53;270;0
WireConnection;566;54;266;0
WireConnection;566;55;251;0
WireConnection;566;56;484;0
WireConnection;538;0;192;0
WireConnection;538;1;537;1
WireConnection;574;0;573;0
WireConnection;544;1;541;0
WireConnection;544;2;542;0
WireConnection;539;0;538;0
WireConnection;575;0;574;0
WireConnection;579;0;568;0
WireConnection;579;1;559;0
WireConnection;558;0;506;0
WireConnection;550;0;566;0
WireConnection;550;1;553;0
WireConnection;0;0;575;0
WireConnection;0;1;558;0
WireConnection;0;3;550;0
WireConnection;0;4;539;0
WireConnection;0;5;544;0
WireConnection;0;9;579;0
WireConnection;0;10;559;0
ASEEND*/
//CHKSM=0EDD39C7D4227804B192C2D2B460BCBCC9DB5A90