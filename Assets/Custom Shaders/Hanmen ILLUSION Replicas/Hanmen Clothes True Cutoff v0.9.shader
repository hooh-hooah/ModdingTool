// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Hanmen/Clothes True Cutoff"
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
		[NoScaleOffset][Header (Dithering Noise)]_NoiseTexture("NoiseTexture", 2D) = "white" {}
		[Header (Colors)]_BaseColor("BaseColor", Color) = (1,1,1,1)
		_Color("Color", Color) = (1,1,1,1)
		_EmissionColor("EmissionColor", Color) = (0,0,0,1)
		_WeatheringAlbedo1("WeatheringAlbedo", Color) = (0.6,0.65,0.65,0)
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
		[Header (Dithering Noise)][Toggle(_BLUENOISEDITHER_ON)] _BlueNoiseDither("BlueNoiseDither", Float) = 0
		[Header (Alpha masking Occlusion_A Mask (Optional))][Toggle(_ENABLEALPHAMASK1_ON)] _EnableAlphaMask1("EnableAlphaMask", Float) = 0
		[Header (Zero Disable Dithering)]_Cutoff("Cutoff", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma shader_feature _EMISSIONCOLOR1_ON
		#pragma shader_feature _EMISSIONCOLOR2_ON
		#pragma shader_feature _EMISSIONCOLOR3_ON
		#pragma shader_feature _DETAILOCCLUSION_ON
		#pragma shader_feature _BLUENOISEDITHER_ON
		#pragma shader_feature _ENABLEALPHAMASK1_ON
		#pragma only_renderers d3d9 d3d11_9x d3d11 glcore gles gles3 
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPosition;
		};

		uniform sampler2D _DetailMask;
		uniform sampler2D _WeatheringMask;
		uniform sampler2D _WetnessMap;
		uniform float2 _UVScalePattern;
		uniform sampler2D _OcclusionMap;
		uniform float2 _patternuv2;
		uniform sampler2D _DetailMainTex;
		uniform sampler2D _WeatheringMap;
		uniform sampler2D _BumpMap;
		uniform sampler2D _DetailGlossMap2;
		uniform float _Cutoff;
		uniform float2 _patternuv1;
		uniform float2 _patternuv3;
		uniform sampler2D _MainTex;
		uniform sampler2D _ColorMask;
		uniform sampler2D _MetallicGlossMap;
		uniform sampler2D _DetailGlossMap;
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
		uniform float4 _WeatheringAlbedo1;
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
		uniform float _AlphaEx;
		uniform sampler2D _NoiseTexture;
		float4 _NoiseTexture_TexelSize;


		float4 CalculateContrast( float contrastValue, float4 colorTarget )
		{
			float t = 0.5 * ( 1.0 - contrastValue );
			return mul( float4x4( contrastValue,0,0,t, 0,contrastValue,0,t, 0,0,contrastValue,t, 0,0,0,1 ), colorTarget );
		}

		inline float Dither8x8Bayer( int x, int y )
		{
			const float dither[ 64 ] = {
				 1, 49, 13, 61,  4, 52, 16, 64,
				33, 17, 45, 29, 36, 20, 48, 32,
				 9, 57,  5, 53, 12, 60,  8, 56,
				41, 25, 37, 21, 44, 28, 40, 24,
				 3, 51, 15, 63,  2, 50, 14, 62,
				35, 19, 47, 31, 34, 18, 46, 30,
				11, 59,  7, 55, 10, 58,  6, 54,
				43, 27, 39, 23, 42, 26, 38, 22};
			int r = y * 8 + x;
			return dither[r] / 64; // same # of instructions as pre-dividing due to compiler magic
		}


		inline float DitherNoiseTex( float4 screenPos, sampler2D noiseTexture, float4 noiseTexelSize )
		{
			float dither = tex2Dlod( noiseTexture, float4( screenPos.xy * _ScreenParams.xy * noiseTexelSize.xy, 0, 0 ) ).g;
			float ditherRate = noiseTexelSize.x * noiseTexelSize.y;
			dither = ( 1 - ditherRate ) * dither + ditherRate;
			return dither;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float4 ase_screenPos = ComputeScreenPos( UnityObjectToClipPos( v.vertex ) );
			o.screenPosition = ase_screenPos;
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
			float2 appendResult1188 = (float2(_WeatheringUV.z , _WeatheringUV.w));
			float2 uv_TexCoord1191 = i.uv_texcoord * appendResult1190 + ( appendResult1188 / float2( 100,100 ) );
			float2 WeatheringUV1192 = uv_TexCoord1191;
			float2 break1030 = WeatheringUV1192;
			float temp_output_1029_0 = ( pow( _WeatheringBump , 3.5 ) * 0.1 );
			float2 appendResult1033 = (float2(( break1030.x + temp_output_1029_0 ) , break1030.y));
			float4 tex2DNode1035 = tex2D( _WeatheringMap, WeatheringUV1192 );
			float3 appendResult1043 = (float3(1.0 , 0.0 , ( ( tex2D( _WeatheringMap, appendResult1033 ).b - tex2DNode1035.b ) * _WeatheringBumpPower )));
			float2 appendResult1034 = (float2(break1030.x , ( break1030.y + temp_output_1029_0 )));
			float3 appendResult1044 = (float3(0.0 , 1.0 , ( ( tex2D( _WeatheringMap, appendResult1034 ).b - tex2DNode1035.b ) * _WeatheringBumpPower )));
			float3 normalizeResult1046 = normalize( cross( appendResult1043 , appendResult1044 ) );
			float3 WeatheringBump1047 = normalizeResult1046;
			float4 tex2DNode916 = tex2D( _WeatheringMap, WeatheringUV1192 );
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
			float3 lerpResult1052 = lerp( lerpResult871 , WeatheringBump1047 , ( tex2D( _WeatheringMap, WeatheringUV1192 ).b * WeatheringAlpha932 ));
			float3 NormalMix496 = lerpResult1052;
			o.Normal = NormalMix496;
			float2 uv_MainTex1185 = i.uv_texcoord;
			float4 tex2DNode1185 = tex2D( _MainTex, uv_MainTex1185 );
			float3 temp_output_658_0 = (tex2DNode1185).rgb;
			float WeatheringAlpha2922 = lerpResult1069;
			float3 lerpResult1057 = lerp( ( temp_output_658_0 * (_BaseColor).rgb * (_Color).rgb ) , (_WeatheringAlbedo1).rgb , ( WeatheringAlpha2922 * 0.282353 ));
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
			o.Alpha = 1;
			float4 ase_screenPos = i.screenPosition;
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float2 clipScreen804 = ase_screenPosNorm.xy * _ScreenParams.xy;
			float dither804 = Dither8x8Bayer( fmod(clipScreen804.x, 8), fmod(clipScreen804.y, 8) );
			float AlphaInput426 = tex2DNode1185.a;
			float AlphaMask1200 = tex2DNode1178.a;
			float lerpResult1198 = lerp( AlphaInput426 , 1.0 , AlphaMask1200);
			#ifdef _ENABLEALPHAMASK1_ON
				float staticSwitch1199 = lerpResult1198;
			#else
				float staticSwitch1199 = AlphaInput426;
			#endif
			float lerpResult1193 = lerp( staticSwitch1199 , 1.0 , ( staticSwitch1199 * WeatheringAlpha2922 ));
			float TearingsMask405 = tex2DNode1178.b;
			float temp_output_705_0 = ( 1.0 - _AlphaEx );
			clip( TearingsMask405 - temp_output_705_0);
			float lerpResult701 = lerp( lerpResult1193 , lerpResult1193 , temp_output_705_0);
			dither804 = step( dither804, lerpResult701 );
			float dither803 = DitherNoiseTex( ase_screenPosNorm, _NoiseTexture, _NoiseTexture_TexelSize);
			dither803 = step( dither803, lerpResult701 );
			#ifdef _BLUENOISEDITHER_ON
				float staticSwitch1176 = dither803;
			#else
				float staticSwitch1176 = dither804;
			#endif
			float AlphaMix487 = staticSwitch1176;
			clip( AlphaMix487 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18301
41;121;1906;760;3176.41;3549.34;1.639709;True;True
Node;AmplifyShaderEditor.CommentaryNode;902;-6076.84,-2463.831;Inherit;False;2801.597;3044.073;Comment;121;1117;1116;1160;1163;1119;1022;1162;1152;1161;1069;922;1127;1068;1067;1065;1018;1016;1017;1064;1003;1001;1002;1063;998;997;996;1062;993;991;992;1061;988;987;986;1066;929;932;985;928;1013;980;982;974;976;925;981;1014;1011;1012;1007;919;977;978;979;975;1006;1010;1008;1009;956;923;955;957;954;1079;1083;1082;1084;1081;1144;473;474;1150;984;1107;940;1108;942;1147;948;1145;471;937;1146;472;470;916;935;1101;1139;1093;983;1109;1140;1105;1021;1138;915;1080;1135;1094;1102;1164;1136;1137;934;1112;1148;1149;1143;936;1141;1142;469;1133;1134;1132;912;1167;1169;1168;Weathering;0.9607843,1,0.6196079,1;0;0
Node;AmplifyShaderEditor.SamplerNode;912;-5657.017,-2310.964;Inherit;True;Property;_TextureSample16;Texture Sample 15;10;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;25;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;1186;-5776.067,-3384.857;Inherit;False;1340.87;335.2312;Comment;6;1192;1191;1190;1189;1188;1187;WeatheringUV;0.9856402,1,0,1;0;0
Node;AmplifyShaderEditor.RelayNode;1133;-4902.49,-2262;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1134;-5031.385,-2238.396;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;1132;-4771.775,-2287.415;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1187;-5728.177,-3314.635;Inherit;False;Property;_WeatheringUV;WeatheringUV;22;0;Create;True;0;0;True;0;False;1,1,0,0;5,5,0,1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;936;-5224.135,-2185.203;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1143;-4664.027,-2195.411;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1149;-4896.325,-2161.448;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1188;-5503.177,-3190.635;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1142;-4650.442,-2196.77;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1141;-4778.869,-2175.407;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1148;-4893.608,-2169.599;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1135;-4779.075,-1663.149;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;934;-5220.683,-2355.952;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1137;-4893.084,-1847.241;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1190;-5504.177,-3313.635;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1112;-5066.931,-2144.54;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;1189;-5299.813,-3189.474;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT2;100,100;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1136;-4645.547,-1695.522;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1094;-4656.478,-1482.902;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1102;-4900.907,-1449.622;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1140;-4635.198,-1655.776;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1109;-4688.219,-2320.304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1101;-4889.839,-1415.684;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1139;-4766.241,-1626.784;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1105;-4945.579,-2027.85;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1138;-4878.427,-1815.604;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;469;-5878.497,-1197.74;Inherit;False;Property;_WeatheringAll;WeatheringAll;50;0;Create;True;0;0;True;2;Header (Weathering);;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1093;-4643.331,-1444.557;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;329;-3165.211,2761.059;Inherit;False;3235.085;1139.023;Comment;29;755;751;745;752;757;749;754;758;733;742;369;750;743;222;748;756;741;744;747;753;785;746;234;233;235;241;327;240;836;Detail Normal Map 1;1,0,0,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1191;-5012.246,-3337.03;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;5,0.9;False;1;FLOAT2;0.2,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;1108;-4652.554,-2307.429;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;471;-5879.107,-1918.727;Inherit;False;Property;_WeatheringRange2;WeatheringRange2;52;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1146;-4602.895,-1431.95;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;948;-4516.042,-1519.506;Inherit;False;204;183;Range 5: Arms;1;973;;1,0,0.7995195,1;0;0
Node;AmplifyShaderEditor.WireNode;1147;-4839.269,-1407.497;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;474;-5879.981,-1372.367;Inherit;False;Property;_WeatheringRange5;WeatheringRange5;55;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1145;-4726.516,-1611.269;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;330;-3159.167,4119.344;Inherit;False;3206.373;1317.682;Comment;29;778;777;776;775;774;773;771;734;772;231;769;770;768;370;767;766;765;764;763;762;761;786;237;236;238;239;326;251;837;Detail Normal Map 2;0.03088689,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;942;-4521.682,-1723.584;Inherit;False;204;183;Range 4: Back-Bottom;1;972;;0.9433962,0.8983464,0,1;0;0
Node;AmplifyShaderEditor.WireNode;1150;-4843.401,-1806.739;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;940;-4526.621,-1895.716;Inherit;False;204;160;Range 3: Back-Top;1;939;;0,0.4918175,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;470;-5884.449,-2087.074;Inherit;False;Property;_WeatheringRange1;WeatheringRange1;51;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1107;-4919.864,-2021.369;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1144;-4601.536,-1634.362;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;935;-4539.285,-2305.567;Inherit;False;226;183;Range 1: Front-Top;1;968;;1,0,0,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;472;-5879.004,-1757.574;Inherit;False;Property;_WeatheringRange3;WeatheringRange3;53;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;937;-4534.476,-2098.402;Inherit;False;224;183;Range 2: Front-Bottom;1;969;;0,1,0.1001263,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;473;-5873.199,-1555.86;Inherit;False;Property;_WeatheringRange4;WeatheringRange4;54;0;Create;True;0;0;True;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;327;-3062.235,2930.808;Inherit;False;Property;_DetailUV;DetailUV;18;0;Create;True;0;0;True;0;False;1,1;32,32;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;1164;-5879.711,-1070.212;Inherit;False;Constant;_Float0;Float 0;61;0;Create;True;0;0;False;0;False;0.3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;240;-2987.291,3203.865;Inherit;False;Property;_DetailUVRotator;DetailUVRotator;20;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1192;-4697.097,-3301.529;Inherit;False;WeatheringUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CeilOpNode;1080;-4169.764,-1183.143;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1083;-4171.376,-1906.006;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1081;-4175.29,-1543.439;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;251;-3006.258,4567.135;Inherit;False;Property;_DetailUVRotator2;DetailUVRotator2;21;0;Create;True;0;0;True;0;False;1;1;1;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;972;-4477.078,-1662.015;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1021;-3775.363,-1189.86;Inherit;False;WMaskAll;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;233;-2761.745,2913.699;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CeilOpNode;1082;-4173.189,-1750.323;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;973;-4469.041,-1460.256;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1079;-4178.373,-1360.637;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;326;-3071.57,4262.615;Inherit;False;Property;_DetailUV2;DetailUV2;19;0;Create;True;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;969;-4485.125,-2052.417;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RadiansOpNode;241;-2681.319,3208.8;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;983;-5429.674,-1128.168;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;1084;-4171.02,-2079.658;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;235;-2718.881,3048.565;Inherit;False;Constant;_Anchor2;Anchor2;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ClampOpNode;968;-4489.125,-2264.417;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RelayNode;939;-4476.621,-1834.085;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;915;-6005.016,-786.179;Inherit;False;1192;WeatheringUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RadiansOpNode;239;-2720.142,4566.054;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;984;-5177.087,-1052.346;Inherit;False;RangeCutAll;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;955;-3982.002,-1842.488;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;956;-3988.403,-1663.581;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;954;-3984.447,-2052.505;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;957;-3982.624,-1458.044;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;238;-2756.803,4395.838;Inherit;False;Constant;_Anchor;Anchor;52;0;Create;True;0;0;False;0;False;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;916;-5650.189,-808.7889;Inherit;True;Property;_TextureSample17;Texture Sample 16;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RotatorNode;234;-2447.82,2951.124;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;1022;-5605.082,286.9136;Inherit;False;1021;WMaskAll;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;923;-3987.194,-2261.262;Inherit;False;2;2;0;FLOAT;1;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;236;-2791.574,4246.75;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCCompareWithRange;975;-5427.588,-1860.129;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1010;-3778.923,-1465.172;Inherit;False;WMask5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1008;-3778.529,-1851.793;Inherit;False;WMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1006;-3776.695,-2270.469;Inherit;False;WMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1016;-5250.566,192.0484;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;978;-5429.435,-1489.38;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;746;-2221.043,3635.467;Inherit;False;False;2;0;FLOAT;0.5;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;979;-5427.945,-1310.229;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;237;-2522.011,4353.193;Inherit;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;919;-5425.45,-2046.781;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCCompareWithRange;977;-5426.834,-1668.791;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0.51;False;2;FLOAT;1;False;3;FLOAT;0.3;False;4;FLOAT;0.45;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1017;-5247.239,302.1226;Inherit;False;984;RangeCutAll;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1007;-3777.495,-2061.331;Inherit;False;WMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;785;-2253.117,2946.207;Inherit;False;Detail1UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1009;-3780.775,-1674.142;Inherit;False;WMask4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;974;-5179.259,-1965.335;Inherit;False;RangeCut1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;753;-2134.583,3530.912;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;1012;-5619.14,-268.2888;Inherit;False;1008;WMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;980;-5188.627,-1606.614;Inherit;False;RangeCut3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1013;-5619.14,-170.2887;Inherit;False;1009;WMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;976;-5186.785,-1789.872;Inherit;False;RangeCut2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1014;-5619.14,-72.28874;Inherit;False;1010;WMask5;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;925;-5615.686,-468.823;Inherit;False;1006;WMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1025;-6029.861,4339.221;Inherit;False;2647.625;920.0429;Comment;22;1047;1046;1045;1044;1043;1042;1041;1040;1039;1038;1037;1036;1035;1034;1033;1032;1031;1030;1029;1028;1027;1026;Weathering to Normal;0.9621782,1,0.6196079,1;0;0
Node;AmplifyShaderEditor.ScaleNode;747;-2039.256,3644.093;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;981;-5190.426,-1429.257;Inherit;False;RangeCut4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;204;-7817.534,-924.7391;Inherit;False;1295.923;836.1025;Comment;3;260;261;1182;Detail Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.PowerNode;761;-2252.761,5044.097;Inherit;False;False;2;0;FLOAT;0.5;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1018;-5030.373,195.0723;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;982;-5180.972,-1241.264;Inherit;False;RangeCut5;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1119;-5249.543,443.1495;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;786;-2321.545,4351.415;Inherit;False;Detail2UV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;840;-6095.334,2861.151;Inherit;False;2735.525;1180.599;Comment;20;869;868;867;865;866;863;864;860;862;856;859;858;853;854;851;852;850;849;848;844;Wetness Bump;0,0.7945042,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;1011;-5618.14,-369.2888;Inherit;False;1007;WMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1026;-5975.572,5091.001;Inherit;False;Property;_WeatheringBump;WeatheringBump;57;0;Create;True;0;0;True;0;False;0.4;0.4;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1001;-5251.604,-14.9196;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;985;-5246.254,-699.9539;Inherit;False;974;RangeCut1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;997;-5245.973,-103.6716;Inherit;False;981;RangeCut4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;763;-2166.301,4939.543;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;928;-5249.581,-810.0276;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1163;-5205.946,461.8345;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;987;-5240.218,-503.4339;Inherit;False;976;RangeCut2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;260;-6780.91,-809.9852;Inherit;False;218.3544;268.5316;Comment;1;366;;1,0,0,1;0;0
Node;AmplifyShaderEditor.ScaleNode;762;-2070.975,5052.723;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;986;-5243.546,-613.5067;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;991;-5247.602,-410.4246;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1002;-5248.277,95.15412;Inherit;False;982;RangeCut5;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;996;-5249.299,-213.7458;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;992;-5244.276,-300.3508;Inherit;False;980;RangeCut3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1182;-7689.383,-591.2407;Inherit;True;Property;_TextureSample12;Texture Sample 12;4;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;21;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1065;-4809.696,190.9053;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;744;-1819.232,3528.092;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;848;-5659.777,3785.905;Inherit;False;False;2;0;FLOAT;0.2;False;1;FLOAT;3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;741;-1829.777,3673.248;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;844;-5846.453,3106.429;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;261;-6779.658,-506.862;Inherit;False;226.1978;261.4764;Comment;1;367;;0,1,0.1183066,1;0;0
Node;AmplifyShaderEditor.WireNode;1161;-4291.953,217.4854;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;929;-5029.387,-807.0047;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;988;-5023.352,-610.4837;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1116;-4252.804,454.7237;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;1027;-5675.796,5096.795;Inherit;False;False;2;0;FLOAT;0.43;False;1;FLOAT;3.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;993;-5027.408,-407.4007;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;998;-5029.106,-210.7228;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;765;-1850.95,4936.724;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;756;-1666.428,3525.531;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.BreakToComponentsNode;849;-5573.317,3681.351;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1003;-5031.409,-11.8947;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1028;-5833.372,4417.525;Inherit;False;1192;WeatheringUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;764;-1861.495,5081.878;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;748;-1686.643,3651.629;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;366;-6769.605,-772.0553;Inherit;True;DetailMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;850;-5477.992,3794.532;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;463;-3005.259,842.5394;Inherit;False;3050.134;1494.415;Comment;29;799;553;792;789;791;519;790;462;70;552;457;783;441;797;784;782;55;405;798;781;54;442;795;780;788;796;787;1178;1200;AO;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;1061;-4806.045,-607.3528;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1063;-4813.462,-210.4118;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1064;-4818.277,-9.671555;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;-2805.588,3414.167;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1152;-4240.642,204.9214;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;1030;-5589.336,4993.243;Inherit;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.CommentaryNode;167;-2979.516,-3570.889;Inherit;False;2005.872;878.3983;Comment;16;501;1057;1171;1055;121;1056;1172;1054;657;599;5;71;426;817;658;1185;Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;1066;-4810.864,-807.199;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;743;-1463.982,2926.891;Inherit;True;Property;_TextureSample5;Texture Sample 5;5;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;750;-1476.67,3453.447;Inherit;True;Property;_TextureSample7;Texture Sample 7;5;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;1062;-4806.48,-402.2659;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1117;-4210.766,430.1207;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;766;-1718.361,5060.259;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;367;-6760.558,-466.0528;Inherit;True;DetailMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;852;-5268.514,3823.687;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;767;-1698.146,4934.162;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;222;-2880.408,3504.121;Inherit;False;Property;_DetailNormalMapScale;DetailNormalMapScale;32;0;Create;True;0;0;True;0;False;1;0.46;-3;9;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;202;-7777.238,-2411.284;Inherit;False;1331.589;1285.219;Comment;7;180;379;276;275;277;179;1183;Color Mask;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;742;-1471.023,3215.953;Inherit;True;Property;_TextureSample6;Texture Sample 6;5;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;851;-5257.968,3678.532;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;893;-5960.483,-4424.301;Inherit;False;1601.13;481.772;Comment;13;832;885;834;835;880;881;891;889;884;874;728;877;1184;Wetness;0.01415092,0.7101932,1,1;0;0
Node;AmplifyShaderEditor.ScaleNode;1029;-5494.008,5106.422;Inherit;False;0.1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;853;-5105.164,3675.97;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;758;-1125.918,3400.47;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1178;-2726.443,911.4077;Inherit;True;Property;_TextureSample2;Texture Sample 2;8;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;23;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;754;-1119.737,3167.636;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1185;-2937.45,-3493.958;Inherit;True;Property;_TextureSample15;Texture Sample 15;0;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1031;-5273.985,4990.423;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1162;-4223.42,160.7027;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;201;-3016.858,-2424.756;Inherit;False;3260.911;3057.665;MetallicGlossMap;36;87;580;88;394;570;573;569;37;806;816;807;809;815;808;810;636;584;393;189;534;828;900;533;579;829;645;653;343;827;15;608;830;646;606;607;1175;Metallic Glossiness Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;769;-1502.741,4624.584;Inherit;True;Property;_TextureSample4;Texture Sample 4;6;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1067;-4472.718,-804.7996;Inherit;False;6;6;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1032;-5284.528,5135.578;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;1160;-4189.39,377.3345;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;733;-2529.016,3433.029;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1183;-7698.782,-2031.345;Inherit;True;Property;_TextureSample13;Texture Sample 13;2;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;113;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;770;-1495.7,4335.522;Inherit;True;Property;_NormalCreate01;NormalCreate 01;6;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;231;-3043.468,5020.184;Inherit;False;Property;_DetailNormalMapScale2;DetailNormalMapScale2;33;0;Create;True;0;0;True;0;False;1;0.46;-3;9;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;370;-2987.45,4888.088;Inherit;False;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;276;-6769.476,-1738.395;Inherit;False;234.0894;272.1377;Color Mask 3;1;376;;0,1,0.001329422,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1184;-5921.32,-4360.347;Inherit;True;Property;_TextureSample14;Texture Sample 14;11;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;854;-5125.379,3802.067;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;768;-1508.388,4862.078;Inherit;True;Property;_TextureSample8;Texture Sample 8;6;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;1200;-2360.427,1095.067;Inherit;False;AlphaMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;273;-3015.213,-4904.709;Inherit;False;2544.052;1150.929;Comment;22;487;732;731;701;708;660;709;710;705;406;43;803;804;801;1176;1193;1194;1195;1199;1196;1197;1198;Alpha;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;426;-2594.246,-3400.743;Inherit;False;AlphaInput;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;749;-928.1171,3214.346;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;607;-970.1403,163.3883;Inherit;False;876.0251;365.46;Comment;5;568;588;574;825;820;;0,1,0.03845549,1;0;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;772;-1151.455,4576.268;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;658;-2593.72,-3494.059;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;376;-6748.407,-1696.571;Inherit;True;ColorMask3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;734;-2703.336,4891.011;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;2;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;275;-6767.061,-2037.597;Inherit;False;237.4373;272.2484;Color Mask 2;1;375;;1,0,0,1;0;0
Node;AmplifyShaderEditor.WireNode;1127;-4194.271,-662.5779;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;771;-1157.636,4809.102;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1068;-4319.331,-803.9246;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1034;-5141.395,5113.958;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;1167;-4170.652,-701.8069;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;856;-4915.403,3603.886;Inherit;True;Property;_TextureSample9;Texture Sample 9;11;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;859;-4902.717,3077.329;Inherit;True;Property;_TextureSample11;Texture Sample 11;11;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;832;-5462.41,-4374.301;Inherit;False;WetnessGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1033;-5121.18,4987.863;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;874;-5462.979,-4275.178;Inherit;False;WetnessAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;757;-943.8752,3357.582;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;179;-7309.665,-2291.38;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;858;-4909.758,3366.391;Inherit;True;Property;_TextureSample10;Texture Sample 10;11;0;Create;True;0;0;False;0;False;-1;None;None;True;1;False;white;Auto;False;Instance;831;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1069;-4130.128,-803.4329;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;752;-718.707,3393.894;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;825;-940.9196,417.7441;Inherit;False;376;ColorMask3;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-2920.6,-234.0993;Float;False;Property;_EmissionStrength;EmissionStrength;34;0;Create;True;0;0;True;1;Header (Emission (Tex Required));False;0;0;0;20;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;606;-1985.136,152.0023;Inherit;False;928.3743;363.1198;Comment;5;590;594;593;822;823;;1,0,0.1222792,1;0;0
Node;AmplifyShaderEditor.SamplerNode;1037;-4941.775,4676.284;Inherit;True;Property;_TextureSample24;Texture Sample 18;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;745;-745.622,3165.121;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1197;-2986.469,-4843.58;Inherit;False;426;AlphaInput;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;860;-4558.473,3318.075;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1036;-4931.423,4915.778;Inherit;True;Property;_TextureSample23;Texture Sample 21;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1035;-4949.85,4396.044;Inherit;True;Property;_TextureSample30;Texture Sample 28;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;787;-2941.214,1242.167;Inherit;False;785;Detail1UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;817;-2340.634,-3402.219;Inherit;False;ColorTex;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;180;-7093.889,-2291.438;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;884;-5155.371,-4328.574;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;375;-6743.948,-1992.768;Inherit;True;ColorMask2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;379;-6769.771,-2348.128;Inherit;False;249.3828;282.3601;Color Mask 1;1;378;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;773;-959.8351,4622.978;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1196;-2989.65,-4690.59;Inherit;False;1200;AlphaMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;774;-975.5932,4766.213;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;862;-4564.652,3550.909;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;922;-3535.734,-476.6419;Inherit;False;WeatheringAlpha2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;788;-2944.628,1790.74;Inherit;False;786;Detail2UV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ClampOpNode;885;-5012.371,-4328.574;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;608;-2904.885,144.3154;Inherit;False;859.3313;401.7373;Comment;5;604;603;602;824;821;;0,0,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;277;-6772.178,-1427.941;Inherit;False;233.8684;272.193;Color Mask 4;1;377;;0.2971698,0.505544,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1040;-4604.935,4755.051;Inherit;False;Property;_WeatheringBumpPower;WeatheringBumpPower;58;0;Create;True;0;0;True;0;False;2;2;0;9;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;405;-2362.338,1008.854;Inherit;False;TearingsMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1198;-2704.876,-4730.169;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;830;-2960.85,-1250.992;Inherit;False;Property;_MetallicMask;MetallicMask;45;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;820;-639.9126,337.8988;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;796;-2691.792,1622.041;Inherit;False;Property;_DetailOcclusionContrast;DetailOcclusionContrast;43;0;Create;True;0;0;False;0;False;0;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;15;-2983.617,-1784.234;Inherit;True;Property;_MetallicGlossMap1;MetallicGlossMap1;7;0;Create;True;0;0;True;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;1180;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;378;-6744.012,-2294.377;Inherit;True;ColorMask1;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;751;-584.4581,3267.156;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;823;-1951.523,391.8705;Inherit;False;375;ColorMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;863;-4382.61,3508.021;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;568;-935.7911,218.9103;Inherit;False;817;ColorTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;776;-777.3399,4573.752;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1039;-4574.488,4629.966;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;864;-4366.853,3364.785;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;1038;-4580.671,4862.8;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;881;-5335.319,-4057.529;Inherit;False;Property;_WetnessPower2;WetnessPower2;30;0;Create;True;0;0;True;0;False;0;0.2588235;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;780;-2717.123,1220.531;Inherit;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;760;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;775;-750.425,4802.525;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;646;-2962.816,-1071.799;Inherit;False;Property;_MetallicMask4;MetallicMask4;49;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;798;-2718.878,2201.569;Inherit;False;Property;_DetailOcclusionContrast2;DetailOcclusionContrast2;42;0;Create;True;0;0;False;0;False;0;2;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;755;-424.7832,3284.703;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;442;-2669.698,1520.11;Inherit;False;366;DetailMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;43;-2921.97,-4012.641;Inherit;False;Property;_AlphaEx;AlphaEx;27;0;Create;True;0;0;True;1;Header (Cloth Tearings);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;822;-1662.924,348.9998;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;866;-4184.356,3315.559;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1194;-2469.594,-4687.316;Inherit;False;922;WeatheringAlpha2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1199;-2503.371,-4842.078;Inherit;False;Property;_EnableAlphaMask1;EnableAlphaMask;60;0;Create;True;0;0;True;1;Header (Alpha masking Occlusion_A Mask (Optional));False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2701.678,1426.843;Inherit;False;Property;_DetailOcclusionScale;DetailOcclusionScale;40;0;Create;True;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;781;-2723.666,1769.263;Inherit;True;Property;_TextureSample1;Texture Sample 1;6;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;779;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;590;-1941.374,204.0024;Inherit;False;817;ColorTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;824;-2858.97,426.9292;Inherit;False;378;ColorMask1;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;865;-4157.441,3544.333;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1042;-4309.032,4866.286;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1041;-4311.638,4657.459;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;574;-508.3496,227.0167;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;343;-2978.516,-1554.069;Inherit;True;Property;_DetailMainTex1;DetailMainTex1;1;0;Create;True;0;0;True;0;False;-1;None;None;True;0;False;gray;Auto;False;Instance;1181;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;645;-2430.684,-1113.555;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;406;-2918.328,-4226.502;Inherit;True;405;TearingsMask;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;827;-2428.668,-1289.962;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;795;-2369.624,1225.526;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;37;-2914.569,-492.7276;Inherit;False;Property;_EmissionColor;EmissionColor;15;0;Create;True;0;0;True;0;False;0,0,0,1;0,0,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;880;-4818.195,-4188.943;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;-6751.166,-1388.536;Inherit;True;ColorMask4;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;653;-2962.701,-949.0263;Inherit;False;Property;_Metallic4;Metallic4;48;0;Create;True;0;0;True;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;777;-616.1771,4675.787;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;495;290.4105,2849.293;Inherit;False;2436.961;983.8583;Comment;18;44;496;1052;871;1051;1053;1050;872;875;1049;374;876;1048;252;839;873;838;1179;Normal Mix;0.8967471,0.5424528,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2719.32,1985.837;Inherit;False;Property;_DetailOcclusionScale2;DetailOcclusionScale2;41;0;Create;True;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;710;-2367.806,-4199.928;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;784;-2214.872,1353.263;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;705;-2446.649,-4008.515;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;816;-2229.24,-1282.62;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;441;-2691.49,2086.245;Inherit;False;367;DetailMask2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;835;-5338.006,-4155.628;Inherit;False;Property;_WetnessPower;WetnessPower;29;0;Create;True;0;0;True;0;False;0;0.8;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;728;-5910.482,-4126.687;Inherit;False;Property;_ExGloss;ExGloss;28;0;Create;True;0;0;True;1;Header (Wetness);False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;821;-2554.359,331.7533;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;829;-2944.625,-1894.01;Inherit;False;Property;_Roughness;Roughness;44;0;Create;True;0;0;False;2;Header (Metallic Roughness (Optional));;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;593;-1520.735,208.9037;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CrossProductOpNode;867;-4023.194,3417.595;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1195;-2125.767,-4703.146;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleContrastOpNode;797;-2364.346,1775.622;Inherit;False;2;1;COLOR;0,0,0,0;False;0;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;809;-2270.378,-1711.563;Inherit;False;377;ColorMask4;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;533;-2946.135,-2011.243;Inherit;False;Property;_Roughness4;Roughness4;47;0;Create;True;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;807;-2220.156,-968.2783;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;588;-330.4238,223.3024;Inherit;False;EC3;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;569;-2701.244,-490.601;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;604;-2848.693,200.3948;Inherit;False;817;ColorTex;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;44;433.2136,2942.091;Inherit;False;Property;_BumpScale;BumpScale;31;0;Create;True;0;0;True;2;Header (Bump);;False;1;2;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;778;-456.5022,4693.334;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;900;-1610.756,-2262.678;Inherit;False;707.5308;1193.688;Comment;7;888;898;886;890;882;892;899;;0.1933962,0.7485096,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;579;-2275.005,-541.0218;Inherit;False;889.9937;335.6628;If toggled Color 3 used as Emission Color and Glossiness3 as Emission Strength;6;564;612;609;613;610;611;Color Mask Required;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;836;-194.6561,3263.052;Inherit;True;DetailNormal1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1043;-4129.141,4623.977;Inherit;False;FLOAT3;4;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1168;-3898.254,-802.9969;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;891;-4602.347,-4195.44;Inherit;False;WetMet;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCGrayscale;782;-2125.773,1221.093;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;1044;-4102.228,4852.749;Inherit;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;602;-2406.65,204.2595;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;806;-1903.516,-1381.45;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalizeNode;868;-3863.519,3435.141;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TFHCGrayscale;783;-2125.719,1771.069;Inherit;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;709;-2328.898,-4230.308;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;838;1180.098,3100.182;Inherit;False;836;DetailNormal1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;611;-2226.075,-342.1872;Inherit;False;588;EC3;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;552;-2215.485,1921.321;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1193;-1943.636,-4831.084;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;189;-2938.604,-2172.154;Inherit;False;Property;_Glossiness4;Glossiness4;46;0;Create;True;0;0;False;2;Header (Color 4 Settings (Optional));;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2715.201,1122.98;Inherit;False;Property;_OcclusionStrength;OcclusionStrength;38;0;Create;True;0;0;False;1;Header (Ambient Occlusion);False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CrossProductOpNode;1045;-3967.98,4726.013;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;892;-1560.756,-1672.889;Inherit;False;891;WetMet;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;877;-5588.59,-4133.925;Inherit;False;ExGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;573;-2456.35,-485.1922;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;837;-223.1501,4689.553;Inherit;True;DetailNormal2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;834;-4820.098,-4327.881;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;1169;-3740.009,-802.2278;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;534;-2427.669,-2052.32;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;828;-2431.119,-1896.59;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;457;-1878.432,1202.785;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;732;-1804.305,-3992.68;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;594;-1277.781,202.6705;Inherit;False;EC2;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;1179;800.6705,2909.453;Inherit;True;Property;_TextureSample3;Texture Sample 3;3;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Instance;244;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;839;1474.267,3110.294;Inherit;False;837;DetailNormal2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;71;-2878.281,-3046.559;Inherit;False;Property;_Color;Color;14;0;Create;True;0;0;True;0;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClipNode;708;-1752.902,-4725.461;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;603;-2256.807,200.0624;Inherit;False;EC1;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1046;-3796.303,4728.559;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;815;-2220.621,-1896.966;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;519;-1892.577,915.4002;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;876;1566.492,3346.727;Inherit;False;877;ExGloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;790;-1623.003,1202.986;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;252;1382.573,2913.577;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;889;-4603.493,-4333.772;Inherit;False;WetGloss;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;564;-2242.818,-491.0992;Inherit;False;Property;_EmissionColor3;Color3 is Emissive;37;0;Create;False;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;731;-1742.691,-4023.933;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;462;-1863.736,1754.116;Inherit;False;3;0;FLOAT;1;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;886;-1467.421,-1220.106;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;612;-1966.084,-338.5155;Inherit;False;594;EC2;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1048;1177.9,3514.207;Inherit;False;1192;WeatheringUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;869;-3630.165,3431.361;Inherit;True;WetnessNormal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;393;-2538.67,-1560.561;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;5;-2885.997,-3258.985;Inherit;False;Property;_BaseColor;BaseColor;13;0;Create;True;0;0;True;2;Header (Colors);;False;1,1,1,1;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;810;-2245.614,-2162.899;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;873;1512.703,3233.499;Inherit;False;874;WetnessAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;932;-3525.37,-805.6849;Inherit;False;WeatheringAlpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;875;1819.492,3233.727;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1172;-2107.014,-2856.371;Inherit;False;Constant;_ColorOffset;ColorOffset;61;0;Create;True;0;0;False;0;False;0.282353;0.280914;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;808;-1910.512,-2185.096;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;570;-2495.442,-699.7601;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;791;-1601.452,1755.257;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;613;-1687.749,-338.1947;Inherit;False;603;EC1;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;599;-2600.688,-3046.246;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1049;1863.792,3672.108;Inherit;False;932;WeatheringAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1054;-2107.347,-2946.45;Inherit;False;922;WeatheringAlpha2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;701;-1472.706,-4833.235;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;1175;-796.8051,-2264.791;Inherit;False;589.0088;1031.718;Comment;5;1174;1173;1129;1130;1131;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1047;-3637.695,4725.975;Inherit;False;WeatheringBump;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;657;-2595.567,-3258.826;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;789;-1421.197,1181.711;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1050;1437.015,3494.834;Inherit;True;Property;_TextureSample18;Texture Sample 17;9;0;Create;True;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;24;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BlendNormalsNode;374;1699.389,2916.168;Inherit;False;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ClampOpNode;888;-1267.984,-1219.954;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1056;-2109.427,-3130.754;Inherit;False;Property;_WeatheringAlbedo1;WeatheringAlbedo;16;0;Create;True;0;0;True;0;False;0.6,0.65,0.65,0;0.6,0.65,0.65,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;609;-1964.979,-490.4353;Inherit;False;Property;_EmissionColor2;Color2 is Emissive;36;0;Create;False;0;0;True;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;882;-1557.108,-1780.886;Inherit;False;877;ExGloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;801;-1595.797,-4158.152;Inherit;True;Property;_NoiseTexture;NoiseTexture;12;1;[NoScaleOffset];Create;True;0;0;False;2;Header (Dithering Noise);;False;d469c63fdf99cd243a05047268aeaa5d;d469c63fdf99cd243a05047268aeaa5d;False;white;Auto;Texture2D;-1;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.GetLocalVarNode;872;1728.751,3111.391;Inherit;False;869;WetnessNormal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;890;-1556.01,-1899.907;Inherit;False;889;WetGloss;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1171;-1721.653,-3114.16;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1174;-724.5554,-1689.55;Inherit;False;922;WeatheringAlpha2;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;121;-1915.67,-3486.264;Inherit;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;792;-1130.644,1480.018;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;394;-2451.789,-652.5522;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1053;1994.895,3110.046;Inherit;False;1047;WeatheringBump;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;1131;-729.9335,-2113.28;Inherit;False;Property;_WeatheringGloss;WeatheringGloss;56;0;Create;True;0;0;True;0;False;0.8;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1051;2159.443,3479.985;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;610;-1673.733,-492.9193;Inherit;False;Property;_EmissionColor1;Color1 is Emissive;35;0;Create;False;0;0;True;1;Header (Color Mask Required (Optional));False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;1055;-1799.439,-3246.998;Inherit;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;871;2001.823,2916.471;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DitheringNode;803;-1259.608,-4701.798;Inherit;False;2;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BlendOpsNode;898;-1219.821,-2212.678;Inherit;False;Screen;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1130;-714.9787,-1810.672;Inherit;False;932;WeatheringAlpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.DitheringNode;804;-1243.395,-4837.044;Inherit;False;1;False;3;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;899;-1081.222,-1388.186;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;799;-776.0921,915.6365;Inherit;False;Property;_DetailOcclusion;DetailOcclusion;39;0;Create;True;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;1057;-1493.645,-3486.827;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.6,0.65,0.65;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1129;-386.8221,-2209.315;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0.83;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1176;-1003.425,-4837.404;Inherit;False;Property;_BlueNoiseDither;BlueNoiseDither;59;0;Create;True;0;0;False;1;Header (Dithering Noise);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;-1298.824,-677.2303;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1052;2226.966,2916.144;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;1173;-374.9247,-1389.073;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;501;-1221.15,-3490.926;Inherit;True;DiffuseMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;496;2441.93,2910.9;Inherit;True;NormalMix;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;580;-77.84818,-678.7916;Inherit;True;EmissionFinal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-699.4288,-4836.835;Inherit;True;AlphaMix;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;636;-79.43499,-1391.639;Inherit;True;MetallicFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;584;-74.43185,-2215.648;Inherit;True;GlossinessFinal;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;553;-313.3468,913.1072;Inherit;False;OcclusionMix;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;760;-4731.882,892.2487;Inherit;True;Property;_DetailGlossMap;DetailGlossMap;5;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Detail1);False;-1;None;d716ebeef43d59b4191a0818c39f269b;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-4050.38,1590.075;Inherit;True;Property;_MainTex;MainTex;0;1;[NoScaleOffset];Create;True;0;0;True;2;Header(Render Texture (leave empty));;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;554;668.1394,-1507.099;Inherit;False;553;OcclusionMix;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;21;-4081.449,908.1627;Inherit;True;Property;_DetailMask;DetailMask;4;1;[NoScaleOffset];Create;True;0;0;True;1;Header (R_Detail1 G_Detail2);False;-1;None;435e7d8d51d039e4487ea8da797b2a69;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;491;695.0323,-1421.639;Inherit;False;487;AlphaMix;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;25;-4739.07,1362.111;Inherit;True;Property;_WeatheringMask;WeatheringMask;10;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;5265d7928454eb6418daf7a77bbe1da0;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;831;-4058.561,1364.024;Inherit;True;Property;_WetnessMap;WetnessMap;11;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Packed (R_Glossiness G_Bump));False;-1;None;bc73e63a388734c43a854e4992ed0b00;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;38;-4493.958,2220;Inherit;False;Property;_UVScalePattern;UVScalePattern;17;0;Create;False;0;0;True;2;Header (UV Coordinates);;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;23;-4400.113,900.1816;Inherit;True;Property;_OcclusionMap;OcclusionMap;8;1;[NoScaleOffset];Create;True;0;0;True;1;Header(Packed (R_AO G_none B_Tearings));False;-1;None;c5437ad95e566b1428562e9b104f4c7d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;40;-4679.347,2089.408;Inherit;False;Property;_patternuv2;patternuv2;24;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;586;650.9106,-1589.974;Inherit;False;584;GlossinessFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;24;-4741.333,1594.257;Inherit;True;Property;_WeatheringMap;WeatheringMap;9;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;aa5a200aa010b6e43a398b6750cf93bb;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;499;674.7146,-1844.333;Inherit;False;496;NormalMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;635;666.329,-1673.431;Inherit;False;636;MetallicFinal;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;39;-4680.347,2217.408;Inherit;False;Property;_patternuv1;patternuv1;23;0;Create;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;42;-4681.347,1826.029;Inherit;False;Property;_patternuvbase;patternuvbase;26;0;Fetch;False;0;0;True;0;False;1,1;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;515;673.6072,-1934.4;Inherit;False;501;DiffuseMix;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;779;-4732.906,1132.13;Inherit;True;Property;_DetailGlossMap2;DetailGlossMap2;6;1;[NoScaleOffset];Create;True;0;0;True;2;Header (Detail2);;False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;660;-842.3228,-4439.765;Inherit;False;Property;_Cutoff;Cutoff;61;0;Create;True;0;0;True;1;Header (Zero Disable Dithering);False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;244;-4398.097,1130.591;Inherit;True;Property;_BumpMap;BumpMap;3;1;[NoScaleOffset];Create;True;0;0;True;0;False;-1;None;ee08187c87fa401408897ee26518e6b0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;2;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;41;-4679.347,1956.406;Inherit;False;Property;_patternuv3;patternuv3;25;0;Create;False;0;0;True;0;False;1,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SamplerNode;1181;-4389.424,1582.671;Inherit;True;Property;_DetailMainTex;DetailMainTex;1;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Render Texture (leave empty));False;-1;None;None;True;0;False;gray;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;581;657.7754,-1754.158;Inherit;False;580;EmissionFinal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;113;-4064.719,1131.531;Inherit;True;Property;_ColorMask;ColorMask;2;1;[NoScaleOffset];Create;True;0;0;True;1;Header (Optional (Required for Color 4));False;-1;None;070cc2fb3e2705949b03267026795f0b;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1180;-4401.745,1354.72;Inherit;True;Property;_MetallicGlossMap;MetallicGlossMap;7;1;[NoScaleOffset];Create;True;0;0;True;2;Header(Packed (R_Gloss G_Emission B_MetallicMask));;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1196.249,-1798.517;Float;False;True;-1;7;ASEMaterialInspector;0;0;Standard;Hanmen/Clothes True Cutoff;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Masked;0;True;True;0;False;TransparentCutout;2600;AlphaTest;All;6;d3d9;d3d11_9x;d3d11;glcore;gles;gles3;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;32;1;2;True;1;True;0;1;False;-1;10;False;-1;1;5;False;-1;8;False;-1;6;False;-1;6;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;True;660;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;1133;0;912;2
WireConnection;1134;0;912;3
WireConnection;1132;0;912;1
WireConnection;936;0;912;2
WireConnection;936;1;912;1
WireConnection;1143;0;1132;0
WireConnection;1149;0;1134;0
WireConnection;1188;0;1187;3
WireConnection;1188;1;1187;4
WireConnection;1142;0;1132;0
WireConnection;1141;0;1133;0
WireConnection;1148;0;1134;0
WireConnection;1135;0;1141;0
WireConnection;934;0;912;1
WireConnection;934;1;912;2
WireConnection;1137;0;1148;0
WireConnection;1190;0;1187;1
WireConnection;1190;1;1187;2
WireConnection;1112;0;936;0
WireConnection;1189;0;1188;0
WireConnection;1136;0;1142;0
WireConnection;1094;0;1143;0
WireConnection;1102;0;1149;0
WireConnection;1140;0;1136;0
WireConnection;1109;0;934;0
WireConnection;1101;0;1102;0
WireConnection;1139;0;1135;0
WireConnection;1105;0;1112;0
WireConnection;1138;0;1137;0
WireConnection;1093;0;1094;0
WireConnection;1191;0;1190;0
WireConnection;1191;1;1189;0
WireConnection;1108;0;1109;0
WireConnection;1146;0;1093;0
WireConnection;1147;0;1101;0
WireConnection;1145;0;1139;0
WireConnection;1150;0;1138;0
WireConnection;1107;0;1105;0
WireConnection;1144;0;1140;0
WireConnection;1192;0;1191;0
WireConnection;1080;0;469;0
WireConnection;1083;0;471;0
WireConnection;1081;0;473;0
WireConnection;972;0;1144;0
WireConnection;972;1;1145;0
WireConnection;1021;0;1080;0
WireConnection;233;0;327;0
WireConnection;1082;0;472;0
WireConnection;973;0;1146;0
WireConnection;973;1;1147;0
WireConnection;1079;0;474;0
WireConnection;969;0;1107;0
WireConnection;241;0;240;0
WireConnection;983;0;469;0
WireConnection;983;3;1164;0
WireConnection;1084;0;470;0
WireConnection;968;0;1108;0
WireConnection;939;0;1150;0
WireConnection;239;0;251;0
WireConnection;984;0;983;0
WireConnection;955;0;939;0
WireConnection;955;1;1082;0
WireConnection;956;0;972;0
WireConnection;956;1;1081;0
WireConnection;954;0;969;0
WireConnection;954;1;1083;0
WireConnection;957;0;973;0
WireConnection;957;1;1079;0
WireConnection;916;1;915;0
WireConnection;234;0;233;0
WireConnection;234;1;235;0
WireConnection;234;2;241;0
WireConnection;923;0;968;0
WireConnection;923;1;1084;0
WireConnection;236;0;326;0
WireConnection;975;0;471;0
WireConnection;975;3;1164;0
WireConnection;1010;0;957;0
WireConnection;1008;0;955;0
WireConnection;1006;0;923;0
WireConnection;1016;0;916;2
WireConnection;1016;1;1022;0
WireConnection;978;0;473;0
WireConnection;978;3;1164;0
WireConnection;979;0;474;0
WireConnection;979;3;1164;0
WireConnection;237;0;236;0
WireConnection;237;1;238;0
WireConnection;237;2;239;0
WireConnection;919;0;470;0
WireConnection;919;3;1164;0
WireConnection;977;0;472;0
WireConnection;977;3;1164;0
WireConnection;1007;0;954;0
WireConnection;785;0;234;0
WireConnection;1009;0;956;0
WireConnection;974;0;919;0
WireConnection;753;0;785;0
WireConnection;980;0;977;0
WireConnection;976;0;975;0
WireConnection;747;0;746;0
WireConnection;981;0;978;0
WireConnection;1018;0;1016;0
WireConnection;1018;1;1017;0
WireConnection;982;0;979;0
WireConnection;1119;0;1022;0
WireConnection;786;0;237;0
WireConnection;1001;0;916;2
WireConnection;1001;1;1014;0
WireConnection;763;0;786;0
WireConnection;928;0;916;2
WireConnection;928;1;925;0
WireConnection;1163;0;1119;0
WireConnection;762;0;761;0
WireConnection;986;0;916;2
WireConnection;986;1;1011;0
WireConnection;991;0;916;2
WireConnection;991;1;1012;0
WireConnection;996;0;916;2
WireConnection;996;1;1013;0
WireConnection;1065;0;1018;0
WireConnection;744;0;753;0
WireConnection;744;1;747;0
WireConnection;741;0;753;1
WireConnection;741;1;747;0
WireConnection;1161;0;1065;0
WireConnection;929;0;928;0
WireConnection;929;1;985;0
WireConnection;988;0;986;0
WireConnection;988;1;987;0
WireConnection;1116;0;1163;0
WireConnection;1027;0;1026;0
WireConnection;993;0;991;0
WireConnection;993;1;992;0
WireConnection;998;0;996;0
WireConnection;998;1;997;0
WireConnection;765;0;763;0
WireConnection;765;1;762;0
WireConnection;756;0;744;0
WireConnection;756;1;753;1
WireConnection;849;0;844;0
WireConnection;1003;0;1001;0
WireConnection;1003;1;1002;0
WireConnection;764;0;763;1
WireConnection;764;1;762;0
WireConnection;748;0;753;0
WireConnection;748;1;741;0
WireConnection;366;0;1182;1
WireConnection;850;0;848;0
WireConnection;1061;0;988;0
WireConnection;1063;0;998;0
WireConnection;1064;0;1003;0
WireConnection;1152;0;1161;0
WireConnection;1030;0;1028;0
WireConnection;1066;0;929;0
WireConnection;743;1;785;0
WireConnection;750;1;748;0
WireConnection;1062;0;993;0
WireConnection;1117;0;1116;0
WireConnection;766;0;763;0
WireConnection;766;1;764;0
WireConnection;367;0;1182;2
WireConnection;852;0;849;1
WireConnection;852;1;850;0
WireConnection;767;0;765;0
WireConnection;767;1;763;1
WireConnection;742;1;756;0
WireConnection;851;0;849;0
WireConnection;851;1;850;0
WireConnection;1029;0;1027;0
WireConnection;853;0;851;0
WireConnection;853;1;849;1
WireConnection;758;0;750;2
WireConnection;758;1;743;2
WireConnection;754;0;742;2
WireConnection;754;1;743;2
WireConnection;1031;0;1030;0
WireConnection;1031;1;1029;0
WireConnection;1162;0;1152;0
WireConnection;769;1;767;0
WireConnection;1067;0;1066;0
WireConnection;1067;1;1061;0
WireConnection;1067;2;1062;0
WireConnection;1067;3;1063;0
WireConnection;1067;4;1064;0
WireConnection;1067;5;1065;0
WireConnection;1032;0;1030;1
WireConnection;1032;1;1029;0
WireConnection;1160;0;1117;0
WireConnection;733;0;369;0
WireConnection;733;2;222;0
WireConnection;770;1;786;0
WireConnection;854;0;849;0
WireConnection;854;1;852;0
WireConnection;768;1;766;0
WireConnection;1200;0;1178;4
WireConnection;426;0;1185;4
WireConnection;749;0;754;0
WireConnection;749;1;733;0
WireConnection;772;0;769;2
WireConnection;772;1;770;2
WireConnection;658;0;1185;0
WireConnection;376;0;1183;2
WireConnection;734;0;370;0
WireConnection;734;2;231;0
WireConnection;1127;0;1162;0
WireConnection;771;0;768;2
WireConnection;771;1;770;2
WireConnection;1068;0;1067;0
WireConnection;1034;0;1030;0
WireConnection;1034;1;1032;0
WireConnection;1167;0;1160;0
WireConnection;856;1;854;0
WireConnection;859;1;844;0
WireConnection;832;0;1184;1
WireConnection;1033;0;1031;0
WireConnection;1033;1;1030;1
WireConnection;874;0;1184;2
WireConnection;757;0;758;0
WireConnection;757;1;733;0
WireConnection;179;0;1183;1
WireConnection;179;1;1183;2
WireConnection;179;2;1183;3
WireConnection;858;1;853;0
WireConnection;1069;0;1068;0
WireConnection;1069;1;1127;0
WireConnection;1069;2;1167;0
WireConnection;752;2;757;0
WireConnection;1037;1;1033;0
WireConnection;745;2;749;0
WireConnection;860;0;858;2
WireConnection;860;1;859;2
WireConnection;1036;1;1034;0
WireConnection;1035;1;1028;0
WireConnection;817;0;658;0
WireConnection;180;0;179;0
WireConnection;884;0;832;0
WireConnection;884;1;874;0
WireConnection;375;0;1183;1
WireConnection;773;0;772;0
WireConnection;773;1;734;0
WireConnection;774;0;771;0
WireConnection;774;1;734;0
WireConnection;862;0;856;2
WireConnection;862;1;859;2
WireConnection;922;0;1069;0
WireConnection;885;0;884;0
WireConnection;405;0;1178;3
WireConnection;1198;0;1197;0
WireConnection;1198;2;1196;0
WireConnection;820;0;87;0
WireConnection;820;1;825;0
WireConnection;378;0;180;0
WireConnection;751;0;745;0
WireConnection;751;1;752;0
WireConnection;863;0;862;0
WireConnection;776;2;773;0
WireConnection;1039;0;1037;3
WireConnection;1039;1;1035;3
WireConnection;864;0;860;0
WireConnection;1038;0;1036;3
WireConnection;1038;1;1035;3
WireConnection;780;1;787;0
WireConnection;775;2;774;0
WireConnection;755;0;751;0
WireConnection;822;0;87;0
WireConnection;822;1;823;0
WireConnection;866;2;864;0
WireConnection;1199;1;1197;0
WireConnection;1199;0;1198;0
WireConnection;781;1;788;0
WireConnection;865;2;863;0
WireConnection;1042;0;1038;0
WireConnection;1042;1;1040;0
WireConnection;1041;0;1039;0
WireConnection;1041;1;1040;0
WireConnection;574;0;568;0
WireConnection;574;1;820;0
WireConnection;645;1;15;3
WireConnection;645;2;646;0
WireConnection;827;1;15;3
WireConnection;827;2;830;0
WireConnection;795;1;780;0
WireConnection;795;0;796;0
WireConnection;880;0;885;0
WireConnection;880;1;881;0
WireConnection;377;0;1183;3
WireConnection;777;0;776;0
WireConnection;777;1;775;0
WireConnection;710;0;406;0
WireConnection;784;0;54;0
WireConnection;784;1;442;0
WireConnection;705;0;43;0
WireConnection;816;0;827;0
WireConnection;816;1;343;1
WireConnection;821;0;87;0
WireConnection;821;1;824;0
WireConnection;593;0;590;0
WireConnection;593;1;822;0
WireConnection;867;0;866;0
WireConnection;867;1;865;0
WireConnection;1195;0;1199;0
WireConnection;1195;1;1194;0
WireConnection;797;1;781;0
WireConnection;797;0;798;0
WireConnection;807;0;645;0
WireConnection;807;1;653;0
WireConnection;588;0;574;0
WireConnection;569;0;37;0
WireConnection;778;0;777;0
WireConnection;836;0;755;0
WireConnection;1043;2;1041;0
WireConnection;1168;0;1069;0
WireConnection;891;0;880;0
WireConnection;782;0;795;0
WireConnection;1044;2;1042;0
WireConnection;602;0;604;0
WireConnection;602;1;821;0
WireConnection;806;0;816;0
WireConnection;806;1;807;0
WireConnection;806;2;809;0
WireConnection;868;0;867;0
WireConnection;783;0;797;0
WireConnection;709;0;710;0
WireConnection;552;0;55;0
WireConnection;552;1;441;0
WireConnection;1193;0;1199;0
WireConnection;1193;2;1195;0
WireConnection;1045;0;1043;0
WireConnection;1045;1;1044;0
WireConnection;877;0;728;0
WireConnection;573;0;569;0
WireConnection;573;1;87;0
WireConnection;837;0;778;0
WireConnection;834;0;885;0
WireConnection;834;1;835;0
WireConnection;1169;0;1168;0
WireConnection;534;1;15;1
WireConnection;534;2;533;0
WireConnection;828;1;15;1
WireConnection;828;2;829;0
WireConnection;457;1;782;0
WireConnection;457;2;784;0
WireConnection;732;0;705;0
WireConnection;594;0;593;0
WireConnection;1179;5;44;0
WireConnection;708;0;1193;0
WireConnection;708;1;709;0
WireConnection;708;2;705;0
WireConnection;603;0;602;0
WireConnection;1046;0;1045;0
WireConnection;815;0;828;0
WireConnection;815;1;343;3
WireConnection;519;1;1178;1
WireConnection;519;2;70;0
WireConnection;790;0;457;0
WireConnection;252;0;1179;0
WireConnection;252;1;838;0
WireConnection;889;0;834;0
WireConnection;564;1;573;0
WireConnection;564;0;611;0
WireConnection;731;0;732;0
WireConnection;462;1;783;0
WireConnection;462;2;552;0
WireConnection;886;0;806;0
WireConnection;886;1;892;0
WireConnection;869;0;868;0
WireConnection;393;0;15;2
WireConnection;810;0;189;0
WireConnection;810;1;534;0
WireConnection;932;0;1169;0
WireConnection;875;0;873;0
WireConnection;875;1;876;0
WireConnection;808;0;815;0
WireConnection;808;1;810;0
WireConnection;808;2;809;0
WireConnection;570;0;393;0
WireConnection;791;0;462;0
WireConnection;599;0;71;0
WireConnection;701;0;1193;0
WireConnection;701;1;708;0
WireConnection;701;2;731;0
WireConnection;1047;0;1046;0
WireConnection;657;0;5;0
WireConnection;789;0;519;0
WireConnection;789;1;790;0
WireConnection;1050;1;1048;0
WireConnection;374;0;252;0
WireConnection;374;1;839;0
WireConnection;888;0;886;0
WireConnection;609;1;564;0
WireConnection;609;0;612;0
WireConnection;1171;0;1054;0
WireConnection;1171;1;1172;0
WireConnection;121;0;658;0
WireConnection;121;1;657;0
WireConnection;121;2;599;0
WireConnection;792;0;789;0
WireConnection;792;1;791;0
WireConnection;394;0;570;0
WireConnection;1051;0;1050;3
WireConnection;1051;1;1049;0
WireConnection;610;1;609;0
WireConnection;610;0;613;0
WireConnection;1055;0;1056;0
WireConnection;871;0;374;0
WireConnection;871;1;872;0
WireConnection;871;2;875;0
WireConnection;803;0;701;0
WireConnection;803;1;801;0
WireConnection;898;0;890;0
WireConnection;898;1;808;0
WireConnection;898;2;882;0
WireConnection;804;0;701;0
WireConnection;899;0;806;0
WireConnection;899;1;888;0
WireConnection;899;2;882;0
WireConnection;799;1;519;0
WireConnection;799;0;792;0
WireConnection;1057;0;121;0
WireConnection;1057;1;1055;0
WireConnection;1057;2;1171;0
WireConnection;1129;0;898;0
WireConnection;1129;1;1131;0
WireConnection;1129;2;1130;0
WireConnection;1176;1;804;0
WireConnection;1176;0;803;0
WireConnection;88;0;394;0
WireConnection;88;1;610;0
WireConnection;1052;0;871;0
WireConnection;1052;1;1053;0
WireConnection;1052;2;1051;0
WireConnection;1173;0;899;0
WireConnection;1173;2;1174;0
WireConnection;501;0;1057;0
WireConnection;496;0;1052;0
WireConnection;580;0;88;0
WireConnection;487;0;1176;0
WireConnection;636;0;1173;0
WireConnection;584;0;1129;0
WireConnection;553;0;799;0
WireConnection;0;0;515;0
WireConnection;0;1;499;0
WireConnection;0;2;581;0
WireConnection;0;3;635;0
WireConnection;0;4;586;0
WireConnection;0;5;554;0
WireConnection;0;10;491;0
ASEEND*/
//CHKSM=64921CBB973CED1702676AD1CA3CACBCD9D77585