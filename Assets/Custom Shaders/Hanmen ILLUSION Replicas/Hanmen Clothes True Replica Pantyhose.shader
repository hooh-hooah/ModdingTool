// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hanmen/Clothes True Replica Pantyhose"
{
	Properties
	{
		[NoScaleOffset][Header(leave empty when using RendNormal)]_MainTex("MainTex", 2D) = "white" {}
		[NoScaleOffset][Header(leave empty when using RendNormal)]_ColorMask("ColorMask", 2D) = "black" {}
		[HideInInspector][NoScaleOffset]_DetailMainTex("DetailMainTex", 2D) = "white" {}
		[NoScaleOffset]_BumpMap("BumpMap", 2D) = "bump" {}
		[NoScaleOffset]_DetailMask("DetailMask", 2D) = "black" {}
		[NoScaleOffset][Header(Grayscale Bump)]_DetailGlossMap("DetailGlossMap", 2D) = "black" {}
		[NoScaleOffset][Header(Grayscale Bump)]_DetailGlossMap2("DetailGlossMap2", 2D) = "black" {}
		[NoScaleOffset][Header(Packed (Gloss Emission Metallic))]_MetallicGlossMap("MetallicGlossMap", 2D) = "white" {}
		[NoScaleOffset][Header(Packed (AO Curvature Tearings))]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		[NoScaleOffset]_WeatheringMap("WeatheringMap", 2D) = "white" {}
		[NoScaleOffset]_WeatheringMask("WeatheringMask", 2D) = "white" {}
		[HideInInspector]_AlphaMask("AlphaMask", 2D) = "white" {}
		[HideInInspector]_AlphaMask2("AlphaMask2", 2D) = "white" {}
		_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Color("Color", Color) = (1,1,1,1)
		_Color2("Color2", Color) = (1,1,1,1)
		_Color3("Color3", Color) = (1,1,1,1)
		_Color4("Color4", Color) = (1,1,1,1)
		_EmissionColor("EmissionColor", Color) = (0,0,0,1)
		_UVScalePattern("UVScalePattern", Vector) = (1,1,0,0)
		_DetailUV("DetailUV", Vector) = (1,1,0,0)
		_DetailUV2("DetailUV2", Vector) = (1,1,0,0)
		_WeatheringUV("WeatheringUV", Vector) = (1,1,0,0)
		_patternuv1("patternuv1", Vector) = (1,1,0,0)
		_patternuv2("patternuv2", Vector) = (1,1,0,0)
		_patternuv3("patternuv3", Vector) = (1,0,0,0)
		_patternuvbase("patternuvbase", Vector) = (1,1,0,0)
		_AlphaEx("AlphaEx", Range( 0 , 1)) = 1
		_BumpScale("BumpScale", Range( 0 , 3)) = 1
		_DetailNormalMapScale2("DetailNormalMapScale2", Range( -3 , 3)) = 1
		_DetailNormalMapScale("DetailNormalMapScale", Range( -3 , 3)) = 1
		_DetailUVRotator("DetailUVRotator", Range( 1 , 360)) = 1
		_DetailUVRotator2("DetailUVRotator2", Range( 1 , 360)) = 1
		_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
		_Glossiness("Glossiness", Range( 0 , 2)) = 1
		_Glossiness2("Glossiness2", Range( 0 , 2)) = 1.147624
		_Glossiness3("Glossiness3", Range( 0 , 2)) = 1
		_Glossiness4("Glossiness 4", Range( 0 , 2)) = 1
		_Metallic("Metallic", Range( 0 , 2)) = 1
		_Metallic2("Metallic2", Range( 0 , 2)) = 1
		_Metallic3("Metallic3", Range( 0 , 2)) = 1
		_Metallic4("Metallic4", Range( 0 , 2)) = 1
		_EmissionStrength("EmissionStrength", Range( 0 , 2)) = 0
		_WeatheringAll("WeatheringAll", Range( 0 , 1)) = 0
		_WeatheringRange1("WeatheringRange1", Range( 0 , 1)) = 0
		_WeatheringRange2("WeatheringRange2", Range( 0 , 1)) = 0
		_WeatheringRange3("WeatheringRange3", Range( 0 , 1)) = 0
		_WeatheringRange4("WeatheringRange4", Range( 0 , 1)) = 0
		_WeatheringRange5("WeatheringRange5", Range( 0 , 1)) = 0
		_WeatheringRange6("WeatheringRange6", Range( 0 , 1)) = 0
		[Space(30)][Header(ExtraSettings)]_FresnelPower("FresnelPower", Range( 0 , 10)) = 5
		_FresnelScale("FresnelScale", Range( 0 , 10)) = 5
		_FresnelBias("FresnelBias", Range( 0 , 1)) = 5
		_Cutoff("Cutoff", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		AlphaToMask On
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
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

		uniform float2 _WeatheringUV;
		uniform float2 _patternuv3;
		uniform float _WeatheringRange3;
		uniform sampler2D _AlphaMask;
		uniform float _WeatheringRange4;
		uniform float _WeatheringRange1;
		uniform float2 _patternuv1;
		uniform sampler2D _AlphaMask2;
		uniform float2 _UVScalePattern;
		uniform float _WeatheringRange6;
		uniform sampler2D _WeatheringMask;
		uniform sampler2D _WeatheringMap;
		uniform float _WeatheringRange5;
		uniform float _WeatheringRange2;
		uniform float2 _patternuvbase;
		uniform float2 _patternuv2;
		uniform float _WeatheringAll;
		uniform sampler2D _BumpMap;
		uniform float _BumpScale;
		uniform sampler2D _DetailGlossMap;
		uniform float2 _DetailUV;
		uniform float _DetailUVRotator;
		uniform float _DetailNormalMapScale;
		uniform sampler2D _DetailMask;
		uniform sampler2D _DetailGlossMap2;
		uniform float2 _DetailUV2;
		uniform float _DetailUVRotator2;
		uniform float _DetailNormalMapScale2;
		uniform sampler2D _MainTex;
		uniform float4 _BaseColor;
		uniform float4 _Color;
		uniform sampler2D _ColorMask;
		uniform float4 _Color2;
		uniform float4 _Color3;
		uniform float4 _Color4;
		uniform float4 _EmissionColor;
		uniform sampler2D _MetallicGlossMap;
		uniform float _EmissionStrength;
		uniform float _Metallic;
		uniform sampler2D _DetailMainTex;
		uniform float _Metallic2;
		uniform float _Metallic3;
		uniform float _Metallic4;
		uniform float _Glossiness;
		uniform float _Glossiness2;
		uniform float _Glossiness3;
		uniform float _Glossiness4;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		uniform float _FresnelBias;
		uniform float _FresnelScale;
		uniform float _FresnelPower;
		uniform float _AlphaEx;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap244 = i.uv_texcoord;
			float3 tex2DNode244 = UnpackNormal( tex2D( _BumpMap, uv_BumpMap244 ) );
			float3 appendResult247 = (float3(( tex2DNode244.r * _BumpScale ) , ( tex2DNode244.g * _BumpScale ) , 1.0));
			float2 uv_TexCoord233 = i.uv_texcoord * _DetailUV;
			float cos234 = cos( radians( _DetailUVRotator ) );
			float sin234 = sin( radians( _DetailUVRotator ) );
			float2 rotator234 = mul( uv_TexCoord233 - float2( 0.5,0.5 ) , float2x2( cos234 , -sin234 , sin234 , cos234 )) + float2( 0.5,0.5 );
			float2 temp_output_2_0_g27 = rotator234;
			float2 break6_g27 = temp_output_2_0_g27;
			float temp_output_25_0_g27 = ( pow( 0.5 , 3.0 ) * 0.1 );
			float2 appendResult8_g27 = (float2(( break6_g27.x + temp_output_25_0_g27 ) , break6_g27.y));
			float4 tex2DNode14_g27 = tex2D( _DetailGlossMap, temp_output_2_0_g27 );
			float temp_output_4_0_g27 = 2.0;
			float3 appendResult13_g27 = (float3(1.0 , 0.0 , ( ( tex2D( _DetailGlossMap, appendResult8_g27 ).g - tex2DNode14_g27.g ) * temp_output_4_0_g27 )));
			float2 appendResult9_g27 = (float2(break6_g27.x , ( break6_g27.y + temp_output_25_0_g27 )));
			float3 appendResult16_g27 = (float3(0.0 , 1.0 , ( ( tex2D( _DetailGlossMap, appendResult9_g27 ).g - tex2DNode14_g27.g ) * temp_output_4_0_g27 )));
			float3 normalizeResult22_g27 = normalize( cross( appendResult13_g27 , appendResult16_g27 ) );
			float3 break358 = normalizeResult22_g27;
			float2 uv_DetailMask21 = i.uv_texcoord;
			float4 tex2DNode21 = tex2D( _DetailMask, uv_DetailMask21 );
			float DetailMask1366 = tex2DNode21.r;
			float3 appendResult243 = (float3(( break358.x * _DetailNormalMapScale * DetailMask1366 ) , ( break358.y * _DetailNormalMapScale * DetailMask1366 ) , break358.z));
			float2 uv_TexCoord236 = i.uv_texcoord * _DetailUV2;
			float cos237 = cos( radians( _DetailUVRotator2 ) );
			float sin237 = sin( radians( _DetailUVRotator2 ) );
			float2 rotator237 = mul( uv_TexCoord236 - float2( 0.5,0.5 ) , float2x2( cos237 , -sin237 , sin237 , cos237 )) + float2( 0.5,0.5 );
			float2 temp_output_2_0_g28 = rotator237;
			float2 break6_g28 = temp_output_2_0_g28;
			float temp_output_25_0_g28 = ( pow( 0.5 , 3.0 ) * 0.1 );
			float2 appendResult8_g28 = (float2(( break6_g28.x + temp_output_25_0_g28 ) , break6_g28.y));
			float4 tex2DNode14_g28 = tex2D( _DetailGlossMap2, temp_output_2_0_g28 );
			float temp_output_4_0_g28 = 2.0;
			float3 appendResult13_g28 = (float3(1.0 , 0.0 , ( ( tex2D( _DetailGlossMap2, appendResult8_g28 ).g - tex2DNode14_g28.g ) * temp_output_4_0_g28 )));
			float2 appendResult9_g28 = (float2(break6_g28.x , ( break6_g28.y + temp_output_25_0_g28 )));
			float3 appendResult16_g28 = (float3(0.0 , 1.0 , ( ( tex2D( _DetailGlossMap2, appendResult9_g28 ).g - tex2DNode14_g28.g ) * temp_output_4_0_g28 )));
			float3 normalizeResult22_g28 = normalize( cross( appendResult13_g28 , appendResult16_g28 ) );
			float3 break365 = normalizeResult22_g28;
			float DetailMask2367 = tex2DNode21.g;
			float3 appendResult228 = (float3(( break365.x * _DetailNormalMapScale2 * DetailMask2367 ) , ( break365.y * _DetailNormalMapScale2 * DetailMask2367 ) , 1.0));
			float3 normalizeResult325 = normalize( BlendNormals( appendResult247 , BlendNormals( appendResult243 , appendResult228 ) ) );
			float3 NormalMix496 = normalizeResult325;
			o.Normal = NormalMix496;
			float2 uv_MainTex1 = i.uv_texcoord;
			float4 tex2DNode1 = tex2D( _MainTex, uv_MainTex1 );
			float4 temp_output_121_0 = ( tex2DNode1 * _BaseColor );
			float2 uv_ColorMask113 = i.uv_texcoord;
			float4 tex2DNode113 = tex2D( _ColorMask, uv_ColorMask113 );
			float ColorMask1378 = ( 1.0 - ( tex2DNode113.r + tex2DNode113.g + tex2DNode113.b ) );
			float ColorMask2375 = tex2DNode113.r;
			float ColorMask3376 = tex2DNode113.g;
			float ColorMask4377 = tex2DNode113.b;
			o.Albedo = ( ( temp_output_121_0 * _Color * ColorMask1378 ) + ( _Color2 * ColorMask2375 * temp_output_121_0 ) + ( _Color3 * ColorMask3376 * temp_output_121_0 ) + ( _Color4 * ColorMask4377 * temp_output_121_0 ) ).rgb;
			float2 uv_MetallicGlossMap15 = i.uv_texcoord;
			float4 tex2DNode15 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap15 );
			o.Emission = ( ( _EmissionColor * tex2DNode15.g ) * _EmissionStrength ).rgb;
			float2 uv_DetailMainTex343 = i.uv_texcoord;
			float4 tex2DNode343 = tex2D( _DetailMainTex, uv_DetailMainTex343 );
			float DetailMainTexR400 = tex2DNode343.r;
			o.Metallic = ( ( tex2DNode15.b * ColorMask1378 * _Metallic * DetailMainTexR400 ) + ( tex2DNode15.b * ColorMask2375 * _Metallic2 * DetailMainTexR400 ) + ( tex2DNode15.b * ColorMask3376 * _Metallic3 * DetailMainTexR400 ) + ( tex2DNode15.b * ColorMask4377 * _Metallic4 * DetailMainTexR400 ) );
			float DetailMainTexB401 = tex2DNode343.b;
			o.Smoothness = ( ( tex2DNode15.r * _Glossiness * ColorMask1378 * DetailMainTexB401 ) + ( tex2DNode15.r * _Glossiness2 * ColorMask2375 * DetailMainTexB401 ) + ( tex2DNode15.r * _Glossiness3 * ColorMask3376 * DetailMainTexB401 ) + ( tex2DNode15.r * _Glossiness4 * ColorMask4377 * DetailMainTexB401 ) );
			float2 uv_OcclusionMap23 = i.uv_texcoord;
			float4 tex2DNode23 = tex2D( _OcclusionMap, uv_OcclusionMap23 );
			float lerpResult500 = lerp( 1.0 , tex2DNode23.r , _OcclusionStrength);
			o.Occlusion = lerpResult500;
			float AlphaInput426 = tex2DNode1.a;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV479 = dot( normalize( BlendNormals( ase_worldNormal , NormalMix496 ) ), BlendNormals( ase_worldViewDir , NormalMix496 ) );
			float fresnelNode479 = ( _FresnelBias + _FresnelScale * pow( 1.0 - fresnelNdotV479, _FresnelPower ) );
			float Fresnel490 = fresnelNode479;
			float clampResult494 = clamp( ( AlphaInput426 + Fresnel490 ) , 0.0 , 1.0 );
			float TearingsMask405 = tex2DNode23.b;
			float clampResult424 = clamp( ( _AlphaEx + TearingsMask405 ) , 0.0 , 1.0 );
			float AlphaMix487 = ( clampResult494 * clampResult424 );
			o.Alpha = AlphaMix487;
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11_9x d3d11 glcore gles gles3 
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows nodynlightmap 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			AlphaToMask Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0
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
Version=18100
7;23;1906;1010;-433.64;1506.719;1.072117;True;True
Node;AmplifyShaderEditor.CommentaryNode;330;-3132.971,1451.76;Inherit;False;2110.352;1021.486;Comment;16;435;428;228;227;229;365;370;231;364;237;357;238;236;239;251;326;Detail Normal Map 2;0.03088689,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;329;-3141.216,605.681;Inherit;False;2088.792;751.3556;Comment;16;356;369;243;224;225;358;222;354;234;241;235;233;327;240;429;434;Detail Normal Map 1;1,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;251;-3017.658,1822.143;Inherit;False;Property;_DetailUVRotator2;DetailUVRotator2;35;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;326;-3082.971,1517.623;Inherit;False;Property;_DetailUV2;DetailUV2;23;0;Create;True;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;327;-3065.216,672.7898;Inherit;False;Property;_DetailUV;DetailUV;22;0;Create;True;0;0;True;0;False;1,1;32,64;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;240;-2990.272,945.848;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;34;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;238;-2768.201,1650.845;Inherit;False;Constant;_Anchor;Anchor;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;235;-2721.86,790.5479;Inherit;False;Constant;_Anchor2;Anchor2;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RadiansOpNode;241;-2684.297,950.783;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;236;-2802.972,1501.759;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;204;-4881.353,-1474.031;Inherit;False;1386.626;968.3772;Comment;4;263;261;260;21;Detail Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RadiansOpNode;239;-2731.54,1821.061;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;233;-2764.725,655.6811;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;357;-2790.116,1976.962;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;8;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Grayscale Bump);False;None;None;False;black;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;260;-3765.369,-1419.746;Inherit;False;218.3544;268.5316;Comment;1;366;;1,0,0,1;0;0
Node;AmplifyShaderEditor.TexturePropertyNode;356;-2742.264,1094.232;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;7;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Grayscale Bump);False;None;46187d176c4ae954a8c9a5a5ce7566e5;False;black;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RotatorNode;237;-2533.411,1608.201;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;261;-3772.7,-1133.787;Inherit;False;226.1978;261.4764;Comment;1;367;;0,1,0.1183066,1;0;0
Node;AmplifyShaderEditor.RotatorNode;234;-2495.165,762.1228;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;21;-4740.626,-1106.19;Inherit;True;Property;_DetailMask;DetailMask;6;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;477c22dbad6c50c41838490e8faaf7a2;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;367;-3753.599,-1092.978;Inherit;True;DetailMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;364;-2206.052,1549.189;Inherit;True;NormalCreate;0;;28;e12f7ae19d416b942820e3932b56220f;0;4;1;SAMPLER2D;;False;2;FLOAT2;0,0;False;3;FLOAT;0.5;False;4;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;366;-3754.064,-1381.816;Inherit;True;DetailMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;354;-2192.252,708.2557;Inherit;True;NormalCreate;0;;27;e12f7ae19d416b942820e3932b56220f;0;4;1;SAMPLER2D;;False;2;FLOAT2;0,0;False;3;FLOAT;0.5;False;4;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;370;-2113.34,1954.009;Inherit;True;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-2219.899,1770.328;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;32;0;Create;True;0;0;True;0;False;1;1;-3;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;328;-2766.206,-47.19342;Inherit;False;1273.336;387.5185;Comment;5;244;44;249;246;247;Main Normal Map;0.8923174,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;222;-2203.158,929.4646;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;33;0;Create;True;0;0;True;0;False;1;1;-3;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-1861.626,1040.719;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;365;-1926.879,1551.886;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;358;-1900.393,710.7295;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;227;-1558.389,1557.826;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;-1558.742,1750.702;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2693.44,225.3259;Inherit;False;Property;_BumpScale;BumpScale;31;0;Create;True;0;0;True;0;False;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;225;-1510.965,898.0957;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-1519.498,687.897;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;244;-2716.206,2.806656;Inherit;True;Property;_BumpMap;BumpMap;5;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;476d30e85df83834aa65183fdfcd8702;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;246;-2085.924,5.205173;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;495;-808.5043,315.2859;Inherit;False;777.9612;468.7095;Comment;4;325;252;374;496;Normal Mix;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-2087.542,131.3784;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;243;-1310.48,733.7949;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;228;-1344.799,1561.954;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;247;-1724.823,-1.294937;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;374;-753.5873,653.4558;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;252;-542.0186,401.5384;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;325;-313.5434,403.4502;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;496;-242.3405,641.3871;Inherit;False;NormalMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;498;1220.861,1548.963;Inherit;False;1413.653;787.6384;Comment;10;483;497;480;484;481;482;486;485;479;490;Fresnel;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;497;1302.543,2221.603;Inherit;False;496;NormalMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;480;1286.07,2021.184;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;484;1270.861,1860.13;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;481;1769.032,1809.23;Inherit;False;Property;_FresnelPower;FresnelPower;55;0;Create;True;0;0;True;2;Space(30);Header(ExtraSettings);False;5;3.17768;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;485;1647.835,1966.1;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;483;1767.602,1598.963;Inherit;False;Property;_FresnelBias;FresnelBias;57;0;Create;True;0;0;True;0;False;5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;486;1647.532,2066.868;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;167;-2989.873,-4094.182;Inherit;False;2049.302;1525.593;Comment;17;166;145;123;165;124;71;33;31;121;160;5;1;381;382;383;384;426;Diffuse Texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;482;1777.438,1717.686;Inherit;False;Property;_FresnelScale;FresnelScale;56;0;Create;True;0;0;True;0;False;5;1.41237;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;463;-213.2936,1358.782;Inherit;False;1047.792;1086.98;Comment;18;23;405;70;439;438;55;442;460;443;458;459;457;441;445;462;54;461;500;AO;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;23;-134.0945,1408.782;Inherit;True;Property;_OcclusionMap;OcclusionMap;10;1;[NoScaleOffset];Create;True;0;0;True;1;Header(Packed (AO Curvature Tearings));False;-1;None;35e60fe63a4e2f24cb477d3ae690f590;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;479;2126.365,1861.525;Inherit;False;Standard;WorldNormal;ViewDir;True;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2779.555,-4026.198;Inherit;True;Property;_MainTex;MainTex;2;1;[NoScaleOffset];Create;True;0;0;False;2;Header(leave empty when using RendNormal);;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;202;-4841.058,-2960.576;Inherit;False;1331.589;1285.219;Comment;7;180;379;276;275;277;179;113;Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;426;-2439.135,-3900.494;Inherit;False;AlphaInput;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;273;-644.0839,-4057.579;Inherit;False;1472.836;557.9236;Comment;10;487;424;494;493;421;419;43;492;406;427;Alpha;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;490;2391.516,1840.711;Inherit;True;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;113;-4754.807,-2597.038;Inherit;True;Property;_ColorMask;ColorMask;3;1;[NoScaleOffset];Create;True;0;0;False;1;Header(leave empty when using RendNormal);False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;405;562.2235,1621.638;Inherit;False;TearingsMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-4376.208,-2791.72;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;427;-598.0529,-4004.768;Inherit;False;426;AlphaInput;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;492;-304.6736,-3927.69;Inherit;True;490;Fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-612.8152,-3822.152;Inherit;False;Property;_AlphaEx;AlphaEx;29;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-606.086,-3632.065;Inherit;False;405;TearingsMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;464;-4516.315,-3812.423;Inherit;False;885.5959;359.197;Comment;3;343;400;401;RenderTexture;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;201;-2954.43,-2293.495;Inherit;False;1969.333;1946.904;MetallicGlossMap;31;88;87;37;190;199;198;107;189;188;187;155;181;15;152;200;197;196;195;194;193;192;191;154;393;394;395;396;397;398;402;403;Metallic Glossiness Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;343;-4466.315,-3736.518;Inherit;True;Property;_DetailMainTex;DetailMainTex;4;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;419;-303.5581,-3729.764;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;493;-54.53329,-4001.412;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;276;-3833.3,-2287.686;Inherit;False;234.0894;272.1377;Comment;1;376;;0,1,0.001329422,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;277;-3836.002,-1977.232;Inherit;False;233.8684;272.193;Comment;1;377;;0.2971698,0.505544,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;275;-3830.885,-2586.889;Inherit;False;237.4373;272.2484;Color Mask 2;1;375;;1,0,0,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;180;-4161.793,-2793.137;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;-2800.13,-2167.677;Inherit;True;Property;_MetallicGlossMap;MetallicGlossMap;9;1;[NoScaleOffset];Create;True;0;0;True;1;Header(Packed (Gloss Emission Metallic));False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;379;-3833.595,-2897.42;Inherit;False;249.3828;282.3601;Comment;1;378;;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;424;126.6994,-3732.877;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;401;-3892.437,-3568.226;Inherit;False;DetailMainTexB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;-3814.99,-1937.828;Inherit;True;ColorMask4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;400;-3885.719,-3762.423;Inherit;False;DetailMainTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;494;123.4086,-4000.758;Inherit;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-2749.773,-3787.989;Inherit;False;Property;_BaseColor;BaseColor;15;0;Create;True;0;0;True;0;False;1,1,1,1;0.9,0.9,0.9,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;376;-3812.231,-2245.863;Inherit;True;ColorMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;393;-2480.91,-1974.777;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;375;-3807.772,-2542.06;Inherit;True;ColorMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;378;-3807.837,-2843.669;Inherit;True;ColorMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;31;-2772.279,-3390.173;Inherit;False;Property;_Color2;Color2;17;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;70;-117.3764,1635.781;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;38;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;33;-2772.279,-3198.169;Inherit;False;Property;_Color3;Color3;18;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;190;-2775.068,-1203.417;Inherit;False;Property;_Metallic2;Metallic2;44;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;381;-2105.285,-3737.257;Inherit;True;378;ColorMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;403;-1877.192,-1115.956;Inherit;True;400;DetailMainTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;421;432.52,-3874.9;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;-1874.494,-1597.384;Inherit;True;376;ColorMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;160;-2771.626,-3002.724;Inherit;False;Property;_Color4;Color4;19;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;189;-2784.806,-1542.774;Inherit;False;Property;_Glossiness4;Glossiness 4;42;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;398;-1871.988,-1362.666;Inherit;True;377;ColorMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;402;-1889.625,-2233.16;Inherit;False;401;DetailMainTexB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;383;-2106.562,-3269.67;Inherit;True;376;ColorMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;-2775.464,-679.1926;Inherit;False;Property;_EmissionColor;EmissionColor;20;0;Create;True;0;0;True;0;False;0,0,0,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;199;-2768.251,-996.3769;Inherit;False;Property;_Metallic4;Metallic4;46;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-2112.06,-3982.454;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;188;-2785.953,-1628.63;Inherit;False;Property;_Glossiness3;Glossiness3;41;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;395;-1873.217,-2077.902;Inherit;True;378;ColorMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;396;-1882.14,-1847.292;Inherit;True;375;ColorMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;-2766.175,-3596.156;Inherit;False;Property;_Color;Color;16;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;187;-2792.047,-1719.229;Inherit;False;Property;_Glossiness2;Glossiness2;40;0;Create;True;0;0;True;0;False;1.147624;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;198;-2769.209,-1101.58;Inherit;False;Property;_Metallic3;Metallic3;45;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2777.444,-1294.588;Inherit;False;Property;_Metallic;Metallic;43;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;394;-2457.451,-750.6325;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;384;-2104.056,-3034.952;Inherit;True;377;ColorMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;382;-2109.362,-3495.347;Inherit;True;375;ColorMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-2795.964,-1796.642;Float;False;Property;_Glossiness;Glossiness;39;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1789.554,-3978.044;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;500;561.2468,1403.801;Inherit;True;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;263;-3772.066,-847.4443;Inherit;False;235.7119;285.26;Comment;1;368;;0,0.3882196,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;-1792.366,-3194.998;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-1524.763,-1420.544;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1792.323,-3456.544;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;598.1962,-3884.781;Inherit;True;AlphaMix;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-1538.475,-1860.474;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-1537.19,-2110.359;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-1540.717,-2230.109;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-1524.579,-1293.001;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-1525.334,-1159.427;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-1523.485,-1585.059;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;192;-1538.885,-1986.218;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;-2344.435,-675.7268;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2768.321,-484.223;Float;False;Property;_EmissionStrength;EmissionStrength;47;0;Create;True;0;0;True;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-1795.459,-3717.058;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;475;1885.704,-683.3562;Inherit;False;Property;_WeatheringRange6;WeatheringRange6;54;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;474;1875.704,-774.3562;Inherit;False;Property;_WeatheringRange5;WeatheringRange5;53;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;439;-110.3251,2232.717;Inherit;False;435;DetailTex2;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;499;335.4113,-2141.763;Inherit;False;496;NormalMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;194;-1287.001,-2085.711;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;443;167.0901,1808.372;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-148.5762,1802.522;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;36;0;Create;True;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;1847.227,-1650.359;Inherit;True;Property;_WeatheringMask;WeatheringMask;12;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;5523d3df4248aed43b15f14dd4ac0f53;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;24;1853.773,-1426.94;Inherit;True;Property;_WeatheringMap;WeatheringMap;11;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;6533f4eaf16e51e4d80fe4de8ebaca53;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;45;1872.353,-498.543;Inherit;False;Property;_CarvatureStrength;CarvatureStrength;30;0;Create;True;0;0;False;0;False;0.2;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;42;2215.764,-4794.006;Inherit;False;Property;_patternuvbase;patternuvbase;28;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.LerpOp;457;560.5166,1804.61;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;166;-1376.757,-3570.977;Inherit;True;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-163.2938,2147.493;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;37;0;Create;True;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;477;1504.829,-1457.864;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;2217.764,-4529.004;Inherit;False;Property;_patternuv2;patternuv2;26;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1264.782,-695.3425;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;461;279.3297,2286.242;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;459;154.9033,2142.582;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;469;1826.434,-1198.703;Inherit;False;Property;_WeatheringAll;WeatheringAll;48;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;434;-1866.367,1186.505;Inherit;False;DetailTex1;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;471;1840.704,-1033.356;Inherit;False;Property;_WeatheringRange2;WeatheringRange2;50;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;491;347.7001,-1656.677;Inherit;False;487;AlphaMix;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;-102.0271,1980.513;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;38;2403.152,-4399.412;Inherit;False;Property;_UVScalePattern;UVScalePattern;21;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;503;1297.766,-1057.502;Inherit;False;Property;_Cutoff;Cutoff;58;0;Fetch;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;476;1257.417,-1443.146;Inherit;False;Property;_WeatheringUV;WeatheringUV;24;0;Create;True;0;0;True;0;False;1,1;2,3;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;41;2217.764,-4662.005;Inherit;False;Property;_patternuv3;patternuv3;27;0;Create;False;0;0;True;0;False;1,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;438;-101.1406,1889.618;Inherit;False;434;DetailTex1;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;472;1846.704,-956.3562;Inherit;False;Property;_WeatheringRange3;WeatheringRange3;51;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;468;863.8307,1335.747;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;462;569.4986,2082.37;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;1,1,1,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;29;1641.587,-4420;Inherit;True;Property;_AlphaMask;AlphaMask;13;1;[HideInInspector];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;445;360.7942,1805.439;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;435;-1851.255,2280.167;Inherit;False;DetailTex2;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;-103.495,2330.763;Inherit;False;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;473;1878.704,-867.3562;Inherit;False;Property;_WeatheringRange4;WeatheringRange4;52;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;470;1829.704,-1117.356;Inherit;False;Property;_WeatheringRange1;WeatheringRange1;49;0;Create;True;0;0;True;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;429;-2191.244,1126.771;Inherit;True;Property;_TextureSample4;Texture Sample 4;53;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;39;2216.764,-4401.004;Inherit;False;Property;_patternuv1;patternuv1;25;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;368;-3750.79,-795.3313;Inherit;True;DetailMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;428;-2215.478,2218.77;Inherit;True;Property;_TextureSample3;Texture Sample 3;52;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;458;291.5165,1952.031;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;460;348.6075,2139.65;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;200;-1252.162,-1350.317;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;28;1640.147,-4206.926;Inherit;True;Property;_AlphaMask2;AlphaMask2;14;1;[HideInInspector];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;478;2335.822,-1525.737;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;784.4478,-2110.078;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;Hanmen/Clothes True Replica Pantyhose;False;False;False;False;False;False;False;True;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0;True;True;0;True;Transparent;2600;Transparent;All;6;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;32;1;2;True;1;True;2;5;False;-1;10;False;-1;2;5;False;-1;10;False;-1;6;False;-1;6;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;241;0;240;0
WireConnection;236;0;326;0
WireConnection;239;0;251;0
WireConnection;233;0;327;0
WireConnection;237;0;236;0
WireConnection;237;1;238;0
WireConnection;237;2;239;0
WireConnection;234;0;233;0
WireConnection;234;1;235;0
WireConnection;234;2;241;0
WireConnection;367;0;21;2
WireConnection;364;1;357;0
WireConnection;364;2;237;0
WireConnection;366;0;21;1
WireConnection;354;1;356;0
WireConnection;354;2;234;0
WireConnection;365;0;364;0
WireConnection;358;0;354;0
WireConnection;227;0;365;0
WireConnection;227;1;231;0
WireConnection;227;2;370;0
WireConnection;229;0;365;1
WireConnection;229;1;231;0
WireConnection;229;2;370;0
WireConnection;225;0;358;1
WireConnection;225;1;222;0
WireConnection;225;2;369;0
WireConnection;224;0;358;0
WireConnection;224;1;222;0
WireConnection;224;2;369;0
WireConnection;246;0;244;1
WireConnection;246;1;44;0
WireConnection;249;0;244;2
WireConnection;249;1;44;0
WireConnection;243;0;224;0
WireConnection;243;1;225;0
WireConnection;243;2;358;2
WireConnection;228;0;227;0
WireConnection;228;1;229;0
WireConnection;247;0;246;0
WireConnection;247;1;249;0
WireConnection;374;0;243;0
WireConnection;374;1;228;0
WireConnection;252;0;247;0
WireConnection;252;1;374;0
WireConnection;325;0;252;0
WireConnection;496;0;325;0
WireConnection;485;0;484;0
WireConnection;485;1;497;0
WireConnection;486;0;480;0
WireConnection;486;1;497;0
WireConnection;479;0;485;0
WireConnection;479;4;486;0
WireConnection;479;1;483;0
WireConnection;479;2;482;0
WireConnection;479;3;481;0
WireConnection;426;0;1;4
WireConnection;490;0;479;0
WireConnection;405;0;23;3
WireConnection;179;0;113;1
WireConnection;179;1;113;2
WireConnection;179;2;113;3
WireConnection;419;0;43;0
WireConnection;419;1;406;0
WireConnection;493;0;427;0
WireConnection;493;1;492;0
WireConnection;180;0;179;0
WireConnection;424;0;419;0
WireConnection;401;0;343;3
WireConnection;377;0;113;3
WireConnection;400;0;343;1
WireConnection;494;0;493;0
WireConnection;376;0;113;2
WireConnection;393;0;15;2
WireConnection;375;0;113;1
WireConnection;378;0;180;0
WireConnection;421;0;494;0
WireConnection;421;1;424;0
WireConnection;121;0;1;0
WireConnection;121;1;5;0
WireConnection;394;0;393;0
WireConnection;145;0;121;0
WireConnection;145;1;71;0
WireConnection;145;2;381;0
WireConnection;500;1;23;1
WireConnection;500;2;70;0
WireConnection;165;0;160;0
WireConnection;165;1;384;0
WireConnection;165;2;121;0
WireConnection;195;0;15;3
WireConnection;195;1;396;0
WireConnection;195;2;190;0
WireConnection;195;3;403;0
WireConnection;124;0;33;0
WireConnection;124;1;383;0
WireConnection;124;2;121;0
WireConnection;487;0;421;0
WireConnection;193;0;15;1
WireConnection;193;1;189;0
WireConnection;193;2;398;0
WireConnection;193;3;402;0
WireConnection;191;0;15;1
WireConnection;191;1;187;0
WireConnection;191;2;396;0
WireConnection;191;3;402;0
WireConnection;154;0;15;1
WireConnection;154;1;155;0
WireConnection;154;2;395;0
WireConnection;154;3;402;0
WireConnection;196;0;15;3
WireConnection;196;1;397;0
WireConnection;196;2;198;0
WireConnection;196;3;403;0
WireConnection;197;0;15;3
WireConnection;197;1;398;0
WireConnection;197;2;199;0
WireConnection;197;3;403;0
WireConnection;152;0;15;3
WireConnection;152;1;395;0
WireConnection;152;2;107;0
WireConnection;152;3;403;0
WireConnection;192;0;15;1
WireConnection;192;1;188;0
WireConnection;192;2;397;0
WireConnection;192;3;402;0
WireConnection;181;0;37;0
WireConnection;181;1;394;0
WireConnection;123;0;31;0
WireConnection;123;1;382;0
WireConnection;123;2;121;0
WireConnection;194;0;154;0
WireConnection;194;1;191;0
WireConnection;194;2;192;0
WireConnection;194;3;193;0
WireConnection;443;0;54;0
WireConnection;24;1;477;0
WireConnection;457;0;445;0
WireConnection;457;2;458;0
WireConnection;166;0;145;0
WireConnection;166;1;123;0
WireConnection;166;2;124;0
WireConnection;166;3;165;0
WireConnection;477;0;476;0
WireConnection;88;0;181;0
WireConnection;88;1;87;0
WireConnection;461;0;441;0
WireConnection;459;0;55;0
WireConnection;434;0;429;0
WireConnection;468;0;500;0
WireConnection;462;0;460;0
WireConnection;462;2;461;0
WireConnection;445;0;443;0
WireConnection;445;1;438;0
WireConnection;435;0;428;0
WireConnection;429;0;356;0
WireConnection;429;1;234;0
WireConnection;368;0;21;3
WireConnection;428;0;357;0
WireConnection;428;1;237;0
WireConnection;458;0;442;0
WireConnection;460;0;459;0
WireConnection;460;1;439;0
WireConnection;200;0;152;0
WireConnection;200;1;195;0
WireConnection;200;2;196;0
WireConnection;200;3;197;0
WireConnection;478;0;24;0
WireConnection;0;0;166;0
WireConnection;0;1;499;0
WireConnection;0;2;88;0
WireConnection;0;3;200;0
WireConnection;0;4;194;0
WireConnection;0;5;468;0
WireConnection;0;9;491;0
ASEEND*/
//CHKSM=A46521D2C70A27A71855F8422AF30D5FF0681832
