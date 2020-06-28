// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "hooh/ClotheReplicaOpaqueAniso"
{
	Properties
	{
		_Float1("Float 1", Range( 0 , 1)) = 0
		_NormalMap("NormalMap", 2D) = "bump" {}
		_MainTexture("MainTexture", 2D) = "white" {}
		_Occlusion("Occlusion", 2D) = "white" {}
		_SpecularColor("SpecularColor", Color) = (0,0,0,0)
		_GlossAniso("GlossAniso", Range( 0 , 0.99)) = 0.99
		_Anisotropy("Anisotropy", Range( 0 , 1)) = 0
		_AnisoRGContrast("AnisoRGContrast", Range( 0 , 1)) = 0
		_PiMultiplier("PiMultiplier", Range( 0 , 10)) = 0
		_SpecularTexture("SpecularTexture", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Off
		CGINCLUDE
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

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _MainTexture;
		uniform float4 _MainTexture_ST;
		uniform float _Anisotropy;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _AnisoRGContrast;
		uniform float _GlossAniso;
		uniform sampler2D _SpecularTexture;
		uniform float4 _SpecularTexture_ST;
		uniform float _PiMultiplier;
		uniform float4 _SpecularColor;
		uniform float _Float1;
		uniform sampler2D _Occlusion;
		uniform float4 _Occlusion_ST;


		inline float3x3 Transpose5_g132( float3 Tangent , float3 Bitangent , float3 Normal )
		{
			return transpose(float3x3(Tangent, Bitangent, Normal));
		}


		inline float3 VertexBasedViewDirection7_g144( float3 CameraPos , float3 VectorPos )
		{
			return normalize(CameraPos - VectorPos);
		}


		inline float3 VertexBasedViewDirection7_g149( float3 CameraPos , float3 VectorPos )
		{
			return normalize(CameraPos - VectorPos);
		}


		inline float RoughToSpec( half Glossiness )
		{
			return RoughnessToSpecPower(Glossiness);
		}


		inline half DNLDot7_g208( half3 Normal , half3 Light )
		{
			return max(0, dot(Normal, Light));
		}


		inline float NoramlizationSpec268( half Spec , half PI , float PIMul )
		{
			return sqrt((Spec + 1) * ((Spec) + 1)) / (8 * PI);
		}


		inline float3 FresTerm272( float DotLightHalf , float4 SpecularMap , float4 SpecularColor )
		{
			return FresnelTerm(SpecularColor.rgb * SpecularMap.rgb, DotLightHalf);
		}


		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 tex2DNode207 = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			o.Normal = tex2DNode207;
			float2 uv_MainTexture = i.uv_texcoord * _MainTexture_ST.xy + _MainTexture_ST.zw;
			o.Albedo = tex2D( _MainTexture, uv_MainTexture ).rgb;
			float3 ase_worldPos = i.worldPos;
			#if defined(LIGHTMAP_ON) && UNITY_VERSION < 560 //aseld
			float3 ase_worldlightDir = 0;
			#else //aseld
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			#endif //aseld
			float3 normalizeResult8_g142 = normalize( ase_worldlightDir );
			float3 ase_worldTangent = WorldNormalVector( i, float3( 1, 0, 0 ) );
			float3 Tangent5_g132 = ase_worldTangent;
			float3 ase_worldBitangent = WorldNormalVector( i, float3( 0, 1, 0 ) );
			float3 Bitangent5_g132 = ase_worldBitangent;
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 Normal5_g132 = ase_worldNormal;
			float3x3 localTranspose5_g132 = Transpose5_g132( Tangent5_g132 , Bitangent5_g132 , Normal5_g132 );
			float3x3 temp_output_417_0 = localTranspose5_g132;
			float3 lerpResult265 = lerp( ase_worldTangent , mul( temp_output_417_0, float3(0,1,0) ) , _Anisotropy);
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 tex2DNode311 = UnpackNormal( tex2D( _TextureSample0, uv_TextureSample0 ) );
			float4 appendResult312 = (float4(tex2DNode311.r , tex2DNode311.g , 0.0 , 0.0));
			float3 appendResult319 = (float3(float4( mul( temp_output_417_0, appendResult312.xyz ) , 0.0 ).xyz));
			float3 lerpResult322 = lerp( lerpResult265 , appendResult319 , _AnisoRGContrast);
			float3 normalizeResult323 = normalize( lerpResult322 );
			float dotResult3_g142 = dot( normalizeResult8_g142 , normalizeResult323 );
			float temp_output_1_0_g145 = dotResult3_g142;
			float3 CameraPos7_g144 = _WorldSpaceCameraPos;
			float3 VectorPos7_g144 = ase_worldPos;
			float3 localVertexBasedViewDirection7_g144 = VertexBasedViewDirection7_g144( CameraPos7_g144 , VectorPos7_g144 );
			float dotResult4_g143 = dot( localVertexBasedViewDirection7_g144 , normalizeResult323 );
			float temp_output_1_0_g146 = dotResult4_g143;
			float3 normalizeResult8_g147 = normalize( ase_worldlightDir );
			float dotResult3_g147 = dot( normalizeResult8_g147 , normalizeResult323 );
			float3 CameraPos7_g149 = _WorldSpaceCameraPos;
			float3 VectorPos7_g149 = ase_worldPos;
			float3 localVertexBasedViewDirection7_g149 = VertexBasedViewDirection7_g149( CameraPos7_g149 , VectorPos7_g149 );
			float dotResult4_g148 = dot( localVertexBasedViewDirection7_g149 , normalizeResult323 );
			float2 uv_SpecularTexture = i.uv_texcoord * _SpecularTexture_ST.xy + _SpecularTexture_ST.zw;
			float4 tex2DNode275 = tex2D( _SpecularTexture, uv_SpecularTexture );
			float Glossiness252 = ( 1.0 - ( _GlossAniso * tex2DNode275.a ) );
			float localRoughToSpec252 = RoughToSpec( Glossiness252 );
			float3 newWorldNormal480 = (WorldNormalVector( i , tex2DNode207 ));
			half3 Normal7_g208 = newWorldNormal480;
			half3 Light7_g208 = ase_worldlightDir;
			half localDNLDot7_g208 = DNLDot7_g208( Normal7_g208 , Light7_g208 );
			float Spec268 = localRoughToSpec252;
			float PI268 = ( _PiMultiplier * UNITY_PI );
			float PIMul268 = 8.0;
			float localNoramlizationSpec268 = NoramlizationSpec268( Spec268 , PI268 , PIMul268 );
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 normalizeResult4_g202 = normalize( ( ase_worldViewDir + ase_worldlightDir ) );
			float dotResult3_g199 = dot( normalizeResult4_g202 , newWorldNormal480 );
			float DotLightHalf272 = dotResult3_g199;
			float4 SpecularMap272 = _SpecularColor;
			float4 SpecularColor272 = tex2DNode275;
			float3 localFresTerm272 = FresTerm272( DotLightHalf272 , SpecularMap272 , SpecularColor272 );
			o.Specular = ( ( pow( saturate( ( ( sqrt( ( 1.0 - ( temp_output_1_0_g145 * temp_output_1_0_g145 ) ) ) * sqrt( ( 1.0 - ( temp_output_1_0_g146 * temp_output_1_0_g146 ) ) ) ) - ( dotResult3_g147 * dotResult4_g148 ) ) ) , localRoughToSpec252 ) * localDNLDot7_g208 ) * ( localNoramlizationSpec268 * localFresTerm272 * _SpecularColor.a ) );
			o.Smoothness = _Float1;
			float2 uv_Occlusion = i.uv_texcoord * _Occlusion_ST.xy + _Occlusion_ST.zw;
			o.Occlusion = tex2D( _Occlusion, uv_Occlusion ).r;
			o.Alpha = 1;
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
0;112.6667;1665;1013;391.5764;-905.8623;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;320;-636.7509,2996.769;Inherit;False;822.6075;280;W;4;311;312;307;319;worldTangent;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;318;-404.7517,2262.77;Inherit;False;591.2339;652.6913;Comment;4;316;266;265;414;Tangent;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;311;-588.7509,3044.769;Inherit;True;Property;_TextureSample0;Texture Sample 0;13;0;Create;True;0;0;False;0;-1;None;1ef8691b74704b749adc629011268a65;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;316;-356.7516,2566.77;Inherit;False;250;339.8104;hTangent;2;315;264;hTangent;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;417;-1307.697,2451.696;Inherit;False;tangentTransform;-1;;132;6f6290745523df040a2cbc0d983ff0ae;0;0;1;FLOAT3x3;0
Node;AmplifyShaderEditor.DynamicAppendNode;312;-284.7509,3076.769;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;315;-340.7517,2742.77;Inherit;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;False;0;0,1,0;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;307;-129.7509,3050.769;Inherit;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,1,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;264;-276.7517,2614.77;Inherit;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,1,0,1;False;1;FLOAT3;0,1,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;266;-356.7516,2310.77;Inherit;False;Property;_Anisotropy;Anisotropy;9;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexTangentNode;414;-292.7517,2422.77;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;310;-135.7509,3304.769;Inherit;False;Property;_AnisoRGContrast;AnisoRGContrast;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;319;19.24912,3044.769;Inherit;False;FLOAT3;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;265;-4.751748,2582.77;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;322;309.7496,2701.763;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;256;893.9995,2094.462;Inherit;False;1443.826;518.7643;DotNormalLight * pow(saturate(sqrt(1.0 - sqr(DotTangentLight)) * sqrt(1.0 - sqr(DotTangentView)) - DotTangentLight * DotTangentView), SpecPower_A) ;14;235;240;232;236;245;239;246;241;237;283;369;370;422;421;Anisotropy Main;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalizeNode;323;523.1497,2695.712;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;421;941.9995,2270.462;Inherit;False;DotTangentView;-1;;143;40b0524f6b4fe954cbb1cf427e278630;0;1;2;FLOAT3;0,0,0;False;1;FLOAT;5
Node;AmplifyShaderEditor.FunctionNode;370;941.9995,2158.462;Inherit;False;DotTangentLight;-1;;142;efed146bd6a24d54d9a585c031038266;0;1;7;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;239;1181.999,2270.462;Inherit;False;Sqr;-1;;146;bad2469aeb0972542b5c0e6d21840f32;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;235;1181.999,2158.462;Inherit;False;Sqr;-1;;145;bad2469aeb0972542b5c0e6d21840f32;0;1;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;286;1357.999,2638.462;Inherit;False;978.1947;192.7397;RoughnessToSpecPower(1.0 - _GlossAniso * SpecularMap.a) ;4;252;250;285;251;SpecPowerA;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;232;1405.999,2158.462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;240;1389.999,2254.462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;251;1405.999,2702.462;Inherit;False;Property;_GlossAniso;GlossAniso;8;0;Create;True;0;0;False;0;0.99;0.62;0;0.99;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;369;1453.999,2382.462;Inherit;False;DotTangentLight;-1;;147;efed146bd6a24d54d9a585c031038266;0;1;7;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;236;1597.999,2158.462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SqrtOpNode;241;1597.999,2254.462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;422;1456.999,2460.462;Inherit;False;DotTangentView;-1;;148;40b0524f6b4fe954cbb1cf427e278630;0;1;2;FLOAT3;0,0,0;False;1;FLOAT;5
Node;AmplifyShaderEditor.SamplerNode;275;1341.999,3358.462;Inherit;True;Property;_SpecularTexture;SpecularTexture;12;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;245;1773.999,2190.462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;285;1725.999,2702.462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;207;413.851,1173.374;Inherit;True;Property;_NormalMap;NormalMap;2;0;Create;True;0;0;False;0;-1;None;36b3b16ce3155614bb9351497328bac9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;283;1741.999,2366.462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;250;1901.999,2718.462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;270;1965.999,2894.462;Float;False;Property;_PiMultiplier;PiMultiplier;11;0;Create;True;0;0;False;0;0;8.1;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;246;1965.999,2302.462;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;480;1356.674,1399.816;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;473;1491.999,3065.462;Inherit;False;DotNormalHalf;-1;;199;d13afb3a2fd590842b2ff8eee56278ea;0;1;5;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;237;2158,2302.462;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;211;1453.999,3150.462;Inherit;False;Property;_SpecularColor;SpecularColor;7;0;Create;True;0;0;False;0;0,0,0,0;0.5849056,0.4055712,0.4055712,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;252;2094,2702.462;Inherit;False;RoughnessToSpecPower(Glossiness);1;False;1;True;Glossiness;FLOAT;0;In;;Half;False;RoughToSpec;False;False;0;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;269;2270,2894.462;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;268;2533,2780.462;Inherit;False;sqrt((Spec + 1) * ((Spec) + 1)) / (8 * PI);1;False;3;True;Spec;FLOAT;0;In;;Half;False;True;PI;FLOAT;0;In;;Half;False;True;PIMul;FLOAT;8;In;;Float;False;NoramlizationSpec;True;False;0;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;8;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;253;2430,2366.462;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;272;2174,3150.462;Inherit;False;FresnelTerm(SpecularColor.rgb * SpecularMap.rgb, DotLightHalf);3;False;3;True;DotLightHalf;FLOAT;0;In;;Float;False;True;SpecularMap;FLOAT4;0,0,0,0;In;;Float;False;True;SpecularColor;FLOAT4;0,0,0,0;In;;Float;False;FresTerm;True;False;0;3;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;479;2430,2492.462;Inherit;False;DotNormalLight;-1;;208;0beca0c251c484240ab5d7eb175319e0;0;1;5;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;337;-359.3816,982.6753;Inherit;False;382.4467;183.6522;Comment;2;335;336;Normal Direction;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;276;2958,2734.462;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;259;2910,2206.462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;481;417.3517,1373.474;Inherit;True;Property;_DetailNormalMap;DetailNormalMap;3;0;Create;True;0;0;False;0;-1;None;36b3b16ce3155614bb9351497328bac9;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;478;-1915.32,-193.4573;Inherit;True;DotNormalLight;-1;;213;0beca0c251c484240ab5d7eb175319e0;0;1;5;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;213;-840.2085,-314.835;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;191;-1597.09,547.6104;Inherit;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;288;3358,2414.462;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;209;3385.792,804.258;Inherit;False;Property;_Color0;Color 0;6;0;Create;True;0;0;False;0;0,0,0,0;0.3867924,0.1879227,0.2314254,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;324;3260.801,1550.797;Inherit;True;Property;_Occlusion;Occlusion;5;0;Create;True;0;0;False;0;-1;None;a28b6aab55df197489d0a447ae0ff6ef;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;335;-285.5942,1021.434;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3x3;0,0,0,0,0,1,1,0,1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;215;-641.4085,-231.0552;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FresnelNode;214;-1551.713,-470.9937;Inherit;False;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;336;-141.1402,1039.233;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;325;3341.737,531.7765;Inherit;True;Property;_MainTexture;MainTexture;4;0;Create;True;0;0;False;0;-1;None;1e6845b4a08e7cb458236a13e42e61ed;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;190;-972.9277,675.2114;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;187;-1820.638,47.2834;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-836.2086,-205.2344;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;227;-2131.901,300.4218;Inherit;True;DotBinormalHalf;-1;;211;33f7abe9f3f6b2540808b350e55b6fc6;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;186;-1823.638,300.2834;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;205;-1025.652,-190.4552;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;203;-2102.738,57.58339;Inherit;True;DotTangentHalf;-1;;209;1f51d2cd443f793479e7b18ad419d4ce;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexTangentNode;305;3294.402,1358.918;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;188;-1529.631,-58.51413;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;192;1594.055,1028.255;Inherit;False;Property;_Float1;Float 1;1;0;Create;True;0;0;False;0;0;0.38;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-1516.808,221.337;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;483;770.7036,1304.112;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;4269.848,1252.376;Float;False;True;-1;2;ASEMaterialInspector;0;0;StandardSpecular;hooh/ClotheReplicaOpaqueAniso;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;312;0;311;1
WireConnection;312;1;311;2
WireConnection;307;0;417;0
WireConnection;307;1;312;0
WireConnection;264;0;417;0
WireConnection;264;1;315;0
WireConnection;319;0;307;0
WireConnection;265;0;414;0
WireConnection;265;1;264;0
WireConnection;265;2;266;0
WireConnection;322;0;265;0
WireConnection;322;1;319;0
WireConnection;322;2;310;0
WireConnection;323;0;322;0
WireConnection;421;2;323;0
WireConnection;370;7;323;0
WireConnection;239;1;421;5
WireConnection;235;1;370;0
WireConnection;232;0;235;0
WireConnection;240;0;239;0
WireConnection;369;7;323;0
WireConnection;236;0;232;0
WireConnection;241;0;240;0
WireConnection;422;2;323;0
WireConnection;245;0;236;0
WireConnection;245;1;241;0
WireConnection;285;0;251;0
WireConnection;285;1;275;4
WireConnection;283;0;369;0
WireConnection;283;1;422;5
WireConnection;250;0;285;0
WireConnection;246;0;245;0
WireConnection;246;1;283;0
WireConnection;480;0;207;0
WireConnection;473;5;480;0
WireConnection;237;0;246;0
WireConnection;252;0;250;0
WireConnection;269;0;270;0
WireConnection;268;0;252;0
WireConnection;268;1;269;0
WireConnection;253;0;237;0
WireConnection;253;1;252;0
WireConnection;272;0;473;0
WireConnection;272;1;211;0
WireConnection;272;2;275;0
WireConnection;479;5;480;0
WireConnection;276;0;268;0
WireConnection;276;1;272;0
WireConnection;276;2;211;4
WireConnection;259;0;253;0
WireConnection;259;1;479;0
WireConnection;213;0;214;0
WireConnection;288;0;259;0
WireConnection;288;1;276;0
WireConnection;335;0;207;0
WireConnection;335;1;417;0
WireConnection;215;0;213;0
WireConnection;215;1;210;0
WireConnection;336;0;335;0
WireConnection;190;0;188;0
WireConnection;190;1;189;0
WireConnection;190;2;191;0
WireConnection;187;0;203;0
WireConnection;210;0;205;0
WireConnection;210;1;191;0
WireConnection;186;0;227;0
WireConnection;205;1;189;0
WireConnection;188;0;478;0
WireConnection;188;1;187;0
WireConnection;189;0;478;0
WireConnection;189;1;186;0
WireConnection;483;0;207;0
WireConnection;483;1;481;0
WireConnection;0;0;325;0
WireConnection;0;1;207;0
WireConnection;0;3;288;0
WireConnection;0;4;192;0
WireConnection;0;5;324;0
ASEEND*/
//CHKSM=0902AE33D4C5173AE9B4900EE47BF7AD4CA43D11