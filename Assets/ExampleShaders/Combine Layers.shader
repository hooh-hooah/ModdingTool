// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/PostProcess/Pixelize/CombineLayers"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		[Toggle(_INTERPOLATE_LAYERS_ON)] _INTERPOLATE_LAYERS("INTERPOLATE_LAYERS", Float) = 0
		[Toggle(_DEBUG_MASK_ON)] _DEBUG_MASK("DEBUG_MASK", Float) = 0
	}

	SubShader
	{
		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#pragma shader_feature _DEBUG_MASK_ON
			#pragma shader_feature _INTERPOLATE_LAYERS_ON


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform int _MaxPixelizationLevel;
			float4 CombineLayers148( sampler2D ScreenAndMaskTexture , float2 UV , int MaxLayers , out float SphereMask )
			{
				float4 color = tex2D(ScreenAndMaskTexture, UV);
				SphereMask = color.w;
				const float layerWidth = rcp(MaxLayers);
				float previousThreshold = 0.0f;
				for (int i = 1; i <= MaxLayers; ++i)
				{
					float4 layerColor = tex2Dlod(ScreenAndMaskTexture, float4(UV, 0, i));
					float newThreshold = i * layerWidth;
					float mask;
					#if defined(_INTERPOLATE_LAYERS_ON)
					mask = saturate((layerColor.w - previousThreshold) / (newThreshold - previousThreshold)); // clamped inverse lerp   
					previousThreshold = newThreshold;
					#else
					mask = step(newThreshold, layerColor.w);
					#endif
					color = lerp(color, layerColor, mask);
				}
				return color;
			}
			

			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos ( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				sampler2D ScreenAndMaskTexture148 = _MainTex;
				float2 UV148 = i.uv.xy;
				int MaxLayers148 = _MaxPixelizationLevel;
				float SphereMask148 = 0.0;
				float4 localCombineLayers148 = CombineLayers148( ScreenAndMaskTexture148 , UV148 , MaxLayers148 , SphereMask148 );
				#ifdef _INTERPOLATE_LAYERS_ON
				float4 staticSwitch153 = localCombineLayers148;
				#else
				float4 staticSwitch153 = localCombineLayers148;
				#endif
				float3 temp_cast_0 = (SphereMask148).xxx;
				float3 temp_cast_1 = (SphereMask148).xxx;
				float3 gammaToLinear154 = GammaToLinearSpace( temp_cast_1 );
				#ifdef _DEBUG_MASK_ON
				float4 staticSwitch145 = float4( gammaToLinear154 , 0.0 );
				#else
				float4 staticSwitch145 = staticSwitch153;
				#endif
				

				finalColor = staticSwitch145;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16304
2027;92;856;740;-1823.932;1188.114;1.696211;False;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;2;2008.631,-476.6076;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;2040.631,-572.6075;Float;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;151;1960.632,-332.6076;Float;False;Global;_MaxPixelizationLevel;_MaxPixelizationLevel;1;0;Create;True;0;0;False;0;5;5;0;1;INT;0
Node;AmplifyShaderEditor.CustomExpressionNode;148;2280.631,-508.6076;Float;False;float4 color = tex2D(ScreenAndMaskTexture, UV)@$SphereMask = color.w@$const float layerWidth = rcp(MaxLayers)@$float previousThreshold = 0.0f@$$for (int i = 1@ i <= MaxLayers@ ++i)${$	float4 layerColor = tex2Dlod(ScreenAndMaskTexture, float4(UV, 0, i))@$	float newThreshold = i * layerWidth@$	float mask@$	#if defined(_INTERPOLATE_LAYERS_ON)$	mask = saturate((layerColor.w - previousThreshold) / (newThreshold - previousThreshold))@ // clamped inverse lerp   $	previousThreshold = newThreshold@$	#else$	mask = step(newThreshold, layerColor.w)@$	#endif$	color = lerp(color, layerColor, mask)@$}$$return color@;4;False;4;True;ScreenAndMaskTexture;SAMPLER2D;;In;;Float;True;UV;FLOAT2;0,0;In;;Float;True;MaxLayers;INT;5;In;;Float;True;SphereMask;FLOAT;0;Out;;Float;Combine Layers;True;False;0;4;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;INT;5;False;3;FLOAT;0;False;2;FLOAT4;0;FLOAT;4
Node;AmplifyShaderEditor.GammaToLinearNode;154;2819.606,-438.3885;Float;False;0;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;153;2762.428,-549.3163;Float;False;Property;_INTERPOLATE_LAYERS;INTERPOLATE_LAYERS;0;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;145;3264.128,-518.7849;Float;False;Property;_DEBUG_MASK;DEBUG_MASK;1;0;Create;True;0;0;False;0;0;0;0;True;;Toggle;2;Key0;Key1;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;3632,-512;Float;False;True;2;Float;ASEMaterialInspector;0;2;Hidden/PostProcess/Pixelize/CombineLayers;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;148;0;1;0
WireConnection;148;1;2;0
WireConnection;148;2;151;0
WireConnection;154;0;148;4
WireConnection;153;1;148;0
WireConnection;153;0;148;0
WireConnection;145;1;153;0
WireConnection;145;0;154;0
WireConnection;0;0;145;0
ASEEND*/
//CHKSM=E249BAD91DA4F83695DA86709273EBF5F3CED785