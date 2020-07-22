// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hanmen/Clothes True Replica Opaque"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
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
		_EmissionStrength("EmissionStrength", Range( 0 , 20)) = 0
		[Toggle(_EMISSIONCOLOR1_ON)] _EmissionColor1("Color1 is Emissive", Float) = 0
		[Toggle(_EMISSIONCOLOR2_ON)] _EmissionColor2("Color2 is Emissive", Float) = 0
		[Toggle(_EMISSIONCOLOR3_ON)] _EmissionColor3("Color3 is Emissive", Float) = 0
		[Header (Ambient Occlusion)]_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
		_DetailOcclusionScale("DetailOcclusionScale", Range( 0 , 1)) = 0
		_DetailOcclusionScale2("DetailOcclusionScale2", Range( 0 , 1)) = 0
		_DetailOcclusionContrast("DetailOcclusionContrast", Range( 0 , 2)) = 1
		_DetailOcclusionContrast2("DetailOcclusionContrast2", Range( 0 , 2)) = 1
		[Header (Glossiness Roughness)]_Glossiness("Glossiness", Range( 0 , 2)) = 1
		_Glossiness2("Glossiness2", Range( 0 , 2)) = 1.147624
		_Glossiness3("Glossiness3", Range( 0 , 2)) = 1
		_Glossiness4("Glossiness4", Range( 0 , 2)) = 1
		_Roughness("Roughness", Range( 0 , 1)) = 1
		_Roughness2("Roughness2", Range( 0 , 1)) = 1
		_Roughness3("Roughness3", Range( 0 , 1)) = 1
		_Roughness4("Roughness4", Range( 0 , 1)) = 1
		[Header (Metallic Maps)]_Metallic("Metallic", Range( 0 , 1)) = 1
		_Metallic2("Metallic2", Range( 0 , 1)) = 1
		_Metallic3("Metallic3", Range( 0 , 1)) = 1
		_Metallic4("Metallic4", Range( 0 , 1)) = 1
		_MetallicMask("MetallicMask", Range( 0 , 1)) = 1
		_MetallicMask2("MetallicMask2", Range( 0 , 1)) = 1
		_MetallicMask3("MetallicMask3", Range( 0 , 1)) = 1
		_MetallicMask4("MetallicMask4", Range( 0 , 1)) = 1
		[Header (Weathering (NOT WORKING))]_WeatheringAll("WeatheringAll", Range( 0 , 1)) = 0
		_WeatheringRange1("WeatheringRange1", Range( 0 , 1)) = 0
		_WeatheringRange2("WeatheringRange2", Range( 0 , 1)) = 0
		_WeatheringRange3("WeatheringRange3", Range( 0 , 1)) = 0
		_WeatheringRange4("WeatheringRange4", Range( 0 , 1)) = 0
		_WeatheringRange5("WeatheringRange5", Range( 0 , 1)) = 0
		_WeatheringRange6("WeatheringRange6", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		AlphaToMask On
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma shader_feature _EMISSIONCOLOR1_ON
		#pragma shader_feature _EMISSIONCOLOR2_ON
		#pragma shader_feature _EMISSIONCOLOR3_ON
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _WeatheringMask;
		uniform sampler2D _WeatheringMap;
		uniform float2 _patternuv3;
		uniform float _WeatheringAll;
		uniform float2 _patternuv1;
		uniform float _WeatheringRange3;
		uniform float2 _WeatheringUV;
		uniform float2 _patternuv2;
		uniform float _WeatheringRange4;
		uniform float _WeatheringRange6;
		uniform sampler2D _AlphaMask;
		uniform float2 _UVScalePattern;
		uniform float _WeatheringRange5;
		uniform float _WeatheringRange1;
		uniform sampler2D _AlphaMask2;
		uniform float _WeatheringRange2;
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
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrength;
		uniform float _Glossiness3;
		uniform float _Glossiness2;
		uniform float _Glossiness;
		uniform float _MetallicMask;
		uniform float _Metallic;
		uniform sampler2D _DetailMainTex;
		uniform float _MetallicMask2;
		uniform float _Metallic2;
		uniform float _MetallicMask3;
		uniform float _Metallic3;
		uniform float _MetallicMask4;
		uniform float _Metallic4;
		uniform float _Roughness;
		uniform float _Roughness2;
		uniform float _Roughness3;
		uniform float _Roughness4;
		uniform float _Glossiness4;
		uniform float _DetailOcclusionContrast;
		uniform float _DetailOcclusionScale;
		uniform float _DetailOcclusionContrast2;
		uniform float _DetailOcclusionScale2;
		uniform sampler2D _OcclusionMap;
		uniform float _OcclusionStrength;
		uniform float _AlphaEx;
		uniform float _Cutoff = 0.5;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap244 = i.uv_texcoord;
			float3 tex2DNode244 = UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap244 ), 2.0 );
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
			float temp_output_4_0_g27 = 1.0;
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
			float2 temp_output_2_0_g26 = rotator237;
			float2 break6_g26 = temp_output_2_0_g26;
			float temp_output_25_0_g26 = ( pow( 0.5 , 3.0 ) * 0.1 );
			float2 appendResult8_g26 = (float2(( break6_g26.x + temp_output_25_0_g26 ) , break6_g26.y));
			float4 tex2DNode14_g26 = tex2D( _DetailGlossMap2, temp_output_2_0_g26 );
			float temp_output_4_0_g26 = 2.0;
			float3 appendResult13_g26 = (float3(1.0 , 0.0 , ( ( tex2D( _DetailGlossMap2, appendResult8_g26 ).g - tex2DNode14_g26.g ) * temp_output_4_0_g26 )));
			float2 appendResult9_g26 = (float2(break6_g26.x , ( break6_g26.y + temp_output_25_0_g26 )));
			float3 appendResult16_g26 = (float3(0.0 , 1.0 , ( ( tex2D( _DetailGlossMap2, appendResult9_g26 ).g - tex2DNode14_g26.g ) * temp_output_4_0_g26 )));
			float3 normalizeResult22_g26 = normalize( cross( appendResult13_g26 , appendResult16_g26 ) );
			float3 break365 = normalizeResult22_g26;
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
			float4 DiffuseMix501 = ( ( temp_output_121_0 * _Color * ColorMask1378 ) + ( _Color2 * ColorMask2375 * temp_output_121_0 ) + ( _Color3 * ColorMask3376 * temp_output_121_0 ) + ( _Color4 * ColorMask4377 * temp_output_121_0 ) );
			o.Albedo = DiffuseMix501.rgb;
			float2 uv_MetallicGlossMap15 = i.uv_texcoord;
			float4 tex2DNode15 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap15 );
			float3 Color3565 = (_Color3).rgb;
			float Glossiness3575 = _Glossiness3;
			float3 EC3588 = ( Color3565 * (0.0 + (Glossiness3575 - 0.0) * (20.0 - 0.0) / (2.0 - 0.0)) );
			#ifdef _EMISSIONCOLOR3_ON
				float3 staticSwitch564 = EC3588;
			#else
				float3 staticSwitch564 = ( (_EmissionColor).rgb * _EmissionStrength );
			#endif
			float3 Color2598 = (_Color2).rgb;
			float Glossiness2595 = _Glossiness2;
			float3 EC2594 = ( Color2598 * (0.0 + (Glossiness2595 - 0.0) * (20.0 - 0.0) / (2.0 - 0.0)) );
			#ifdef _EMISSIONCOLOR2_ON
				float3 staticSwitch609 = EC2594;
			#else
				float3 staticSwitch609 = staticSwitch564;
			#endif
			float3 Color1600 = (_Color).rgb;
			float Glossiness1596 = _Glossiness;
			float3 EC1603 = ( Color1600 * (0.0 + (Glossiness1596 - 0.0) * (20.0 - 0.0) / (2.0 - 0.0)) );
			#ifdef _EMISSIONCOLOR1_ON
				float3 staticSwitch610 = EC1603;
			#else
				float3 staticSwitch610 = staticSwitch609;
			#endif
			float3 EmissionFinal580 = ( tex2DNode15.g * staticSwitch610 );
			o.Emission = EmissionFinal580;
			float lerpResult535 = lerp( 1.0 , tex2DNode15.b , _MetallicMask);
			float2 uv_DetailMainTex343 = i.uv_texcoord;
			float4 tex2DNode343 = tex2D( _DetailMainTex, uv_DetailMainTex343 );
			float DetailMainTexR400 = tex2DNode343.r;
			float lerpResult536 = lerp( 1.0 , tex2DNode15.b , _MetallicMask2);
			float lerpResult537 = lerp( 1.0 , tex2DNode15.b , _MetallicMask3);
			float lerpResult538 = lerp( 1.0 , tex2DNode15.b , _MetallicMask4);
			float MetallicFinal582 = ( ( lerpResult535 * ColorMask1378 * _Metallic * DetailMainTexR400 ) + ( lerpResult536 * ColorMask2375 * _Metallic2 * DetailMainTexR400 ) + ( lerpResult537 * ColorMask3376 * _Metallic3 * DetailMainTexR400 ) + ( lerpResult538 * ColorMask4377 * _Metallic4 * DetailMainTexR400 ) );
			o.Metallic = MetallicFinal582;
			float lerpResult526 = lerp( 1.0 , tex2DNode15.r , _Roughness);
			float DetailMainTexB401 = tex2DNode343.b;
			float lerpResult529 = lerp( 1.0 , tex2DNode15.r , _Roughness2);
			float lerpResult531 = lerp( 1.0 , tex2DNode15.r , _Roughness3);
			float lerpResult534 = lerp( 1.0 , tex2DNode15.r , _Roughness4);
			float GlossinessFinal584 = ( ( lerpResult526 * Glossiness1596 * ColorMask1378 * DetailMainTexB401 ) + ( lerpResult529 * Glossiness2595 * ColorMask2375 * DetailMainTexB401 ) + ( lerpResult531 * Glossiness3575 * ColorMask3376 * DetailMainTexB401 ) + ( lerpResult534 * _Glossiness4 * ColorMask4377 * DetailMainTexB401 ) );
			o.Smoothness = GlossinessFinal584;
			float3 DetailTex1434 = (tex2D( _DetailGlossMap, rotator234 )).rgb;
			float3 lerpResult457 = lerp( float3( 1,1,1 ) , DetailTex1434 , _DetailOcclusionScale);
			float3 DetailTex2435 = (tex2D( _DetailGlossMap2, rotator237 )).rgb;
			float3 lerpResult462 = lerp( float3( 1,1,1 ) , DetailTex2435 , _DetailOcclusionScale2);
			float2 uv_OcclusionMap23 = i.uv_texcoord;
			float4 tex2DNode23 = tex2D( _OcclusionMap, uv_OcclusionMap23 );
			float lerpResult519 = lerp( 1.0 , tex2DNode23.r , _OcclusionStrength);
			float3 OcclusionMix553 = ( (CalculateContrast(_DetailOcclusionContrast,float4( ( lerpResult457 * DetailMask1366 ) , 0.0 ))).rgb + (CalculateContrast(_DetailOcclusionContrast2,float4( ( lerpResult462 * DetailMask2367 ) , 0.0 ))).rgb + lerpResult519 );
			o.Occlusion = OcclusionMix553.x;
			o.Alpha = 1;
			float AlphaInput426 = tex2DNode1.a;
			float TearingsMask405 = tex2DNode23.b;
			float clampResult424 = clamp( ( _AlphaEx + TearingsMask405 ) , 0.0 , 1.0 );
			float AlphaMix487 = ( AlphaInput426 * clampResult424 );
			clip( AlphaMix487 - _Cutoff );
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11_9x d3d11 glcore gles gles3 
		#pragma surface surf Standard keepalpha fullforwardshadows 

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
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
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
				o.worldPos = worldPos;
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
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
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
Version=18100
7;29;1906;1004;87.11353;2565.304;1;True;True
Node;AmplifyShaderEditor.CommentaryNode;330;-3132.971,1451.76;Inherit;False;2110.352;1021.486;Comment;17;435;428;228;227;229;365;370;231;364;237;357;238;236;239;251;326;545;Detail Normal Map 2;0.03088689,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;329;-3141.216,605.681;Inherit;False;2088.792;751.3556;Comment;17;356;369;243;224;225;358;222;354;234;241;235;233;327;240;429;434;544;Detail Normal Map 1;1,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;167;-2989.873,-4094.182;Inherit;False;2049.302;1525.593;Comment;24;501;166;145;165;123;124;384;381;382;31;121;33;160;383;71;5;426;1;565;566;597;598;599;600;Diffuse Texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;251;-3017.658,1822.143;Inherit;False;Property;_DetailUVRotator2;DetailUVRotator2;35;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;326;-3082.971,1517.623;Inherit;False;Property;_DetailUV2;DetailUV2;24;0;Create;True;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;327;-3065.216,672.7898;Inherit;False;Property;_DetailUV;DetailUV;23;0;Create;True;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;240;-2990.272,945.848;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;34;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;201;-2963.644,-2293.495;Inherit;False;2136.406;2170.424;MetallicGlossMap;56;580;584;582;194;200;579;88;193;192;191;154;197;196;195;152;573;394;526;187;402;535;395;396;199;155;397;534;536;190;107;529;398;538;403;189;531;537;198;539;569;570;87;532;540;533;530;525;542;541;37;393;575;188;15;595;596;Metallic Glossiness Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;33;-2772.279,-3198.169;Inherit;False;Property;_Color3;Color3;19;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;235;-2721.86,790.5479;Inherit;False;Constant;_Anchor2;Anchor2;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;233;-2764.725,655.6811;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;241;-2684.297,950.783;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;204;-4881.353,-1474.031;Inherit;False;1386.626;968.3772;Comment;4;263;261;260;21;Detail Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;236;-2802.972,1501.759;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;238;-2768.201,1650.845;Inherit;False;Constant;_Anchor;Anchor;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;188;-2927.498,-1989.462;Inherit;False;Property;_Glossiness3;Glossiness3;47;0;Create;True;0;0;True;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;239;-2731.54,1821.061;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;566;-2555.071,-3148.127;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;31;-2772.279,-3390.173;Inherit;False;Property;_Color2;Color2;18;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;575;-2653.389,-1986.354;Inherit;False;Glossiness3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-4740.626,-1106.19;Inherit;True;Property;_DetailMask;DetailMask;7;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;589;345.8419,38.36653;Inherit;False;1930.029;987.407;Comment;8;574;576;578;568;588;606;608;607;EmissionColors;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;237;-2533.411,1608.201;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;356;-2742.264,1094.232;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;8;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Grayscale Bump);False;None;None;False;black;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;261;-3772.7,-1133.787;Inherit;False;226.1978;261.4764;Comment;1;367;;0,1,0.1183066,1;0;0
Node;AmplifyShaderEditor.RotatorNode;234;-2495.165,762.1228;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;187;-2926.592,-2072.061;Inherit;False;Property;_Glossiness2;Glossiness2;46;0;Create;True;0;0;True;0;False;1.147624;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;357;-2790.116,1976.962;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;9;1;[NoScaleOffset];Create;True;0;0;False;1;Header(Grayscale Bump);False;None;None;False;black;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;595;-2653.52,-2072.597;Inherit;False;Glossiness2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;565;-2332.247,-3195.802;Inherit;False;Color3;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;597;-2557.423,-3326.18;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;606;501.2444,581.7321;Inherit;False;928.3743;363.1198;Comment;5;592;590;594;593;591;;1,0,0.1222792,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;155;-2926.509,-2158.473;Float;False;Property;_Glossiness;Glossiness;45;0;Create;True;0;0;True;1;Header (Glossiness Roughness);False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;576;504.2274,292.6727;Inherit;False;575;Glossiness3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;-2766.175,-3596.156;Inherit;False;Property;_Color;Color;17;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;428;-2215.478,2218.77;Inherit;True;Property;_TextureSample3;Texture Sample 3;52;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;364;-2206.052,1549.189;Inherit;True;NormalCreate;1;;26;e12f7ae19d416b942820e3932b56220f;0;4;1;SAMPLER2D;;False;2;FLOAT2;0,0;False;3;FLOAT;0.5;False;4;FLOAT;2;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;429;-2191.244,1126.771;Inherit;True;Property;_TextureSample4;Texture Sample 4;53;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;367;-3753.599,-1092.978;Inherit;True;DetailMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;568;524.1598,206.4871;Inherit;False;565;Color3;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;599;-2545.093,-3545.898;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;608;1395.974,83.98032;Inherit;False;859.3313;401.7373;Comment;5;605;604;603;601;602;;0,0,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;598;-2341.326,-3379.462;Inherit;False;Color2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;578;724.7753,319.9471;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;592;551.2444,722.5988;Inherit;False;595;Glossiness2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;596;-2648.52,-2163.597;Inherit;False;Glossiness1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;545;-1788.794,2255.263;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;365;-1926.879,1551.886;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ComponentMaskNode;544;-1857.761,1179.643;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;202;-4841.058,-2960.576;Inherit;False;1331.589;1285.219;Comment;7;180;379;276;275;277;179;113;Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;370;-2113.34,1954.009;Inherit;True;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-2219.899,1770.328;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;32;0;Create;True;0;0;True;0;False;1;1;-3;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;260;-3765.369,-1419.746;Inherit;False;218.3544;268.5316;Comment;1;366;;1,0,0,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;605;1456.974,248.5065;Inherit;False;596;Glossiness1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;-2803.004,-703.4238;Inherit;False;Property;_EmissionColor;EmissionColor;21;0;Create;True;0;0;True;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;574;915.6779,255.5701;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;463;-187.6425,1358.782;Inherit;False;2408.946;1139;Comment;22;558;55;562;70;551;553;462;552;441;439;438;442;563;54;557;561;560;546;457;519;405;23;AO;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;227;-1558.389,1557.826;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;591;770.6227,742.8519;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;366;-3754.064,-1381.816;Inherit;True;DetailMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;229;-1558.742,1750.702;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;435;-1492.329,2185.225;Inherit;True;DetailTex2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;600;-2322.27,-3563.307;Inherit;False;Color1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;434;-1515.367,1075.505;Inherit;True;DetailTex1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;328;-2766.206,-47.19342;Inherit;False;1273.336;387.5185;Comment;5;244;44;249;246;247;Main Normal Map;0.8923174,0.5019608,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;354;-2192.252,708.2557;Inherit;True;NormalCreate;1;;27;e12f7ae19d416b942820e3932b56220f;0;4;1;SAMPLER2D;;False;2;FLOAT2;0,0;False;3;FLOAT;0.5;False;4;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;590;570.0071,631.7321;Inherit;False;598;Color2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;113;-4754.807,-2597.038;Inherit;True;Property;_ColorMask;ColorMask;4;1;[NoScaleOffset];Create;True;0;0;False;1;Header(leave empty when using RendNormal);False;-1;None;754ccdb097cef9b47b04198cbd22fb0d;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;593;961.5254,678.4749;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;569;-2589.678,-701.2971;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;588;1087.252,245.9203;Inherit;False;EC3;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCRemapNode;601;1660.416,272.7176;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;2;False;3;FLOAT;0;False;4;FLOAT;20;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;1484.546,138.9803;Inherit;False;600;Color1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2809.034,-521.8892;Float;False;Property;_EmissionStrength;EmissionStrength;36;0;Create;True;0;0;True;0;False;0;1;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;579;-2133.559,-551.0902;Inherit;False;889.9937;335.6628;If toggled Color 3 used as Emission Color and Glossiness3 as Emission Strength;6;564;612;609;613;610;611;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-1861.626,1040.719;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-140.4857,2205.84;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;42;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;358;-1900.393,710.7295;Inherit;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;222;-2203.158,929.4646;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;33;0;Create;True;0;0;True;0;False;1;1;-3;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;244;-2716.206,2.806656;Inherit;True;Property;_BumpMap;BumpMap;6;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;e04c63e7568579d4b8c90b2c7747ca66;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;2;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;464;-4516.315,-3812.423;Inherit;False;885.5959;359.197;Comment;3;343;400;401;RenderTexture;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-4376.208,-2791.72;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;-134.0945,1408.782;Inherit;True;Property;_OcclusionMap;OcclusionMap;11;1;[NoScaleOffset];Create;True;0;0;True;1;Header(Packed (AO Curvature Tearings));False;-1;None;c1ba6c3e48cae654f8ce6f85ec9fcb87;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;228;-1344.799,1561.954;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;438;166.1334,1894.097;Inherit;False;434;DetailTex1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-2693.44,225.3259;Inherit;False;Property;_BumpScale;BumpScale;31;0;Create;True;0;0;True;0;False;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;439;163.3224,2228.902;Inherit;False;435;DetailTex2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-138.8426,1732.439;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;41;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;516;-991.0792,1551.021;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;225;-1510.965,898.0957;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;379;-3833.595,-2897.42;Inherit;False;249.3828;282.3601;Comment;1;378;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;602;1896.957,183.7658;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;-2087.542,131.3784;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;224;-1519.498,687.897;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;275;-3830.885,-2586.889;Inherit;False;237.4373;272.2484;Color Mask 2;1;375;;1,0,0,1;0;0
Node;AmplifyShaderEditor.SamplerNode;343;-4466.315,-3736.518;Inherit;True;Property;_DetailMainTex;DetailMainTex;5;2;[HideInInspector];[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;180;-4161.793,-2793.137;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;273;-644.0839,-4057.579;Inherit;False;1472.836;557.9236;Comment;7;487;424;421;419;43;406;427;Alpha;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;277;-3836.002,-1977.232;Inherit;False;233.8684;272.193;Comment;1;377;;0.2971698,0.505544,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;594;1186.619,685.9801;Inherit;False;EC2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;276;-3833.3,-2287.686;Inherit;False;234.0894;272.1377;Comment;1;376;;0,1,0.001329422,1;0;0
Node;AmplifyShaderEditor.SamplerNode;15;-2809.223,-1647.203;Inherit;True;Property;_MetallicGlossMap;MetallicGlossMap;10;1;[NoScaleOffset];Create;True;0;0;True;1;Header(Packed (Gloss Emission Metallic));False;-1;None;76846f5a08423a54a91dd2bdac26658b;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;611;-2084.629,-352.2562;Inherit;False;588;EC3;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;405;372.2235,1697.638;Inherit;False;TearingsMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;573;-2344.784,-695.8885;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;161.9729,1987.513;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;156.5672,2344.415;Inherit;False;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;246;-2085.924,5.205173;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;457;567.5166,1805.61;Inherit;True;3;0;FLOAT3;1,1,1;False;1;FLOAT3;1,1,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;462;543.9326,2167.591;Inherit;True;3;0;FLOAT3;1,1,1;False;1;FLOAT3;1,1,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;-3814.99,-1937.828;Inherit;True;ColorMask4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;517;-899.0203,842.1666;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;558;-142.2109,1852.908;Inherit;False;Property;_DetailOcclusionContrast;DetailOcclusionContrast;43;0;Create;True;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;243;-1310.48,733.7949;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-612.8152,-3822.152;Inherit;False;Property;_AlphaEx;AlphaEx;30;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;378;-3807.837,-2843.669;Inherit;True;ColorMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;375;-3807.772,-2542.06;Inherit;True;ColorMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;400;-3885.719,-3762.423;Inherit;False;DetailMainTexR;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;539;-2427.657,-1427.946;Inherit;False;Property;_MetallicMask;MetallicMask;57;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;612;-1824.637,-348.5844;Inherit;False;594;EC2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;546;842.5101,1802.849;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;376;-3812.231,-2245.863;Inherit;True;ColorMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;540;-2426.857,-1259.433;Inherit;False;Property;_MetallicMask2;MetallicMask2;58;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;525;-2416.039,-2179.905;Inherit;False;Property;_Roughness;Roughness;49;0;Create;True;0;0;True;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;401;-3892.437,-3568.226;Inherit;False;DetailMainTexB;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;533;-2420.81,-1687.069;Inherit;False;Property;_Roughness4;Roughness4;52;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;530;-2418.778,-1994.546;Inherit;False;Property;_Roughness2;Roughness2;50;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;564;-2101.372,-501.1677;Inherit;False;Property;_EmissionColor3;Color3 is Emissive;39;0;Create;False;0;0;True;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;532;-2423.284,-1831.314;Inherit;False;Property;_Roughness3;Roughness3;51;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-2749.773,-3787.989;Inherit;False;Property;_BaseColor;BaseColor;16;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;247;-1724.823,-1.294937;Inherit;True;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;542;-2414.733,-949.1129;Inherit;False;Property;_MetallicMask4;MetallicMask4;60;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;603;2041.305,179.5687;Inherit;False;EC1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;495;-808.5043,315.2859;Inherit;False;952.3704;493.188;Comment;4;496;325;252;374;Normal Mix;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;552;856.9913,2172.612;Inherit;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-606.086,-3632.065;Inherit;False;405;TearingsMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;393;-2485.456,-1429.3;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1;-2779.555,-4026.198;Inherit;True;Property;_MainTex;MainTex;3;1;[NoScaleOffset];Create;True;0;0;False;2;Header(leave empty when using RendNormal);;False;-1;None;22e44a72a51040042915535f56aa22c9;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;563;-140.3335,2079.135;Inherit;False;Property;_DetailOcclusionContrast2;DetailOcclusionContrast2;44;0;Create;True;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;541;-2428.792,-1116.697;Inherit;False;Property;_MetallicMask3;MetallicMask3;59;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;609;-1823.532,-500.5037;Inherit;False;Property;_EmissionColor2;Color2 is Emissive;38;0;Create;False;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-2924.351,-1903.606;Inherit;False;Property;_Glossiness4;Glossiness4;48;0;Create;True;0;0;False;0;False;1;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;613;-1546.302,-348.2636;Inherit;False;603;EC1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-2112.06,-3982.454;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;536;-2072.402,-1407.293;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;402;-1889.625,-2233.16;Inherit;False;401;DetailMainTexB;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;518;-885.2112,407.1882;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;526;-2096.885,-2248.489;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;381;-2105.285,-3737.257;Inherit;True;378;ColorMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;557;1091.969,1769.232;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;1.5;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;382;-2109.362,-3495.347;Inherit;True;375;ColorMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;426;-2439.135,-3900.494;Inherit;False;AlphaInput;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;384;-2104.056,-3034.952;Inherit;True;377;ColorMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;160;-2771.626,-3002.724;Inherit;False;Property;_Color4;Color4;20;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;190;-2775.068,-1203.417;Inherit;False;Property;_Metallic2;Metallic2;54;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;419;-303.5581,-3729.764;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-138.1737,1635.781;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;40;0;Create;True;0;0;False;1;Header (Ambient Occlusion);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;538;-2073.394,-1030.691;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;383;-2106.562,-3269.67;Inherit;True;376;ColorMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;374;-753.5873,653.4558;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;535;-2077.14,-1577.426;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;199;-2768.251,-996.3769;Inherit;False;Property;_Metallic4;Metallic4;56;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;396;-1882.14,-1847.292;Inherit;False;375;ColorMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-2777.444,-1294.588;Inherit;False;Property;_Metallic;Metallic;53;0;Create;True;0;0;True;1;Header (Metallic Maps);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;537;-2070.756,-1221.003;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;397;-1886.275,-1643.037;Inherit;False;376;ColorMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;534;-2088.544,-1780.956;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;395;-1873.217,-2077.902;Inherit;False;378;ColorMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;403;-1875.719,-1118.902;Inherit;False;400;DetailMainTexR;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;529;-2088.399,-2095.385;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;198;-2769.209,-1101.58;Inherit;False;Property;_Metallic3;Metallic3;55;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;562;1108.492,2077.805;Inherit;True;2;1;COLOR;0,0,0,0;False;0;FLOAT;1.5;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;570;-2482.364,-884.5425;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;531;-2087.74,-1921.009;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;398;-1870.515,-1320.486;Inherit;False;377;ColorMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;152;-1523.485,-1585.059;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;519;503.267,1416.304;Inherit;True;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;-1524.763,-1420.544;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;-1540.717,-2241.605;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;196;-1523.106,-1231.149;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;427;-598.0529,-4004.768;Inherit;False;426;AlphaInput;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-1789.554,-3978.044;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1792.323,-3456.544;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;561;1369.13,2094.325;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;560;1352.13,1840.325;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;123;-1795.459,-3717.058;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;424;126.6994,-3732.877;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;252;-542.0186,401.5384;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;193;-1532.088,-1796.607;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;191;-1537.19,-2092.476;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;192;-1532.498,-1945.343;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;197;-1523.861,-1035.722;Inherit;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;165;-1792.366,-3194.998;Inherit;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;610;-1532.286,-502.9876;Inherit;False;Property;_EmissionColor1;Color1 is Emissive;37;0;Create;False;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;394;-2426.74,-810.3003;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;166;-1450.212,-3583.22;Inherit;False;4;4;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;200;-1252.162,-1350.317;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;325;-313.5434,403.4502;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1267.753,-821.6897;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;421;432.52,-3874.9;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;194;-1287.001,-2085.711;Inherit;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;551;1662.332,1434.332;Inherit;True;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;501;-1242.855,-3586.344;Inherit;True;DiffuseMix;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;263;-3772.066,-847.4443;Inherit;False;235.7119;285.26;Comment;1;368;;0,0.3882196,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;582;-1038.75,-1245.407;Inherit;False;MetallicFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;584;-1073.739,-2040.422;Inherit;False;GlossinessFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;580;-1051.142,-509.2245;Inherit;False;EmissionFinal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;496;-77.11081,399.6619;Inherit;True;NormalMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;553;1968.335,1432.296;Inherit;False;OcclusionMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;598.1962,-3884.781;Inherit;True;AlphaMix;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;368;-3750.79,-795.3313;Inherit;True;DetailMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;469;1826.434,-1198.703;Inherit;False;Property;_WeatheringAll;WeatheringAll;61;0;Create;True;0;0;True;2;Header (Weathering (NOT WORKING));;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;554;300.4991,-1668.844;Inherit;False;553;OcclusionMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;42;1981.764,-4550.382;Inherit;False;Property;_patternuvbase;patternuvbase;29;0;Fetch;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;477;1504.829,-1457.864;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;491;327.9237,-1580.348;Inherit;False;487;AlphaMix;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;476;1257.417,-1443.146;Inherit;False;Property;_WeatheringUV;WeatheringUV;25;0;Create;True;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;40;1983.764,-4287.004;Inherit;False;Property;_patternuv2;patternuv2;27;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;473;1878.704,-867.3562;Inherit;False;Property;_WeatheringRange4;WeatheringRange4;65;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;475;1885.704,-683.3562;Inherit;False;Property;_WeatheringRange6;WeatheringRange6;67;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;29;1642.587,-4420;Inherit;True;Property;_AlphaMask;AlphaMask;14;1;[HideInInspector];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;38;2169.152,-4157.412;Inherit;False;Property;_UVScalePattern;UVScalePattern;22;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;474;1875.704,-774.3562;Inherit;False;Property;_WeatheringRange5;WeatheringRange5;66;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;1847.227,-1650.359;Inherit;True;Property;_WeatheringMask;WeatheringMask;13;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;470;1829.704,-1117.356;Inherit;False;Property;_WeatheringRange1;WeatheringRange1;62;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;28;1640.147,-4206.926;Inherit;True;Property;_AlphaMask2;AlphaMask2;15;1;[HideInInspector];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;471;1840.704,-1033.356;Inherit;False;Property;_WeatheringRange2;WeatheringRange2;63;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;472;1846.704,-956.3562;Inherit;False;Property;_WeatheringRange3;WeatheringRange3;64;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;499;301.0743,-2001.078;Inherit;False;496;NormalMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;39;1982.764,-4159.004;Inherit;False;Property;_patternuv1;patternuv1;26;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;581;291.1351,-1910.903;Inherit;False;580;EmissionFinal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RelayNode;478;2335.822,-1525.737;Inherit;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;586;282.2704,-1745.719;Inherit;False;584;GlossinessFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;583;298.2496,-1826.407;Inherit;False;582;MetallicFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;1853.773,-1426.94;Inherit;True;Property;_WeatheringMap;WeatheringMap;12;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;41;1983.764,-4420.005;Inherit;False;Property;_patternuv3;patternuv3;28;0;Create;False;0;0;True;0;False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;515;299.9669,-2090.145;Inherit;False;501;DiffuseMix;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;784.4478,-2110.078;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;Hanmen/Clothes True Replica Opaque;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;2600;AlphaTest;All;6;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;32;1;2;True;1;True;0;5;False;-1;10;False;-1;0;5;False;-1;10;False;-1;6;False;-1;6;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;True;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;607;454.2274,156.4871;Inherit;False;876.0251;365.46;Comment;0;;0,1,0.03845549,1;0;0
WireConnection;233;0;327;0
WireConnection;241;0;240;0
WireConnection;236;0;326;0
WireConnection;239;0;251;0
WireConnection;566;0;33;0
WireConnection;575;0;188;0
WireConnection;237;0;236;0
WireConnection;237;1;238;0
WireConnection;237;2;239;0
WireConnection;234;0;233;0
WireConnection;234;1;235;0
WireConnection;234;2;241;0
WireConnection;595;0;187;0
WireConnection;565;0;566;0
WireConnection;597;0;31;0
WireConnection;428;0;357;0
WireConnection;428;1;237;0
WireConnection;364;1;357;0
WireConnection;364;2;237;0
WireConnection;429;0;356;0
WireConnection;429;1;234;0
WireConnection;367;0;21;2
WireConnection;599;0;71;0
WireConnection;598;0;597;0
WireConnection;578;0;576;0
WireConnection;596;0;155;0
WireConnection;545;0;428;0
WireConnection;365;0;364;0
WireConnection;544;0;429;0
WireConnection;574;0;568;0
WireConnection;574;1;578;0
WireConnection;227;0;365;0
WireConnection;227;1;231;0
WireConnection;227;2;370;0
WireConnection;591;0;592;0
WireConnection;366;0;21;1
WireConnection;229;0;365;1
WireConnection;229;1;231;0
WireConnection;229;2;370;0
WireConnection;435;0;545;0
WireConnection;600;0;599;0
WireConnection;434;0;544;0
WireConnection;354;1;356;0
WireConnection;354;2;234;0
WireConnection;593;0;590;0
WireConnection;593;1;591;0
WireConnection;569;0;37;0
WireConnection;588;0;574;0
WireConnection;601;0;605;0
WireConnection;358;0;354;0
WireConnection;179;0;113;1
WireConnection;179;1;113;2
WireConnection;179;2;113;3
WireConnection;228;0;227;0
WireConnection;228;1;229;0
WireConnection;516;0;228;0
WireConnection;225;0;358;1
WireConnection;225;1;222;0
WireConnection;225;2;369;0
WireConnection;602;0;604;0
WireConnection;602;1;601;0
WireConnection;249;0;244;2
WireConnection;249;1;44;0
WireConnection;224;0;358;0
WireConnection;224;1;222;0
WireConnection;224;2;369;0
WireConnection;180;0;179;0
WireConnection;594;0;593;0
WireConnection;405;0;23;3
WireConnection;573;0;569;0
WireConnection;573;1;87;0
WireConnection;246;0;244;1
WireConnection;246;1;44;0
WireConnection;457;1;438;0
WireConnection;457;2;54;0
WireConnection;462;1;439;0
WireConnection;462;2;55;0
WireConnection;377;0;113;3
WireConnection;517;0;516;0
WireConnection;243;0;224;0
WireConnection;243;1;225;0
WireConnection;243;2;358;2
WireConnection;378;0;180;0
WireConnection;375;0;113;1
WireConnection;400;0;343;1
WireConnection;546;0;457;0
WireConnection;546;1;442;0
WireConnection;376;0;113;2
WireConnection;401;0;343;3
WireConnection;564;1;573;0
WireConnection;564;0;611;0
WireConnection;247;0;246;0
WireConnection;247;1;249;0
WireConnection;603;0;602;0
WireConnection;552;0;462;0
WireConnection;552;1;441;0
WireConnection;393;0;15;2
WireConnection;609;1;564;0
WireConnection;609;0;612;0
WireConnection;121;0;1;0
WireConnection;121;1;5;0
WireConnection;536;1;15;3
WireConnection;536;2;540;0
WireConnection;518;0;247;0
WireConnection;526;1;15;1
WireConnection;526;2;525;0
WireConnection;557;1;546;0
WireConnection;557;0;558;0
WireConnection;426;0;1;4
WireConnection;419;0;43;0
WireConnection;419;1;406;0
WireConnection;538;1;15;3
WireConnection;538;2;542;0
WireConnection;374;0;243;0
WireConnection;374;1;517;0
WireConnection;535;1;15;3
WireConnection;535;2;539;0
WireConnection;537;1;15;3
WireConnection;537;2;541;0
WireConnection;534;1;15;1
WireConnection;534;2;533;0
WireConnection;529;1;15;1
WireConnection;529;2;530;0
WireConnection;562;1;552;0
WireConnection;562;0;563;0
WireConnection;570;0;393;0
WireConnection;531;1;15;1
WireConnection;531;2;532;0
WireConnection;152;0;535;0
WireConnection;152;1;395;0
WireConnection;152;2;107;0
WireConnection;152;3;403;0
WireConnection;519;1;23;1
WireConnection;519;2;70;0
WireConnection;195;0;536;0
WireConnection;195;1;396;0
WireConnection;195;2;190;0
WireConnection;195;3;403;0
WireConnection;154;0;526;0
WireConnection;154;1;596;0
WireConnection;154;2;395;0
WireConnection;154;3;402;0
WireConnection;196;0;537;0
WireConnection;196;1;397;0
WireConnection;196;2;198;0
WireConnection;196;3;403;0
WireConnection;145;0;121;0
WireConnection;145;1;71;0
WireConnection;145;2;381;0
WireConnection;124;0;33;0
WireConnection;124;1;383;0
WireConnection;124;2;121;0
WireConnection;561;0;562;0
WireConnection;560;0;557;0
WireConnection;123;0;31;0
WireConnection;123;1;382;0
WireConnection;123;2;121;0
WireConnection;424;0;419;0
WireConnection;252;0;518;0
WireConnection;252;1;374;0
WireConnection;193;0;534;0
WireConnection;193;1;189;0
WireConnection;193;2;398;0
WireConnection;193;3;402;0
WireConnection;191;0;529;0
WireConnection;191;1;595;0
WireConnection;191;2;396;0
WireConnection;191;3;402;0
WireConnection;192;0;531;0
WireConnection;192;1;575;0
WireConnection;192;2;397;0
WireConnection;192;3;402;0
WireConnection;197;0;538;0
WireConnection;197;1;398;0
WireConnection;197;2;199;0
WireConnection;197;3;403;0
WireConnection;165;0;160;0
WireConnection;165;1;384;0
WireConnection;165;2;121;0
WireConnection;610;1;609;0
WireConnection;610;0;613;0
WireConnection;394;0;570;0
WireConnection;166;0;145;0
WireConnection;166;1;123;0
WireConnection;166;2;124;0
WireConnection;166;3;165;0
WireConnection;200;0;152;0
WireConnection;200;1;195;0
WireConnection;200;2;196;0
WireConnection;200;3;197;0
WireConnection;325;0;252;0
WireConnection;88;0;394;0
WireConnection;88;1;610;0
WireConnection;421;0;427;0
WireConnection;421;1;424;0
WireConnection;194;0;154;0
WireConnection;194;1;191;0
WireConnection;194;2;192;0
WireConnection;194;3;193;0
WireConnection;551;0;560;0
WireConnection;551;1;561;0
WireConnection;551;2;519;0
WireConnection;501;0;166;0
WireConnection;582;0;200;0
WireConnection;584;0;194;0
WireConnection;580;0;88;0
WireConnection;496;0;325;0
WireConnection;553;0;551;0
WireConnection;487;0;421;0
WireConnection;368;0;21;3
WireConnection;477;0;476;0
WireConnection;478;0;24;0
WireConnection;24;1;477;0
WireConnection;0;0;515;0
WireConnection;0;1;499;0
WireConnection;0;2;581;0
WireConnection;0;3;583;0
WireConnection;0;4;586;0
WireConnection;0;5;554;0
WireConnection;0;10;491;0
ASEEND*/
//CHKSM=17E310466D7E52713FD1217FCE6C93A04012DA3A
