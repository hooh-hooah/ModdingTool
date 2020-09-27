// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hanmen/Clothes True Transparent"
{
	Properties
	{
		[NoScaleOffset][Header(Render Texture (leave empty))]_MainTex("MainTex", 2D) = "white" {}
		[NoScaleOffset][Header (Render Texture (leave empty))]_DetailMainTex("DetailMainTex", 2D) = "gray" {}
		[NoScaleOffset][Header (Optional (Required for Color 4))]_ColorMask("ColorMask", 2D) = "black" {}
		[NoScaleOffset]_BumpMap("BumpMap", 2D) = "bump" {}
		[NoScaleOffset][Header (R_Detail1 G_Detail2)]_DetailMask("DetailMask", 2D) = "black" {}
		[NoScaleOffset][Header (Detail1)]_DetailGlossMap("DetailGlossMap", 2D) = "gray" {}
		[NoScaleOffset][Header (Detail2)]_DetailGlossMap2("DetailGlossMap2", 2D) = "gray" {}
		[NoScaleOffset][Header(Packed (R_Gloss G_Emission B_MetallicMask))]_MetallicGlossMap("MetallicGlossMap", 2D) = "white" {}
		[NoScaleOffset][Header(Packed (R_AO G_none B_Tearings))]_OcclusionMap("OcclusionMap", 2D) = "white" {}
		[NoScaleOffset]_WeatheringMap("WeatheringMap", 2D) = "black" {}
		[NoScaleOffset]_WeatheringMask("WeatheringMask", 2D) = "black" {}
		[NoScaleOffset][Header (Packed (R_Glossiness G_Bump))]_WetnessMap("WetnessMap", 2D) = "black" {}
		[Header (Colors)]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Color("Color", Color) = (1,1,1,1)
		_EmissionColor("EmissionColor", Color) = (0,0,0,1)
		_WeatheringAlbedo("WeatheringAlbedo", Color) = (0.6,0.65,0.65,0)
		[Header (UV Coordinates)]_UVScalePattern("UVScalePattern", Vector) = (1,1,0,0)
		_DetailUV("DetailUV", Vector) = (1,1,0,0)
		_DetailUV2("DetailUV2", Vector) = (1,1,0,0)
		_DetailUVRotator("DetailUVRotator", Range( 1 , 360)) = 1
		_DetailUVRotator2("DetailUVRotator2", Range( 1 , 360)) = 1
		_WeatheringUV("WeatheringUV", Vector) = (1,1,0,0)
		_patternuv1("patternuv1", Vector) = (1,1,0,0)
		_patternuv2("patternuv2", Vector) = (1,1,0,0)
		_patternuv3("patternuv3", Vector) = (1,0,0,0)
		_patternuvbase("patternuvbase", Vector) = (1,1,0,0)
		[Header (Cloth Tearings)]_AlphaEx("AlphaEx", Range( 0 , 1)) = 1
		[Header (Wetness)]_ExGloss("ExGloss", Range( 0 , 1)) = 0
		_WetnessPower("WetnessPower", Range( 0 , 2)) = 0
		_WetnessPower2("WetnessPower2", Range( 0 , 2)) = 0
		[Header (Bump)]_BumpScale("BumpScale", Range( 0 , 3)) = 1
		_DetailNormalMapScale("DetailNormalMapScale", Range( -3 , 9)) = 1
		_DetailNormalMapScale2("DetailNormalMapScale2", Range( -3 , 9)) = 1
		[Header (Emission (Tex Required))]_EmissionStrength("EmissionStrength", Range( 0 , 20)) = 0
		[Header (Color Mask Required (Optional))][Toggle(_EMISSIONCOLOR1_ON)] _EmissionColor1("Color1 is Emissive", Float) = 0
		[Toggle(_EMISSIONCOLOR2_ON)] _EmissionColor2("Color2 is Emissive", Float) = 0
		[Toggle(_EMISSIONCOLOR3_ON)] _EmissionColor3("Color3 is Emissive", Float) = 0
		[Header (Ambient Occlusion)]_OcclusionStrength("OcclusionStrength", Range( 0 , 1)) = 1
		[Toggle(_DETAILOCCLUSION_ON)] _DetailOcclusion("DetailOcclusion", Float) = 0
		_DetailOcclusionScale("DetailOcclusionScale", Range( 0 , 1)) = 0
		_DetailOcclusionScale2("DetailOcclusionScale2", Range( 0 , 1)) = 0
		_DetailOcclusionContrast2("DetailOcclusionContrast2", Range( 0 , 2)) = 0
		_DetailOcclusionContrast("DetailOcclusionContrast", Range( 0 , 2)) = 0
		[Header (Metallic Roughness (Optional))]_Roughness("Roughness", Range( 0 , 1)) = 1
		_MetallicMask("MetallicMask", Range( 0 , 1)) = 1
		[Header (Color 4 Settings (Optional))]_Glossiness4("Glossiness4", Range( 0 , 1)) = 1
		_Roughness4("Roughness4", Range( 0 , 1)) = 1
		_Metallic4("Metallic4", Range( 0 , 1)) = 1
		_MetallicMask4("MetallicMask4", Range( 0 , 1)) = 1
		[Header (Weathering)]_WeatheringAll("WeatheringAll", Range( 0 , 1)) = 0
		_WeatheringRange1("WeatheringRange1", Range( 0 , 1)) = 0
		_WeatheringRange2("WeatheringRange2", Range( 0 , 1)) = 0
		_WeatheringRange3("WeatheringRange3", Range( 0 , 1)) = 0
		_WeatheringRange4("WeatheringRange4", Range( 0 , 1)) = 0
		_WeatheringRange5("WeatheringRange5", Range( 0 , 1)) = 0
		_WeatheringGloss("WeatheringGloss", Range( 0 , 2)) = 0.8
		_WeatheringBump("WeatheringBump", Range( 0 , 2)) = 0.4
		_WeatheringBumpPower("WeatheringBumpPower", Range( 0 , 9)) = 2
		[Header (Alpha masking Occlusion_A Mask (Optional))][Toggle(_ENABLEALPHAMASK_ON)] _EnableAlphaMask("EnableAlphaMask", Float) = 0
		[Space(30)][Header (Fresnel Settings)][Toggle(_ALPHAFRESNEL_ON)] _AlphaFresnel("AlphaFresnel", Float) = 0
		[Space(30)]_FresnelPower1("FresnelPower", Range( 0 , 10)) = 5
		_FresnelBias1("FresnelBias", Range( 0 , 1)) = 5
		_FresnelScale1("FresnelScale", Range( 0 , 10)) = 5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 5.0
		#pragma shader_feature _EMISSIONCOLOR1_ON
		#pragma shader_feature _EMISSIONCOLOR2_ON
		#pragma shader_feature _EMISSIONCOLOR3_ON
		#pragma shader_feature _DETAILOCCLUSION_ON
		#pragma shader_feature _ENABLEALPHAMASK_ON
		#pragma shader_feature _ALPHAFRESNEL_ON
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

		uniform sampler2D _DetailMask;
		uniform sampler2D _MetallicGlossMap;
		uniform float2 _patternuv2;
		uniform sampler2D _DetailMainTex;
		uniform float2 _patternuv1;
		uniform sampler2D _WeatheringMap;
		uniform sampler2D _OcclusionMap;
		uniform sampler2D _WetnessMap;
		uniform float2 _patternuv3;
		uniform sampler2D _BumpMap;
		uniform sampler2D _MainTex;
		uniform sampler2D _DetailGlossMap2;
		uniform sampler2D _DetailGlossMap;
		uniform float2 _UVScalePattern;
		uniform sampler2D _ColorMask;
		uniform sampler2D _WeatheringMask;
		uniform float _BumpScale;
		uniform float2 _DetailUV;
		uniform float _DetailUVRotator;
		uniform float _DetailNormalMapScale;
		uniform float2 _DetailUV2;
		uniform float _DetailUVRotator2;
		uniform float _DetailNormalMapScale2;
		uniform float _ExGloss;
		uniform float4 _WeatheringUV;
		uniform float _WeatheringBump;
		uniform float _WeatheringBumpPower;
		uniform float _WeatheringRange1;
		uniform float _WeatheringRange2;
		uniform float _WeatheringRange3;
		uniform float _WeatheringRange4;
		uniform float _WeatheringRange5;
		uniform float _WeatheringAll;
		uniform float4 _BaseColor;
		uniform float4 _Color;
		uniform float4 _WeatheringAlbedo;
		uniform float4 _EmissionColor;
		uniform float _EmissionStrength;
		uniform float _MetallicMask;
		uniform float _MetallicMask4;
		uniform float _Metallic4;
		uniform float _WetnessPower2;
		uniform float _WetnessPower;
		uniform float _Roughness;
		uniform float _Glossiness4;
		uniform float _Roughness4;
		uniform float _WeatheringGloss;
		uniform float _OcclusionStrength;
		uniform float _DetailOcclusionContrast;
		uniform float _DetailOcclusionScale;
		uniform float _DetailOcclusionContrast2;
		uniform float _DetailOcclusionScale2;
		uniform float _FresnelBias1;
		uniform float _FresnelScale1;
		uniform float _FresnelPower1;
		uniform float _AlphaEx;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMap1179 = i.uv_texcoord;
			float2 uv_TexCoord233 = i.uv_texcoord * _DetailUV;
			float cos234 = cos( radians( _DetailUVRotator ) );
			float sin234 = sin( radians( _DetailUVRotator ) );
			float2 rotator234 = mul( uv_TexCoord233 - float2( 0.5,0.5 ) , float2x2( cos234 , -sin234 , sin234 , cos234 )) + float2( 0.5,0.5 );
			float2 Detail1UV785 = rotator234;
			float2 break753 = Detail1UV785;
			float temp_output_747_0 = ( pow( 0.5 , 3.0 ) * 0.1 );
			float2 appendResult756 = (float2(( break753.x + temp_output_747_0 ) , break753.y));
			float4 tex2DNode743 = tex2D( _DetailGlossMap, Detail1UV785 );
			float2 uv_DetailMask1182 = i.uv_texcoord;
			float4 tex2DNode1182 = tex2D( _DetailMask, uv_DetailMask1182 );
			float DetailMask1366 = tex2DNode1182.r;
			float temp_output_733_0 = ( DetailMask1366 * 2.0 * _DetailNormalMapScale );
			float3 appendResult745 = (float3(1.0 , 0.0 , ( ( tex2D( _DetailGlossMap, appendResult756 ).g - tex2DNode743.g ) * temp_output_733_0 )));
			float2 appendResult748 = (float2(break753.x , ( break753.y + temp_output_747_0 )));
			float3 appendResult752 = (float3(0.0 , 1.0 , ( ( tex2D( _DetailGlossMap, appendResult748 ).g - tex2DNode743.g ) * temp_output_733_0 )));
			float3 normalizeResult755 = normalize( cross( appendResult745 , appendResult752 ) );
			float3 DetailNormal1836 = normalizeResult755;
			float2 uv_TexCoord236 = i.uv_texcoord * _DetailUV2;
			float cos237 = cos( radians( _DetailUVRotator2 ) );
			float sin237 = sin( radians( _DetailUVRotator2 ) );
			float2 rotator237 = mul( uv_TexCoord236 - float2( 0.5,0.5 ) , float2x2( cos237 , -sin237 , sin237 , cos237 )) + float2( 0.5,0.5 );
			float2 Detail2UV786 = rotator237;
			float2 break763 = Detail2UV786;
			float temp_output_762_0 = ( pow( 0.5 , 3.0 ) * 0.1 );
			float2 appendResult767 = (float2(( break763.x + temp_output_762_0 ) , break763.y));
			float4 tex2DNode770 = tex2D( _DetailGlossMap2, Detail2UV786 );
			float DetailMask2367 = tex2DNode1182.g;
			float temp_output_734_0 = ( DetailMask2367 * 2.0 * _DetailNormalMapScale2 );
			float3 appendResult776 = (float3(1.0 , 0.0 , ( ( tex2D( _DetailGlossMap2, appendResult767 ).g - tex2DNode770.g ) * temp_output_734_0 )));
			float2 appendResult766 = (float2(break763.x , ( break763.y + temp_output_762_0 )));
			float3 appendResult775 = (float3(0.0 , 1.0 , ( ( tex2D( _DetailGlossMap2, appendResult766 ).g - tex2DNode770.g ) * temp_output_734_0 )));
			float3 normalizeResult778 = normalize( cross( appendResult776 , appendResult775 ) );
			float3 DetailNormal2837 = normalizeResult778;
			float2 break849 = i.uv_texcoord;
			float temp_output_850_0 = ( pow( 0.2 , 3.0 ) * 0.1 );
			float2 appendResult853 = (float2(( break849.x + temp_output_850_0 ) , break849.y));
			float4 tex2DNode859 = tex2D( _WetnessMap, i.uv_texcoord );
			float3 appendResult866 = (float3(1.0 , 0.0 , ( ( tex2D( _WetnessMap, appendResult853 ).g - tex2DNode859.g ) * 1.0 )));
			float2 appendResult854 = (float2(break849.x , ( break849.y + temp_output_850_0 )));
			float3 appendResult865 = (float3(0.0 , 1.0 , ( ( tex2D( _WetnessMap, appendResult854 ).g - tex2DNode859.g ) * 1.0 )));
			float3 normalizeResult868 = normalize( cross( appendResult866 , appendResult865 ) );
			float3 WetnessNormal869 = normalizeResult868;
			float2 uv_WetnessMap1184 = i.uv_texcoord;
			float4 tex2DNode1184 = tex2D( _WetnessMap, uv_WetnessMap1184 );
			float WetnessAlpha874 = tex2DNode1184.g;
			float ExGloss877 = _ExGloss;
			float3 lerpResult871 = lerp( BlendNormals( BlendNormals( UnpackScaleNormal( tex2D( _BumpMap, uv_BumpMap1179 ), _BumpScale ) , DetailNormal1836 ) , DetailNormal2837 ) , WetnessNormal869 , ( WetnessAlpha874 * ExGloss877 ));
			float2 appendResult1190 = (float2(_WeatheringUV.x , _WeatheringUV.y));
			float2 appendResult1191 = (float2(_WeatheringUV.z , _WeatheringUV.w));
			float2 uv_TexCoord906 = i.uv_texcoord * appendResult1190 + ( appendResult1191 / float2( 100,100 ) );
			float2 WeatheringUV907 = uv_TexCoord906;
			float2 break1030 = WeatheringUV907;
			float temp_output_1029_0 = ( pow( _WeatheringBump , 3.5 ) * 0.1 );
			float2 appendResult1033 = (float2(( break1030.x + temp_output_1029_0 ) , break1030.y));
			float4 tex2DNode1035 = tex2D( _WeatheringMap, WeatheringUV907 );
			float3 appendResult1043 = (float3(1.0 , 0.0 , ( ( tex2D( _WeatheringMap, appendResult1033 ).b - tex2DNode1035.b ) * _WeatheringBumpPower )));
			float2 appendResult1034 = (float2(break1030.x , ( break1030.y + temp_output_1029_0 )));
			float3 appendResult1044 = (float3(0.0 , 1.0 , ( ( tex2D( _WeatheringMap, appendResult1034 ).b - tex2DNode1035.b ) * _WeatheringBumpPower )));
			float3 normalizeResult1046 = normalize( cross( appendResult1043 , appendResult1044 ) );
			float3 WeatheringBump1047 = normalizeResult1046;
			float4 tex2DNode916 = tex2D( _WeatheringMap, WeatheringUV907 );
			float2 uv_WeatheringMask912 = i.uv_texcoord;
			float4 tex2DNode912 = tex2D( _WeatheringMask, uv_WeatheringMask912 );
			float clampResult968 = clamp( ( tex2DNode912.r - tex2DNode912.g ) , 0.0 , 1.0 );
			float WMask11006 = ( clampResult968 * ceil( _WeatheringRange1 ) );
			float RangeCut1974 = (( _WeatheringRange1 >= 0.51 && _WeatheringRange1 <= 1.0 ) ? 0.3 :  0.45 );
			float clampResult1066 = clamp( ( ( tex2DNode916.g * WMask11006 ) - RangeCut1974 ) , 0.0 , 1.0 );
			float clampResult969 = clamp( ( tex2DNode912.g - tex2DNode912.r ) , 0.0 , 1.0 );
			float WMask21007 = ( clampResult969 * ceil( _WeatheringRange2 ) );
			float RangeCut2976 = (( _WeatheringRange2 >= 0.51 && _WeatheringRange2 <= 1.0 ) ? 0.3 :  0.45 );
			float clampResult1061 = clamp( ( ( tex2DNode916.g * WMask21007 ) - RangeCut2976 ) , 0.0 , 1.0 );
			float WMask31008 = ( tex2DNode912.b * ceil( _WeatheringRange3 ) );
			float RangeCut3980 = (( _WeatheringRange3 >= 0.51 && _WeatheringRange3 <= 1.0 ) ? 0.3 :  0.45 );
			float clampResult1062 = clamp( ( ( tex2DNode916.g * WMask31008 ) - RangeCut3980 ) , 0.0 , 1.0 );
			float WMask41009 = ( ( tex2DNode912.r * tex2DNode912.g ) * ceil( _WeatheringRange4 ) );
			float RangeCut4981 = (( _WeatheringRange4 >= 0.51 && _WeatheringRange4 <= 1.0 ) ? 0.3 :  0.45 );
			float clampResult1063 = clamp( ( ( tex2DNode916.g * WMask41009 ) - RangeCut4981 ) , 0.0 , 1.0 );
			float WMask51010 = ( ( tex2DNode912.r * tex2DNode912.b ) * ceil( _WeatheringRange5 ) );
			float RangeCut5982 = (( _WeatheringRange5 >= 0.51 && _WeatheringRange5 <= 1.0 ) ? 0.3 :  0.45 );
			float clampResult1064 = clamp( ( ( tex2DNode916.g * WMask51010 ) - RangeCut5982 ) , 0.0 , 1.0 );
			float WMaskAll1021 = ceil( _WeatheringAll );
			float RangeCutAll984 = (( _WeatheringAll >= 0.51 && _WeatheringAll <= 1.0 ) ? 0.3 :  0.45 );
			float clampResult1065 = clamp( ( ( tex2DNode916.g * WMaskAll1021 ) - RangeCutAll984 ) , 0.0 , 1.0 );
			float clampResult1068 = clamp( ( clampResult1066 + clampResult1061 + clampResult1062 + clampResult1063 + clampResult1064 + clampResult1065 ) , 0.0 , 1.0 );
			float lerpResult1069 = lerp( clampResult1068 , clampResult1065 , WMaskAll1021);
			float clampResult1169 = clamp( ( lerpResult1069 * 10.0 ) , 0.0 , 1.0 );
			float WeatheringAlpha932 = clampResult1169;
			float3 lerpResult1052 = lerp( lerpResult871 , WeatheringBump1047 , ( tex2D( _WeatheringMap, WeatheringUV907 ).b * WeatheringAlpha932 ));
			float3 NormalMix496 = lerpResult1052;
			o.Normal = NormalMix496;
			float2 uv_MainTex1185 = i.uv_texcoord;
			float4 tex2DNode1185 = tex2D( _MainTex, uv_MainTex1185 );
			float3 temp_output_658_0 = (tex2DNode1185).rgb;
			float WeatheringAlpha2922 = lerpResult1069;
			float3 lerpResult1057 = lerp( ( temp_output_658_0 * (_BaseColor).rgb * (_Color).rgb ) , (_WeatheringAlbedo).rgb , ( WeatheringAlpha2922 * 0.282353 ));
			float3 DiffuseMix501 = lerpResult1057;
			o.Albedo = DiffuseMix501;
			float2 uv_MetallicGlossMap15 = i.uv_texcoord;
			float4 tex2DNode15 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap15 );
			float3 ColorTex817 = temp_output_658_0;
			float2 uv_ColorMask1183 = i.uv_texcoord;
			float4 tex2DNode1183 = tex2D( _ColorMask, uv_ColorMask1183 );
			float ColorMask3376 = tex2DNode1183.g;
			float3 EC3588 = ( ColorTex817 * ( _EmissionStrength * ColorMask3376 ) );
			#ifdef _EMISSIONCOLOR3_ON
				float3 staticSwitch564 = EC3588;
			#else
				float3 staticSwitch564 = ( (_EmissionColor).rgb * _EmissionStrength );
			#endif
			float ColorMask2375 = tex2DNode1183.r;
			float3 EC2594 = ( ColorTex817 * ( _EmissionStrength * ColorMask2375 ) );
			#ifdef _EMISSIONCOLOR2_ON
				float3 staticSwitch609 = EC2594;
			#else
				float3 staticSwitch609 = staticSwitch564;
			#endif
			float ColorMask1378 = ( 1.0 - ( tex2DNode1183.r + tex2DNode1183.g + tex2DNode1183.b ) );
			float3 EC1603 = ( ColorTex817 * ( _EmissionStrength * ColorMask1378 ) );
			#ifdef _EMISSIONCOLOR1_ON
				float3 staticSwitch610 = EC1603;
			#else
				float3 staticSwitch610 = staticSwitch609;
			#endif
			float3 EmissionFinal580 = ( tex2DNode15.g * staticSwitch610 );
			o.Emission = EmissionFinal580;
			float lerpResult827 = lerp( 1.0 , tex2DNode15.b , _MetallicMask);
			float2 uv_DetailMainTex343 = i.uv_texcoord;
			float4 tex2DNode343 = tex2D( _DetailMainTex, uv_DetailMainTex343 );
			float lerpResult645 = lerp( 1.0 , tex2DNode15.b , _MetallicMask4);
			float ColorMask4377 = tex2DNode1183.b;
			float lerpResult806 = lerp( ( lerpResult827 * tex2DNode343.r ) , ( lerpResult645 * _Metallic4 ) , ColorMask4377);
			float WetnessGloss832 = tex2DNode1184.r;
			float clampResult885 = clamp( ( WetnessGloss832 + WetnessAlpha874 ) , 0.0 , 1.0 );
			float WetMet891 = ( clampResult885 * _WetnessPower2 );
			float clampResult888 = clamp( ( lerpResult806 + WetMet891 ) , 0.0 , 1.0 );
			float lerpResult899 = lerp( lerpResult806 , clampResult888 , ExGloss877);
			float lerpResult1173 = lerp( lerpResult899 , 0.0 , WeatheringAlpha2922);
			float MetallicFinal636 = lerpResult1173;
			o.Metallic = MetallicFinal636;
			float WetGloss889 = ( clampResult885 * _WetnessPower );
			float lerpResult828 = lerp( 1.0 , tex2DNode15.r , _Roughness);
			float lerpResult534 = lerp( 1.0 , tex2DNode15.r , _Roughness4);
			float lerpResult808 = lerp( ( lerpResult828 * tex2DNode343.b ) , ( _Glossiness4 * lerpResult534 ) , ColorMask4377);
			float blendOpSrc898 = WetGloss889;
			float blendOpDest898 = lerpResult808;
			float lerpBlendMode898 = lerp(blendOpDest898,( 1.0 - ( 1.0 - blendOpSrc898 ) * ( 1.0 - blendOpDest898 ) ),ExGloss877);
			float lerpResult1129 = lerp( ( saturate( lerpBlendMode898 )) , _WeatheringGloss , WeatheringAlpha932);
			float GlossinessFinal584 = lerpResult1129;
			o.Smoothness = GlossinessFinal584;
			float2 uv_OcclusionMap1178 = i.uv_texcoord;
			float4 tex2DNode1178 = tex2D( _OcclusionMap, uv_OcclusionMap1178 );
			float lerpResult519 = lerp( 1.0 , tex2DNode1178.r , _OcclusionStrength);
			float grayscale782 = Luminance(CalculateContrast(_DetailOcclusionContrast,tex2D( _DetailGlossMap, Detail1UV785 )).rgb);
			float lerpResult457 = lerp( 1.0 , grayscale782 , ( _DetailOcclusionScale * DetailMask1366 ));
			float grayscale783 = Luminance(CalculateContrast(_DetailOcclusionContrast2,tex2D( _DetailGlossMap2, Detail2UV786 )).rgb);
			float lerpResult462 = lerp( 1.0 , grayscale783 , ( _DetailOcclusionScale2 * DetailMask2367 ));
			#ifdef _DETAILOCCLUSION_ON
				float staticSwitch799 = ( ( lerpResult519 - ( 1.0 - lerpResult457 ) ) - ( 1.0 - lerpResult462 ) );
			#else
				float staticSwitch799 = lerpResult519;
			#endif
			float OcclusionMix553 = staticSwitch799;
			o.Occlusion = OcclusionMix553;
			float AlphaInput426 = tex2DNode1185.a;
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV1207 = dot( BlendNormals( ase_worldNormal , NormalMix496 ), BlendNormals( ase_worldViewDir , NormalMix496 ) );
			float fresnelNode1207 = ( _FresnelBias1 + _FresnelScale1 * pow( 1.0 - fresnelNdotV1207, _FresnelPower1 ) );
			float clampResult1208 = clamp( fresnelNode1207 , 0.0 , 1.0 );
			float Fresnel1209 = clampResult1208;
			float lerpResult1212 = lerp( AlphaInput426 , 1.0 , Fresnel1209);
			#ifdef _ALPHAFRESNEL_ON
				float staticSwitch1210 = lerpResult1212;
			#else
				float staticSwitch1210 = AlphaInput426;
			#endif
			float AlphaMask1194 = tex2DNode1178.a;
			float lerpResult1196 = lerp( staticSwitch1210 , 1.0 , AlphaMask1194);
			#ifdef _ENABLEALPHAMASK_ON
				float staticSwitch1197 = lerpResult1196;
			#else
				float staticSwitch1197 = staticSwitch1210;
			#endif
			float lerpResult1186 = lerp( staticSwitch1197 , 1.0 , ( staticSwitch1197 * WeatheringAlpha2922 ));
			float TearingsMask405 = tex2DNode1178.b;
			float temp_output_705_0 = ( 1.0 - _AlphaEx );
			clip( TearingsMask405 - temp_output_705_0);
			float lerpResult701 = lerp( lerpResult1186 , lerpResult1186 , temp_output_705_0);
			float AlphaMix487 = lerpResult701;
			o.Alpha = AlphaMix487;
		}

		ENDCG
		CGPROGRAM
		#pragma only_renderers d3d9 d3d11_9x d3d11 glcore gles gles3 
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
			#pragma target 5.0
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
Version=18301
147;147;1906;760;1888.147;4997.229;1.648119;True;True
Node;AmplifyShaderEditor.CommentaryNode;902;-6189.102,-4400.301;Inherit;False;2977.313;4995.033;Comment;123;932;1169;1168;922;1069;1068;1167;1127;1067;1162;1160;1117;1066;1062;1061;1152;1063;1064;1116;998;993;929;988;1003;1161;928;992;997;996;1163;1065;985;1001;986;991;987;1002;976;1119;982;1011;974;1018;1013;1014;980;981;1012;925;977;978;919;1009;1010;979;975;1006;1016;1017;1007;1008;984;955;956;954;916;923;1022;957;1083;1084;1081;1021;1079;915;983;1082;1146;472;1144;471;942;1150;474;470;935;1147;1164;473;1145;1080;1108;940;937;1107;948;1139;1138;469;1101;1109;1093;1140;1105;934;1094;1102;1112;1137;1136;1135;1148;1149;1141;1142;1143;936;1132;1134;1133;901;912;1025;Weathering;0.9607843,1,0.6196079,1;0;0
Node;AmplifyShaderEditor.SamplerNode;912;-5690.557,-4247.434;Inherit;True;Property;_TextureSample16;Texture Sample 16;10;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;25;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;901;-5973.925,-1267.361;Inherit;False;1340.87;335.2312;Comment;6;907;906;1192;1190;1191;1189;WeatheringUV;0.9856402,1,0,1;0;0
Node;AmplifyShaderEditor.RelayNode;1133;-4936.03,-4198.469;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1134;-5064.925,-4174.865;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1132;-4805.315,-4223.884;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1189;-5926.035,-1197.139;Inherit;False;Property;_WeatheringUV;WeatheringUV;21;0;Create;True;0;0;True;0;False;1,1,0,0;5,5,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;329;-3165.211,2761.059;Inherit;False;3235.085;1139.023;Comment;29;755;751;745;752;757;749;754;758;733;742;369;750;743;222;748;756;741;744;747;753;785;746;234;233;235;241;327;240;836;Detail Normal Map 1;1,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;1148;-4927.148,-4106.068;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1149;-4929.865,-4097.917;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1191;-5701.035,-1073.14;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;936;-5257.675,-4121.672;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1141;-4812.409,-4111.876;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1142;-4683.982,-4133.239;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1143;-4697.567,-4131.88;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1094;-4690.018,-3419.371;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;934;-5254.223,-4292.422;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;240;-2987.291,3203.865;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;19;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1137;-4926.624,-3783.71;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1112;-5100.471,-4081.009;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1102;-4934.447,-3386.091;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1192;-5497.672,-1071.979;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;100,100;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;330;-3159.167,4119.344;Inherit;False;3206.373;1317.682;Comment;29;778;777;776;775;774;773;771;734;772;231;769;770;768;370;767;766;765;764;763;762;761;786;237;236;238;239;326;251;837;Detail Normal Map 2;0.03088689,1,0,1;0;0
Node;AmplifyShaderEditor.Vector2Node;327;-3062.235,2930.808;Inherit;False;Property;_DetailUV;DetailUV;17;0;Create;True;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;1136;-4679.087,-3631.991;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1135;-4812.615,-3599.618;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1190;-5702.035,-1196.139;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1138;-4911.967,-3752.073;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;469;-5912.037,-3134.209;Inherit;False;Property;_WeatheringAll;WeatheringAll;49;0;Create;True;0;0;True;2;Header (Weathering);;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;241;-2681.319,3208.8;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;251;-3006.258,4567.135;Inherit;False;Property;_DetailUVRotator2;DetailUVRotator2;20;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;235;-2718.881,3048.565;Inherit;False;Constant;_Anchor2;Anchor2;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;1101;-4923.379,-3352.153;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1139;-4799.781,-3563.253;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1093;-4676.871,-3381.026;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1109;-4721.759,-4256.774;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;233;-2761.745,2913.699;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;326;-3071.57,4262.615;Inherit;False;Property;_DetailUV2;DetailUV2;18;0;Create;True;0;0;True;0;False;1,1;64,64;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.WireNode;1140;-4668.738,-3592.245;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1105;-4979.119,-3964.319;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;906;-5210.104,-1219.534;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;5,0.9;False;1;FLOAT2;0.2,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RadiansOpNode;239;-2720.142,4566.054;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;470;-5917.989,-4023.543;Inherit;False;Property;_WeatheringRange1;WeatheringRange1;50;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;471;-5912.647,-3855.196;Inherit;False;Property;_WeatheringRange2;WeatheringRange2;51;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1147;-4872.809,-3343.966;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1144;-4635.076,-3570.831;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;474;-5913.521,-3308.836;Inherit;False;Property;_WeatheringRange5;WeatheringRange5;54;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;935;-4572.825,-4242.037;Inherit;False;226;183;Range 1: Front-Top;1;968;;1,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;1150;-4876.941,-3743.208;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;472;-5912.544,-3694.043;Inherit;False;Property;_WeatheringRange3;WeatheringRange3;52;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1146;-4636.435,-3368.419;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;942;-4555.222,-3660.053;Inherit;False;204;183;Range 4: Back-Bottom;1;972;;0.9433962,0.8983464,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1164;-5913.251,-3006.681;Inherit;False;Constant;_Float0;Float 0;61;0;Create;True;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;236;-2791.574,4246.75;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1108;-4686.094,-4243.899;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;238;-2756.803,4395.838;Inherit;False;Constant;_Anchor;Anchor;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.CommentaryNode;940;-4560.161,-3832.185;Inherit;False;204;160;Range 3: Back-Top;1;939;;0,0.4918175,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;473;-5906.739,-3492.329;Inherit;False;Property;_WeatheringRange4;WeatheringRange4;53;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;234;-2447.82,2951.124;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;937;-4568.016,-4034.871;Inherit;False;224;183;Range 2: Front-Bottom;1;969;;0,1,0.1001263,1;0;0
Node;AmplifyShaderEditor.WireNode;1107;-4953.404,-3957.838;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1145;-4760.056,-3547.738;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;948;-4549.582,-3455.975;Inherit;False;204;183;Range 5: Arms;1;973;;1,0,0.7995195,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;907;-4894.955,-1184.033;Inherit;False;WeatheringUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;1080;-4203.304,-3119.612;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1084;-4204.56,-4016.127;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1081;-4208.83,-3479.908;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;237;-2522.011,4353.193;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1021;-3808.902,-3126.329;Inherit;False;WMaskAll;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1079;-4211.913,-3297.106;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1083;-4204.916,-3842.475;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;973;-4502.581,-3396.725;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;972;-4510.618,-3598.484;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;969;-4518.665,-3988.886;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1082;-4206.729,-3686.792;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;968;-4522.665,-4200.886;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;785;-2253.117,2946.207;Inherit;False;Detail1UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;983;-5463.214,-3064.637;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;915;-6038.556,-2722.648;Inherit;False;907;WeatheringUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode;746;-2221.043,3635.467;Inherit;False;False;2;0;FLOAT;0.5;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;939;-4510.161,-3770.554;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;954;-4017.986,-3988.974;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;753;-2134.583,3530.912;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RegisterLocalVarNode;984;-5210.627,-2988.815;Inherit;False;RangeCutAll;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;955;-4015.541,-3778.957;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1025;-5986.94,-642.2927;Inherit;False;2647.625;920.0429;Comment;22;1047;1046;1045;1044;1043;1042;1041;1040;1039;1038;1037;1036;1035;1034;1033;1032;1031;1030;1029;1028;1027;1026;Weathering to Normal;0.9621782,1,0.6196079,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;840;-6095.334,2861.151;Inherit;False;2735.525;1180.599;Comment;20;869;868;867;865;866;863;864;860;862;856;859;858;853;854;851;852;850;849;848;844;Wetness Bump;0,0.7945042,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;204;-5118.487,4413.108;Inherit;False;1295.923;836.1025;Comment;3;260;261;1182;Detail Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;761;-2252.761,5044.097;Inherit;False;False;2;0;FLOAT;0.5;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;786;-2321.545,4351.415;Inherit;False;Detail2UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;957;-4016.163,-3394.513;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;747;-2039.256,3644.093;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;923;-4020.733,-4197.731;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1022;-5638.622,-1649.555;Inherit;False;1021;WMaskAll;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;916;-5683.729,-2745.258;Inherit;True;Property;_TextureSample17;Texture Sample 17;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;956;-4021.942,-3600.05;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1010;-3812.462,-3401.641;Inherit;False;WMask5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1182;-4990.336,4746.607;Inherit;True;Property;_TextureSample12;Texture Sample 12;4;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;21;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1026;-5932.651,109.4873;Inherit;False;Property;_WeatheringBump;WeatheringBump;56;0;Create;True;0;0;True;0;False;0.4;0.4;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;762;-2070.975,5052.723;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1009;-3814.314,-3610.611;Inherit;False;WMask4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;977;-5460.374,-3605.26;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;744;-1819.232,3528.092;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1007;-3811.034,-3997.8;Inherit;False;WMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;919;-5458.99,-3983.25;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;848;-5659.777,3785.905;Inherit;False;False;2;0;FLOAT;0.2;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;260;-4081.863,4527.862;Inherit;False;218.3544;268.5316;Comment;1;366;;1,0,0,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;763;-2166.301,4939.543;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TFHCCompareWithRange;978;-5462.975,-3425.849;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1017;-5280.779,-1634.346;Inherit;False;984;RangeCutAll;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;741;-1829.777,3673.248;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1008;-3812.068,-3788.262;Inherit;False;WMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;979;-5461.485,-3246.698;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;975;-5461.128,-3796.598;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1006;-3810.234,-4206.938;Inherit;False;WMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1016;-5284.106,-1744.42;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;844;-5846.453,3106.429;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;1027;-5632.875,115.2812;Inherit;False;False;2;0;FLOAT;0.43;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1018;-5063.913,-1741.396;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;974;-5212.799,-3901.804;Inherit;False;RangeCut1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1011;-5651.68,-2305.757;Inherit;False;1007;WMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;764;-1861.495,5081.878;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;982;-5214.512,-3177.733;Inherit;False;RangeCut5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;748;-1686.643,3651.629;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1119;-5283.083,-1493.319;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;756;-1666.428,3525.531;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;366;-4070.558,4565.792;Inherit;True;DetailMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;976;-5220.325,-3726.341;Inherit;False;RangeCut2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1012;-5652.68,-2204.757;Inherit;False;1008;WMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;980;-5222.167,-3543.083;Inherit;False;RangeCut3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;981;-5223.966,-3365.726;Inherit;False;RangeCut4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;261;-4080.611,4830.985;Inherit;False;226.1978;261.4764;Comment;1;367;;0,1,0.1183066,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;925;-5649.226,-2405.291;Inherit;False;1006;WMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1028;-5790.45,-563.9885;Inherit;False;907;WeatheringUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1014;-5652.68,-2008.758;Inherit;False;1010;WMask5;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;849;-5573.317,3681.351;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.ScaleNode;850;-5477.992,3794.532;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;765;-1850.95,4936.724;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1013;-5652.68,-2106.758;Inherit;False;1009;WMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;985;-5279.794,-2636.423;Inherit;False;974;RangeCut1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;997;-5279.513,-2040.141;Inherit;False;981;RangeCut4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1163;-5239.486,-1474.635;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;996;-5282.839,-2150.215;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;222;-2880.408,3504.121;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;31;0;Create;True;0;0;True;0;False;1;1;-3;9;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;928;-5283.121,-2746.496;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1065;-4843.236,-1745.563;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;852;-5268.514,3823.687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;992;-5277.816,-2236.819;Inherit;False;980;RangeCut3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;1029;-5451.086,124.9082;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;742;-1471.023,3215.953;Inherit;True;Property;_TextureSample6;Texture Sample 6;5;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1001;-5285.144,-1951.389;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;367;-4061.511,4871.795;Inherit;True;DetailMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;851;-5257.968,3678.532;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;986;-5277.086,-2549.975;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1002;-5281.817,-1841.315;Inherit;False;982;RangeCut5;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;987;-5273.758,-2439.902;Inherit;False;976;RangeCut2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;766;-1718.361,5060.259;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;767;-1698.146,4934.162;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;743;-1463.982,2926.891;Inherit;True;Property;_TextureSample5;Texture Sample 5;5;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;750;-1476.67,3453.447;Inherit;True;Property;_TextureSample7;Texture Sample 7;5;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;369;-2805.588,3414.167;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;991;-5281.142,-2346.893;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1030;-5546.415,11.72999;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;769;-1502.741,4624.584;Inherit;True;Property;_TextureSample4;Texture Sample 4;6;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1032;-5241.606,154.0647;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1116;-4286.344,-1481.745;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;733;-2529.016,3433.029;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;853;-5105.164,3675.97;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;770;-1495.7,4335.522;Inherit;True;Property;_NormalCreate01;NormalCreate 01;6;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;993;-5060.948,-2343.869;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;758;-1125.918,3400.47;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;854;-5125.379,3802.067;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;370;-2987.45,4888.088;Inherit;False;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1003;-5064.949,-1948.364;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;768;-1508.388,4862.078;Inherit;True;Property;_TextureSample8;Texture Sample 8;6;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1161;-4325.493,-1718.983;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;231;-3043.468,5020.184;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;32;0;Create;True;0;0;True;0;False;1;1;-3;9;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1031;-5231.063,8.909676;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;988;-5056.892,-2546.952;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;754;-1119.737,3167.636;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;929;-5062.927,-2743.473;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;998;-5062.646,-2147.192;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1034;-5098.474,132.4443;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;1061;-4839.585,-2543.821;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;749;-928.1171,3214.346;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1064;-4851.817,-1946.141;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;757;-943.8752,3357.582;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;771;-1157.636,4809.102;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1062;-4840.02,-2338.734;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;859;-4902.717,3077.329;Inherit;True;Property;_TextureSample11;Texture Sample 11;11;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1117;-4244.306,-1506.348;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1033;-5078.259,6.349617;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;734;-2703.336,4891.011;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;858;-4909.758,3366.391;Inherit;True;Property;_TextureSample10;Texture Sample 10;11;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1066;-4844.404,-2743.667;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;772;-1151.455,4576.268;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;856;-4915.403,3603.886;Inherit;True;Property;_TextureSample9;Texture Sample 9;11;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1063;-4847.002,-2146.881;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1152;-4274.182,-1731.547;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;860;-4558.473,3318.075;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;862;-4564.652,3550.909;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;752;-718.707,3393.894;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;773;-959.8351,4622.978;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1036;-4888.501,-65.73523;Inherit;True;Property;_TextureSample21;Texture Sample 21;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;745;-745.622,3165.121;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;1160;-4222.93,-1559.135;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;774;-975.5932,4766.213;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1035;-4906.929,-585.4694;Inherit;True;Property;_TextureSample28;Texture Sample 28;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1162;-4256.96,-1775.766;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1037;-4898.854,-305.2291;Inherit;True;Property;_TextureSample19;Texture Sample 19;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1067;-4506.258,-2741.268;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;864;-4366.853,3364.785;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;863;-4382.61,3508.021;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;776;-777.3399,4573.752;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;1068;-4352.871,-2740.393;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1167;-4204.192,-2638.275;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;775;-750.425,4802.525;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1039;-4531.566,-351.5474;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1040;-4562.014,-226.4625;Inherit;False;Property;_WeatheringBumpPower;WeatheringBumpPower;57;0;Create;True;0;0;True;0;False;2;2;0;9;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1038;-4537.75,-118.7132;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1127;-4227.811,-2599.046;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;751;-584.4581,3267.156;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1042;-4266.111,-115.2269;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1041;-4268.717,-324.0542;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;866;-4184.356,3315.559;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;495;290.4105,2849.293;Inherit;False;2436.961;983.8583;Comment;18;44;496;1052;871;1051;1053;1050;872;875;1049;374;876;1048;252;839;873;838;1179;Normal Mix;0.8967471,0.5424528,1,1;0;0
Node;AmplifyShaderEditor.CrossProductOpNode;777;-616.1771,4675.787;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1069;-4163.667,-2739.902;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;755;-424.7832,3284.703;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;893;-8078.064,-2458.818;Inherit;False;1601.13;481.772;Comment;13;832;885;834;835;880;881;891;889;884;874;728;877;1184;Wetness;0.01415092,0.7101932,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;865;-4157.441,3544.333;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1043;-4086.219,-357.5362;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;867;-4023.194,3417.595;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;44;433.2136,2942.091;Inherit;False;Property;_BumpScale;BumpScale;30;0;Create;True;0;0;True;2;Header (Bump);;False;1;1;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1168;-3931.793,-2739.466;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;728;-8028.063,-2161.204;Inherit;False;Property;_ExGloss;ExGloss;27;0;Create;True;0;0;True;1;Header (Wetness);False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1184;-8038.901,-2394.864;Inherit;True;Property;_TextureSample14;Texture Sample 14;11;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NormalizeNode;778;-456.5022,4693.334;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1044;-4059.306,-128.7643;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;836;-194.6561,3263.052;Inherit;True;DetailNormal1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;874;-7580.56,-2309.695;Inherit;False;WetnessAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;1045;-3925.058,-255.5001;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;868;-3863.519,3435.141;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;877;-7706.171,-2168.442;Inherit;False;ExGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1179;800.6705,2909.453;Inherit;True;Property;_TextureSample3;Texture Sample 3;3;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;244;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;838;1180.098,3100.182;Inherit;False;836;DetailNormal1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;1169;-3773.548,-2738.696;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;837;-223.1501,4689.553;Inherit;True;DetailNormal2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;869;-3630.165,3431.361;Inherit;True;WetnessNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;932;-3558.909,-2742.154;Inherit;False;WeatheringAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;252;1382.573,2913.577;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1046;-3753.38,-252.9542;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;876;1566.492,3346.727;Inherit;False;877;ExGloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;839;1474.267,3110.294;Inherit;False;837;DetailNormal2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;873;1512.703,3233.499;Inherit;False;874;WetnessAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1048;1177.9,3514.207;Inherit;False;907;WeatheringUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BlendNormalsNode;374;1699.389,2916.168;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1049;1863.792,3672.108;Inherit;False;932;WeatheringAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1050;1437.015,3494.834;Inherit;True;Property;_TextureSample18;Texture Sample 18;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;875;1819.492,3233.727;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;872;1728.751,3111.391;Inherit;False;869;WetnessNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1047;-3594.773,-255.5382;Inherit;False;WeatheringBump;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1053;1994.895,3110.046;Inherit;False;1047;WeatheringBump;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1051;2159.443,3479.985;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;871;2001.823,2916.471;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1052;2226.966,2916.144;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;1198;-233.1197,-4804.62;Inherit;False;1671.519;808.8069;Comment;11;1209;1208;1207;1206;1205;1204;1203;1202;1201;1200;1199;Fresnel;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;496;2441.93,2910.9;Inherit;True;NormalMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1201;-151.4378,-4131.979;Inherit;False;496;NormalMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;1200;-167.9107,-4332.398;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector;1199;-183.1197,-4493.453;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1205;-192.4144,-4749.016;Inherit;False;Property;_FresnelBias1;FresnelBias;61;0;Create;True;0;0;False;0;False;5;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1202;-185.4053,-4661.34;Inherit;False;Property;_FresnelScale1;FresnelScale;62;0;Create;True;0;0;False;0;False;5;10;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1206;-183.9259,-4578.277;Inherit;False;Property;_FresnelPower1;FresnelPower;60;0;Create;True;0;0;False;1;Space(30);False;5;5.05;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;1204;115.6492,-4155.62;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendNormalsNode;1203;112.5743,-4311.489;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FresnelNode;1207;672.3842,-4492.058;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;202;-5519.185,-5984.467;Inherit;False;1331.589;1285.219;Comment;7;180;379;276;275;277;179;1183;Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;167;-2979.516,-3570.889;Inherit;False;2005.872;878.3983;Comment;16;501;1057;1171;1055;121;1056;1172;1054;657;599;5;71;426;817;658;1185;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;276;-4511.423,-5311.578;Inherit;False;234.0894;272.1377;Color Mask 3;1;376;;0,1,0.001329422,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;201;-3016.858,-2424.756;Inherit;False;3260.911;3057.665;MetallicGlossMap;36;87;580;88;394;570;573;569;37;806;816;807;809;815;808;810;636;584;393;189;534;828;900;533;579;829;645;653;343;827;15;608;830;646;606;607;1175;Metallic Glossiness Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1183;-5440.729,-5604.527;Inherit;True;Property;_TextureSample13;Texture Sample 13;2;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;113;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1208;936.954,-4357.996;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1185;-2937.45,-3493.958;Inherit;True;Property;_TextureSample15;Texture Sample 15;0;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;275;-4509.008,-5610.78;Inherit;False;237.4373;272.2484;Color Mask 2;1;375;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1209;1151.958,-4288.271;Inherit;True;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;463;-3009.001,842.5394;Inherit;False;3053.876;1685.284;Comment;29;553;799;792;789;791;790;519;462;70;457;552;783;441;784;55;405;797;782;798;795;1178;781;54;442;796;780;788;787;1194;AO;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;607;-970.1403,163.3883;Inherit;False;876.0251;365.46;Comment;5;568;588;574;825;820;;0,1,0.03845549,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;376;-4490.354,-5269.754;Inherit;True;ColorMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;426;-2594.246,-3400.743;Inherit;False;AlphaInput;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;832;-7579.991,-2408.818;Inherit;False;WetnessGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-5051.612,-5864.563;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;658;-2593.72,-3494.059;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;273;-2966.321,-4975.121;Inherit;False;2484.141;1141.469;Comment;20;487;701;708;731;1186;709;732;1193;710;705;1187;406;43;1197;1196;1195;427;1210;1211;1212;Alpha;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;427;-2926.856,-4913.691;Inherit;False;426;AlphaInput;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;817;-2347.166,-3402.219;Inherit;False;ColorTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;180;-4835.836,-5864.621;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;787;-2941.214,1429.293;Inherit;False;785;Detail1UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;379;-4511.718,-5921.311;Inherit;False;249.3828;282.3601;Color Mask 1;1;378;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;606;-1985.136,152.0023;Inherit;False;928.3743;363.1198;Comment;5;590;594;593;822;823;;1,0,0.1222792,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;884;-7272.952,-2363.092;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;825;-940.9196,417.7441;Inherit;False;376;ColorMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1178;-2726.443,911.4077;Inherit;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;23;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;87;-2920.6,-234.0993;Float;False;Property;_EmissionStrength;EmissionStrength;33;0;Create;True;0;0;True;1;Header (Emission (Tex Required));False;0;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1211;-2925.981,-4759.556;Inherit;False;1209;Fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;375;-4485.896,-5565.951;Inherit;True;ColorMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1194;-2362.612,1175.736;Inherit;False;AlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1212;-2658.56,-4803.282;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;277;-4514.125,-5001.124;Inherit;False;233.8684;272.193;Color Mask 4;1;377;;0.2971698,0.505544,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;823;-1951.523,391.8705;Inherit;False;375;ColorMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;608;-2904.885,144.3154;Inherit;False;859.3313;401.7373;Comment;5;604;603;602;824;821;;0,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;796;-2691.792,1809.167;Inherit;False;Property;_DetailOcclusionContrast;DetailOcclusionContrast;42;0;Create;True;0;0;False;0;False;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;788;-2944.628,1977.866;Inherit;False;786;Detail2UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;881;-7452.899,-2092.046;Inherit;False;Property;_WetnessPower2;WetnessPower2;29;0;Create;True;0;0;True;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;820;-639.9126,337.8988;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;-2983.617,-1784.234;Inherit;True;Property;_MetallicGlossMap1;MetallicGlossMap1;7;0;Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1180;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;378;-4485.959,-5867.56;Inherit;True;ColorMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;830;-2960.85,-1250.992;Inherit;False;Property;_MetallicMask;MetallicMask;44;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;568;-935.7911,218.9103;Inherit;False;817;ColorTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;885;-7129.952,-2363.092;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;780;-2717.123,1407.657;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;646;-2962.816,-1071.799;Inherit;False;Property;_MetallicMask4;MetallicMask4;48;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;795;-2369.624,1412.652;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;822;-1662.924,348.9998;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2701.678,1613.969;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;39;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;645;-2430.684,-1113.555;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;653;-2962.701,-949.0263;Inherit;False;Property;_Metallic4;Metallic4;47;0;Create;True;0;0;True;0;False;1;0.853;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;-2669.698,1707.236;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;343;-2978.516,-1554.069;Inherit;True;Property;_DetailMainTex1;DetailMainTex1;1;0;Create;True;0;0;True;0;False;-1;None;None;True;0;False;gray;Auto;False;Instance;1181;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;827;-2428.668,-1289.962;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;590;-1941.374,204.0024;Inherit;False;817;ColorTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1210;-2493.01,-4913.257;Inherit;False;Property;_AlphaFresnel;AlphaFresnel;59;0;Create;True;0;0;False;2;Space(30);Header (Fresnel Settings);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;781;-2723.666,1956.389;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;-4493.113,-4961.719;Inherit;True;ColorMask4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;824;-2858.97,426.9292;Inherit;False;378;ColorMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;37;-2914.569,-492.7276;Inherit;False;Property;_EmissionColor;EmissionColor;14;0;Create;True;0;0;True;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;880;-6935.775,-2223.46;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1195;-2436.527,-4737.194;Inherit;False;1194;AlphaMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;574;-508.3496,227.0167;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;798;-2718.878,2388.694;Inherit;False;Property;_DetailOcclusionContrast2;DetailOcclusionContrast2;41;0;Create;True;0;0;False;0;False;0;1;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;593;-1520.735,208.9037;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;588;-330.4238,223.3024;Inherit;False;EC3;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;-2848.693,200.3948;Inherit;False;817;ColorTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;807;-2220.156,-968.2783;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;797;-2364.346,1962.748;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;835;-7455.587,-2190.146;Inherit;False;Property;_WetnessPower;WetnessPower;28;0;Create;True;0;0;True;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1196;-2196.456,-4777.438;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;784;-2214.872,1540.389;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;900;-1610.756,-2262.678;Inherit;False;707.5308;1193.688;Comment;7;888;898;886;890;882;892;899;;0.1933962,0.7485096,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;821;-2554.359,331.7533;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;-2691.49,2273.37;Inherit;False;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;579;-2275.005,-541.0218;Inherit;False;889.9937;335.6628;If toggled Color 3 used as Emission Color and Glossiness3 as Emission Strength;6;564;612;609;613;610;611;Color Mask Required;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2719.32,2172.962;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;40;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;891;-6719.928,-2229.957;Inherit;False;WetMet;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;816;-2229.24,-1282.62;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;405;-2362.338,1008.854;Inherit;False;TearingsMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;809;-2270.378,-1711.563;Inherit;False;377;ColorMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;829;-2944.625,-1894.01;Inherit;False;Property;_Roughness;Roughness;43;0;Create;True;0;0;False;2;Header (Metallic Roughness (Optional));;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;533;-2946.135,-2011.243;Inherit;False;Property;_Roughness4;Roughness4;46;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;782;-2125.773,1408.219;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;922;-3569.273,-2413.11;Inherit;False;WeatheringAlpha2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;569;-2701.244,-490.601;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;594;-1277.781,202.6705;Inherit;False;EC2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-2938.604,-2172.154;Inherit;False;Property;_Glossiness4;Glossiness4;45;0;Create;True;0;0;False;2;Header (Color 4 Settings (Optional));;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;828;-2431.119,-1896.59;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;611;-2226.075,-342.1872;Inherit;False;588;EC3;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;534;-2427.669,-2052.32;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;834;-6937.679,-2362.398;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;457;-1878.432,1389.911;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;892;-1560.756,-1672.889;Inherit;False;891;WetMet;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2715.201,1122.98;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;37;0;Create;True;0;0;False;1;Header (Ambient Occlusion);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;573;-2456.35,-485.1922;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-2515.212,-4194.503;Inherit;True;405;TearingsMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1197;-1989.386,-4906.507;Inherit;False;Property;_EnableAlphaMask;EnableAlphaMask;58;0;Create;True;0;0;True;1;Header (Alpha masking Occlusion_A Mask (Optional));False;0;0;1;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1187;-2000.477,-4733.383;Inherit;False;922;WeatheringAlpha2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2518.853,-3980.647;Inherit;False;Property;_AlphaEx;AlphaEx;26;0;Create;True;0;0;True;1;Header (Cloth Tearings);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;783;-2125.719,1958.195;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;552;-2215.485,2108.447;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;602;-2406.65,204.2595;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;806;-1903.516,-1381.45;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;603;-2256.807,200.0624;Inherit;False;EC1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;462;-1863.736,1941.242;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;710;-1964.688,-4167.93;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1193;-1674.666,-4748.559;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;889;-6721.074,-2368.289;Inherit;False;WetGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;564;-2242.818,-491.0992;Inherit;False;Property;_EmissionColor3;Color3 is Emissive;36;0;Create;False;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;5;-2885.997,-3258.985;Inherit;False;Property;_BaseColor;BaseColor;12;0;Create;True;0;0;True;2;Header (Colors);;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;612;-1966.084,-338.5155;Inherit;False;594;EC2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;810;-2245.614,-2162.899;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;71;-2878.281,-3046.559;Inherit;False;Property;_Color;Color;13;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;790;-1623.003,1390.112;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;393;-2538.67,-1560.561;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;886;-1467.421,-1220.106;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;815;-2220.621,-1896.966;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;705;-2043.531,-3976.521;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;519;-1892.577,915.4002;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;570;-2495.442,-699.7601;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;657;-2595.567,-3258.826;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1054;-2107.347,-2946.45;Inherit;False;922;WeatheringAlpha2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;890;-1556.01,-1899.907;Inherit;False;889;WetGloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;888;-1267.984,-1219.954;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1186;-1480.8,-4901.344;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;791;-1601.452,1942.383;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1175;-796.8051,-2264.791;Inherit;False;589.0088;1031.718;Comment;5;1174;1173;1129;1130;1131;;1,1,1,1;0;0
Node;AmplifyShaderEditor.StaticSwitch;609;-1964.979,-490.4353;Inherit;False;Property;_EmissionColor2;Color2 is Emissive;35;0;Create;False;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;613;-1687.749,-338.1947;Inherit;False;603;EC1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;789;-1421.197,1368.837;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;882;-1557.108,-1780.886;Inherit;False;877;ExGloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;709;-1925.78,-4198.311;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;732;-1401.186,-3960.686;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1172;-2107.014,-2856.371;Inherit;False;Constant;_ColorOffset;ColorOffset;61;0;Create;True;0;0;False;0;False;0.282353;0.280914;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;599;-2600.688,-3046.246;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1056;-2101.229,-3129.114;Inherit;False;Property;_WeatheringAlbedo;WeatheringAlbedo;15;0;Create;True;0;0;True;0;False;0.6,0.65,0.65,0;0.6,0.65,0.65,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;808;-1910.512,-2185.096;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-2024.542,-3486.264;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1171;-1721.653,-3114.16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;899;-1081.222,-1388.186;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;792;-1130.644,1667.144;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;394;-2451.789,-652.5522;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;898;-1219.821,-2212.678;Inherit;False;Screen;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClipNode;708;-1249.126,-4803.07;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1130;-714.9787,-1810.672;Inherit;False;932;WeatheringAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;610;-1673.733,-492.9193;Inherit;False;Property;_EmissionColor1;Color1 is Emissive;34;0;Create;False;0;0;True;1;Header (Color Mask Required (Optional));False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1055;-1799.439,-3246.998;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1131;-729.9335,-2113.28;Inherit;False;Property;_WeatheringGloss;WeatheringGloss;55;0;Create;True;0;0;True;0;False;0.8;0.8;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1174;-724.5554,-1689.55;Inherit;False;922;WeatheringAlpha2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;731;-1339.572,-3991.939;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1057;-1493.645,-3486.827;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.6,0.65,0.65;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;701;-974.7943,-4903.646;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1298.824,-677.2303;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1173;-374.9247,-1389.073;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;799;-776.0921,915.6365;Inherit;False;Property;_DetailOcclusion;DetailOcclusion;38;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1129;-386.8221,-2209.315;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.83;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-777.6515,-4907.247;Inherit;True;AlphaMix;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;501;-1221.15,-3490.926;Inherit;True;DiffuseMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;553;-313.3468,913.1072;Inherit;False;OcclusionMix;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;636;-79.43499,-1391.639;Inherit;True;MetallicFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;584;-74.43185,-2215.648;Inherit;True;GlossinessFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;580;-77.84818,-678.7916;Inherit;True;EmissionFinal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;586;650.9106,-1589.974;Inherit;False;584;GlossinessFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1188;877.5776,-2825.227;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;41;-4679.347,1956.406;Inherit;False;Property;_patternuv3;patternuv3;24;0;Create;False;0;0;True;0;False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;21;-4077.036,901.5427;Inherit;True;Property;_DetailMask;DetailMask;4;1;[NoScaleOffset];Create;True;0;0;True;1;Header (R_Detail1 G_Detail2);False;-1;None;435e7d8d51d039e4487ea8da797b2a69;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1180;-4401.745,1354.72;Inherit;True;Property;_MetallicGlossMap;MetallicGlossMap;7;1;[NoScaleOffset];Create;True;0;0;True;2;Header(Packed (R_Gloss G_Emission B_MetallicMask));;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;-4679.347,2089.408;Inherit;False;Property;_patternuv2;patternuv2;23;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;581;657.7754,-1754.158;Inherit;False;580;EmissionFinal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1181;-4389.424,1582.671;Inherit;True;Property;_DetailMainTex;DetailMainTex;1;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Render Texture (leave empty));False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;39;-4680.347,2217.408;Inherit;False;Property;_patternuv1;patternuv1;22;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;499;674.7146,-1844.333;Inherit;False;496;NormalMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;24;-4741.333,1594.257;Inherit;True;Property;_WeatheringMap;WeatheringMap;9;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;aa5a200aa010b6e43a398b6750cf93bb;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-4400.113,895.7682;Inherit;True;Property;_OcclusionMap;OcclusionMap;8;1;[NoScaleOffset];Create;True;0;0;True;1;Header(Packed (R_AO G_none B_Tearings));False;-1;None;c5437ad95e566b1428562e9b104f4c7d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;491;695.0323,-1421.639;Inherit;False;487;AlphaMix;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;244;-4398.097,1130.591;Inherit;True;Property;_BumpMap;BumpMap;3;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;ee08187c87fa401408897ee26518e6b0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;2;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-4054.793,1587.868;Inherit;True;Property;_MainTex;MainTex;0;1;[NoScaleOffset];Create;True;0;0;True;2;Header(Render Texture (leave empty));;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;779;-4732.906,1132.13;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;6;1;[NoScaleOffset];Create;True;0;0;True;2;Header (Detail2);;False;-1;None;daed38127a5d6164886c22cac6c864e2;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;554;668.1394,-1507.099;Inherit;False;553;OcclusionMix;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;760;-4731.882,892.2487;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;5;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Detail1);False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;38;-4493.958,2220;Inherit;False;Property;_UVScalePattern;UVScalePattern;16;0;Create;False;0;0;True;2;Header (UV Coordinates);;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;113;-4064.719,1131.531;Inherit;True;Property;_ColorMask;ColorMask;2;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Optional (Required for Color 4));False;-1;None;070cc2fb3e2705949b03267026795f0b;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;25;-4739.07,1362.111;Inherit;True;Property;_WeatheringMask;WeatheringMask;10;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;5265d7928454eb6418daf7a77bbe1da0;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;635;666.329,-1673.431;Inherit;False;636;MetallicFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;515;673.6072,-1934.4;Inherit;False;501;DiffuseMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.Vector2Node;42;-4681.347,1826.029;Inherit;False;Property;_patternuvbase;patternuvbase;25;0;Fetch;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;831;-4058.561,1359.611;Inherit;True;Property;_WetnessMap;WetnessMap;11;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Packed (R_Glossiness G_Bump));False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1206.381,-1799.783;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;Hanmen/Clothes True Transparent;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0;True;True;0;False;Transparent;2600;Transparent;All;6;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;32;1;2;True;1;True;2;5;False;-1;10;False;-1;1;5;False;-1;8;False;-1;6;False;-1;6;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;660;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1133;0;912;2
WireConnection;1134;0;912;3
WireConnection;1132;0;912;1
WireConnection;1148;0;1134;0
WireConnection;1149;0;1134;0
WireConnection;1191;0;1189;3
WireConnection;1191;1;1189;4
WireConnection;936;0;912;2
WireConnection;936;1;912;1
WireConnection;1141;0;1133;0
WireConnection;1142;0;1132;0
WireConnection;1143;0;1132;0
WireConnection;1094;0;1143;0
WireConnection;934;0;912;1
WireConnection;934;1;912;2
WireConnection;1137;0;1148;0
WireConnection;1112;0;936;0
WireConnection;1102;0;1149;0
WireConnection;1192;0;1191;0
WireConnection;1136;0;1142;0
WireConnection;1135;0;1141;0
WireConnection;1190;0;1189;1
WireConnection;1190;1;1189;2
WireConnection;1138;0;1137;0
WireConnection;241;0;240;0
WireConnection;1101;0;1102;0
WireConnection;1139;0;1135;0
WireConnection;1093;0;1094;0
WireConnection;1109;0;934;0
WireConnection;233;0;327;0
WireConnection;1140;0;1136;0
WireConnection;1105;0;1112;0
WireConnection;906;0;1190;0
WireConnection;906;1;1192;0
WireConnection;239;0;251;0
WireConnection;1147;0;1101;0
WireConnection;1144;0;1140;0
WireConnection;1150;0;1138;0
WireConnection;1146;0;1093;0
WireConnection;236;0;326;0
WireConnection;1108;0;1109;0
WireConnection;234;0;233;0
WireConnection;234;1;235;0
WireConnection;234;2;241;0
WireConnection;1107;0;1105;0
WireConnection;1145;0;1139;0
WireConnection;907;0;906;0
WireConnection;1080;0;469;0
WireConnection;1084;0;470;0
WireConnection;1081;0;473;0
WireConnection;237;0;236;0
WireConnection;237;1;238;0
WireConnection;237;2;239;0
WireConnection;1021;0;1080;0
WireConnection;1079;0;474;0
WireConnection;1083;0;471;0
WireConnection;973;0;1146;0
WireConnection;973;1;1147;0
WireConnection;972;0;1144;0
WireConnection;972;1;1145;0
WireConnection;969;0;1107;0
WireConnection;1082;0;472;0
WireConnection;968;0;1108;0
WireConnection;785;0;234;0
WireConnection;983;0;469;0
WireConnection;983;3;1164;0
WireConnection;939;0;1150;0
WireConnection;954;0;969;0
WireConnection;954;1;1083;0
WireConnection;753;0;785;0
WireConnection;984;0;983;0
WireConnection;955;0;939;0
WireConnection;955;1;1082;0
WireConnection;786;0;237;0
WireConnection;957;0;973;0
WireConnection;957;1;1079;0
WireConnection;747;0;746;0
WireConnection;923;0;968;0
WireConnection;923;1;1084;0
WireConnection;916;1;915;0
WireConnection;956;0;972;0
WireConnection;956;1;1081;0
WireConnection;1010;0;957;0
WireConnection;762;0;761;0
WireConnection;1009;0;956;0
WireConnection;977;0;472;0
WireConnection;977;3;1164;0
WireConnection;744;0;753;0
WireConnection;744;1;747;0
WireConnection;1007;0;954;0
WireConnection;919;0;470;0
WireConnection;919;3;1164;0
WireConnection;763;0;786;0
WireConnection;978;0;473;0
WireConnection;978;3;1164;0
WireConnection;741;0;753;1
WireConnection;741;1;747;0
WireConnection;1008;0;955;0
WireConnection;979;0;474;0
WireConnection;979;3;1164;0
WireConnection;975;0;471;0
WireConnection;975;3;1164;0
WireConnection;1006;0;923;0
WireConnection;1016;0;916;2
WireConnection;1016;1;1022;0
WireConnection;1027;0;1026;0
WireConnection;1018;0;1016;0
WireConnection;1018;1;1017;0
WireConnection;974;0;919;0
WireConnection;764;0;763;1
WireConnection;764;1;762;0
WireConnection;982;0;979;0
WireConnection;748;0;753;0
WireConnection;748;1;741;0
WireConnection;1119;0;1022;0
WireConnection;756;0;744;0
WireConnection;756;1;753;1
WireConnection;366;0;1182;1
WireConnection;976;0;975;0
WireConnection;980;0;977;0
WireConnection;981;0;978;0
WireConnection;849;0;844;0
WireConnection;850;0;848;0
WireConnection;765;0;763;0
WireConnection;765;1;762;0
WireConnection;1163;0;1119;0
WireConnection;996;0;916;2
WireConnection;996;1;1013;0
WireConnection;928;0;916;2
WireConnection;928;1;925;0
WireConnection;1065;0;1018;0
WireConnection;852;0;849;1
WireConnection;852;1;850;0
WireConnection;1029;0;1027;0
WireConnection;742;1;756;0
WireConnection;1001;0;916;2
WireConnection;1001;1;1014;0
WireConnection;367;0;1182;2
WireConnection;851;0;849;0
WireConnection;851;1;850;0
WireConnection;986;0;916;2
WireConnection;986;1;1011;0
WireConnection;766;0;763;0
WireConnection;766;1;764;0
WireConnection;767;0;765;0
WireConnection;767;1;763;1
WireConnection;743;1;785;0
WireConnection;750;1;748;0
WireConnection;991;0;916;2
WireConnection;991;1;1012;0
WireConnection;1030;0;1028;0
WireConnection;769;1;767;0
WireConnection;1032;0;1030;1
WireConnection;1032;1;1029;0
WireConnection;1116;0;1163;0
WireConnection;733;0;369;0
WireConnection;733;2;222;0
WireConnection;853;0;851;0
WireConnection;853;1;849;1
WireConnection;770;1;786;0
WireConnection;993;0;991;0
WireConnection;993;1;992;0
WireConnection;758;0;750;2
WireConnection;758;1;743;2
WireConnection;854;0;849;0
WireConnection;854;1;852;0
WireConnection;1003;0;1001;0
WireConnection;1003;1;1002;0
WireConnection;768;1;766;0
WireConnection;1161;0;1065;0
WireConnection;1031;0;1030;0
WireConnection;1031;1;1029;0
WireConnection;988;0;986;0
WireConnection;988;1;987;0
WireConnection;754;0;742;2
WireConnection;754;1;743;2
WireConnection;929;0;928;0
WireConnection;929;1;985;0
WireConnection;998;0;996;0
WireConnection;998;1;997;0
WireConnection;1034;0;1030;0
WireConnection;1034;1;1032;0
WireConnection;1061;0;988;0
WireConnection;749;0;754;0
WireConnection;749;1;733;0
WireConnection;1064;0;1003;0
WireConnection;757;0;758;0
WireConnection;757;1;733;0
WireConnection;771;0;768;2
WireConnection;771;1;770;2
WireConnection;1062;0;993;0
WireConnection;859;1;844;0
WireConnection;1117;0;1116;0
WireConnection;1033;0;1031;0
WireConnection;1033;1;1030;1
WireConnection;734;0;370;0
WireConnection;734;2;231;0
WireConnection;858;1;853;0
WireConnection;1066;0;929;0
WireConnection;772;0;769;2
WireConnection;772;1;770;2
WireConnection;856;1;854;0
WireConnection;1063;0;998;0
WireConnection;1152;0;1161;0
WireConnection;860;0;858;2
WireConnection;860;1;859;2
WireConnection;862;0;856;2
WireConnection;862;1;859;2
WireConnection;752;2;757;0
WireConnection;773;0;772;0
WireConnection;773;1;734;0
WireConnection;1036;1;1034;0
WireConnection;745;2;749;0
WireConnection;1160;0;1117;0
WireConnection;774;0;771;0
WireConnection;774;1;734;0
WireConnection;1035;1;1028;0
WireConnection;1162;0;1152;0
WireConnection;1037;1;1033;0
WireConnection;1067;0;1066;0
WireConnection;1067;1;1061;0
WireConnection;1067;2;1062;0
WireConnection;1067;3;1063;0
WireConnection;1067;4;1064;0
WireConnection;1067;5;1065;0
WireConnection;864;0;860;0
WireConnection;863;0;862;0
WireConnection;776;2;773;0
WireConnection;1068;0;1067;0
WireConnection;1167;0;1160;0
WireConnection;775;2;774;0
WireConnection;1039;0;1037;3
WireConnection;1039;1;1035;3
WireConnection;1038;0;1036;3
WireConnection;1038;1;1035;3
WireConnection;1127;0;1162;0
WireConnection;751;0;745;0
WireConnection;751;1;752;0
WireConnection;1042;0;1038;0
WireConnection;1042;1;1040;0
WireConnection;1041;0;1039;0
WireConnection;1041;1;1040;0
WireConnection;866;2;864;0
WireConnection;777;0;776;0
WireConnection;777;1;775;0
WireConnection;1069;0;1068;0
WireConnection;1069;1;1127;0
WireConnection;1069;2;1167;0
WireConnection;755;0;751;0
WireConnection;865;2;863;0
WireConnection;1043;2;1041;0
WireConnection;867;0;866;0
WireConnection;867;1;865;0
WireConnection;1168;0;1069;0
WireConnection;778;0;777;0
WireConnection;1044;2;1042;0
WireConnection;836;0;755;0
WireConnection;874;0;1184;2
WireConnection;1045;0;1043;0
WireConnection;1045;1;1044;0
WireConnection;868;0;867;0
WireConnection;877;0;728;0
WireConnection;1179;5;44;0
WireConnection;1169;0;1168;0
WireConnection;837;0;778;0
WireConnection;869;0;868;0
WireConnection;932;0;1169;0
WireConnection;252;0;1179;0
WireConnection;252;1;838;0
WireConnection;1046;0;1045;0
WireConnection;374;0;252;0
WireConnection;374;1;839;0
WireConnection;1050;1;1048;0
WireConnection;875;0;873;0
WireConnection;875;1;876;0
WireConnection;1047;0;1046;0
WireConnection;1051;0;1050;3
WireConnection;1051;1;1049;0
WireConnection;871;0;374;0
WireConnection;871;1;872;0
WireConnection;871;2;875;0
WireConnection;1052;0;871;0
WireConnection;1052;1;1053;0
WireConnection;1052;2;1051;0
WireConnection;496;0;1052;0
WireConnection;1204;0;1200;0
WireConnection;1204;1;1201;0
WireConnection;1203;0;1199;0
WireConnection;1203;1;1201;0
WireConnection;1207;0;1203;0
WireConnection;1207;4;1204;0
WireConnection;1207;1;1205;0
WireConnection;1207;2;1202;0
WireConnection;1207;3;1206;0
WireConnection;1208;0;1207;0
WireConnection;1209;0;1208;0
WireConnection;376;0;1183;2
WireConnection;426;0;1185;4
WireConnection;832;0;1184;1
WireConnection;179;0;1183;1
WireConnection;179;1;1183;2
WireConnection;179;2;1183;3
WireConnection;658;0;1185;0
WireConnection;817;0;658;0
WireConnection;180;0;179;0
WireConnection;884;0;832;0
WireConnection;884;1;874;0
WireConnection;375;0;1183;1
WireConnection;1194;0;1178;4
WireConnection;1212;0;427;0
WireConnection;1212;2;1211;0
WireConnection;820;0;87;0
WireConnection;820;1;825;0
WireConnection;378;0;180;0
WireConnection;885;0;884;0
WireConnection;780;1;787;0
WireConnection;795;1;780;0
WireConnection;795;0;796;0
WireConnection;822;0;87;0
WireConnection;822;1;823;0
WireConnection;645;1;15;3
WireConnection;645;2;646;0
WireConnection;827;1;15;3
WireConnection;827;2;830;0
WireConnection;1210;1;427;0
WireConnection;1210;0;1212;0
WireConnection;781;1;788;0
WireConnection;377;0;1183;3
WireConnection;880;0;885;0
WireConnection;880;1;881;0
WireConnection;574;0;568;0
WireConnection;574;1;820;0
WireConnection;593;0;590;0
WireConnection;593;1;822;0
WireConnection;588;0;574;0
WireConnection;807;0;645;0
WireConnection;807;1;653;0
WireConnection;797;1;781;0
WireConnection;797;0;798;0
WireConnection;1196;0;1210;0
WireConnection;1196;2;1195;0
WireConnection;784;0;54;0
WireConnection;784;1;442;0
WireConnection;821;0;87;0
WireConnection;821;1;824;0
WireConnection;891;0;880;0
WireConnection;816;0;827;0
WireConnection;816;1;343;1
WireConnection;405;0;1178;3
WireConnection;782;0;795;0
WireConnection;922;0;1069;0
WireConnection;569;0;37;0
WireConnection;594;0;593;0
WireConnection;828;1;15;1
WireConnection;828;2;829;0
WireConnection;534;1;15;1
WireConnection;534;2;533;0
WireConnection;834;0;885;0
WireConnection;834;1;835;0
WireConnection;457;1;782;0
WireConnection;457;2;784;0
WireConnection;573;0;569;0
WireConnection;573;1;87;0
WireConnection;1197;1;1210;0
WireConnection;1197;0;1196;0
WireConnection;783;0;797;0
WireConnection;552;0;55;0
WireConnection;552;1;441;0
WireConnection;602;0;604;0
WireConnection;602;1;821;0
WireConnection;806;0;816;0
WireConnection;806;1;807;0
WireConnection;806;2;809;0
WireConnection;603;0;602;0
WireConnection;462;1;783;0
WireConnection;462;2;552;0
WireConnection;710;0;406;0
WireConnection;1193;0;1197;0
WireConnection;1193;1;1187;0
WireConnection;889;0;834;0
WireConnection;564;1;573;0
WireConnection;564;0;611;0
WireConnection;810;0;189;0
WireConnection;810;1;534;0
WireConnection;790;0;457;0
WireConnection;393;0;15;2
WireConnection;886;0;806;0
WireConnection;886;1;892;0
WireConnection;815;0;828;0
WireConnection;815;1;343;3
WireConnection;705;0;43;0
WireConnection;519;1;1178;1
WireConnection;519;2;70;0
WireConnection;570;0;393;0
WireConnection;657;0;5;0
WireConnection;888;0;886;0
WireConnection;1186;0;1197;0
WireConnection;1186;2;1193;0
WireConnection;791;0;462;0
WireConnection;609;1;564;0
WireConnection;609;0;612;0
WireConnection;789;0;519;0
WireConnection;789;1;790;0
WireConnection;709;0;710;0
WireConnection;732;0;705;0
WireConnection;599;0;71;0
WireConnection;808;0;815;0
WireConnection;808;1;810;0
WireConnection;808;2;809;0
WireConnection;121;0;658;0
WireConnection;121;1;657;0
WireConnection;121;2;599;0
WireConnection;1171;0;1054;0
WireConnection;1171;1;1172;0
WireConnection;899;0;806;0
WireConnection;899;1;888;0
WireConnection;899;2;882;0
WireConnection;792;0;789;0
WireConnection;792;1;791;0
WireConnection;394;0;570;0
WireConnection;898;0;890;0
WireConnection;898;1;808;0
WireConnection;898;2;882;0
WireConnection;708;0;1186;0
WireConnection;708;1;709;0
WireConnection;708;2;705;0
WireConnection;610;1;609;0
WireConnection;610;0;613;0
WireConnection;1055;0;1056;0
WireConnection;731;0;732;0
WireConnection;1057;0;121;0
WireConnection;1057;1;1055;0
WireConnection;1057;2;1171;0
WireConnection;701;0;1186;0
WireConnection;701;1;708;0
WireConnection;701;2;731;0
WireConnection;88;0;394;0
WireConnection;88;1;610;0
WireConnection;1173;0;899;0
WireConnection;1173;2;1174;0
WireConnection;799;1;519;0
WireConnection;799;0;792;0
WireConnection;1129;0;898;0
WireConnection;1129;1;1131;0
WireConnection;1129;2;1130;0
WireConnection;487;0;701;0
WireConnection;501;0;1057;0
WireConnection;553;0;799;0
WireConnection;636;0;1173;0
WireConnection;584;0;1129;0
WireConnection;580;0;88;0
WireConnection;0;0;515;0
WireConnection;0;1;499;0
WireConnection;0;2;581;0
WireConnection;0;3;635;0
WireConnection;0;4;586;0
WireConnection;0;5;554;0
WireConnection;0;9;491;0
ASEEND*/
//CHKSM=C43D03B5C3FB610007413DB60C6A8FD217CCEEC8