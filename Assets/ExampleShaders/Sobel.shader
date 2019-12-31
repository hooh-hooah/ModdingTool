// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Post Process/Sobel"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Intensity("Intensity", Float) = 1
		_Step("Step", Float) = 0
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
			
			uniform float _Step;
			uniform float _Intensity;

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
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 localCenter138_g194 = uv_MainTex;
				float temp_output_2_0_g194 = ( _MainTex_TexelSize * _Step ).x;
				float localNegStepX156_g194 = -temp_output_2_0_g194;
				float temp_output_3_0_g194 = ( _MainTex_TexelSize * _Step ).y;
				float localStepY164_g194 = temp_output_3_0_g194;
				float2 appendResult14_g202 = (float2(localNegStepX156_g194 , localStepY164_g194));
				float4 tex2DNode16_g202 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g202 ) );
				float temp_output_2_0_g202 = (tex2DNode16_g202).r;
				float temp_output_4_0_g202 = (tex2DNode16_g202).g;
				float temp_output_5_0_g202 = (tex2DNode16_g202).b;
				float localTopLeft172_g194 = ( sqrt( ( ( ( temp_output_2_0_g202 * temp_output_2_0_g202 ) + ( temp_output_4_0_g202 * temp_output_4_0_g202 ) ) + ( temp_output_5_0_g202 * temp_output_5_0_g202 ) ) ) * _Intensity );
				float2 appendResult14_g198 = (float2(localNegStepX156_g194 , 0.0));
				float4 tex2DNode16_g198 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g198 ) );
				float temp_output_2_0_g198 = (tex2DNode16_g198).r;
				float temp_output_4_0_g198 = (tex2DNode16_g198).g;
				float temp_output_5_0_g198 = (tex2DNode16_g198).b;
				float localLeft173_g194 = ( sqrt( ( ( ( temp_output_2_0_g198 * temp_output_2_0_g198 ) + ( temp_output_4_0_g198 * temp_output_4_0_g198 ) ) + ( temp_output_5_0_g198 * temp_output_5_0_g198 ) ) ) * _Intensity );
				float localNegStepY165_g194 = -temp_output_3_0_g194;
				float2 appendResult14_g201 = (float2(localNegStepX156_g194 , localNegStepY165_g194));
				float4 tex2DNode16_g201 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g201 ) );
				float temp_output_2_0_g201 = (tex2DNode16_g201).r;
				float temp_output_4_0_g201 = (tex2DNode16_g201).g;
				float temp_output_5_0_g201 = (tex2DNode16_g201).b;
				float localBottomLeft174_g194 = ( sqrt( ( ( ( temp_output_2_0_g201 * temp_output_2_0_g201 ) + ( temp_output_4_0_g201 * temp_output_4_0_g201 ) ) + ( temp_output_5_0_g201 * temp_output_5_0_g201 ) ) ) * _Intensity );
				float localStepX160_g194 = temp_output_2_0_g194;
				float2 appendResult14_g195 = (float2(localStepX160_g194 , localStepY164_g194));
				float4 tex2DNode16_g195 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g195 ) );
				float temp_output_2_0_g195 = (tex2DNode16_g195).r;
				float temp_output_4_0_g195 = (tex2DNode16_g195).g;
				float temp_output_5_0_g195 = (tex2DNode16_g195).b;
				float localTopRight177_g194 = ( sqrt( ( ( ( temp_output_2_0_g195 * temp_output_2_0_g195 ) + ( temp_output_4_0_g195 * temp_output_4_0_g195 ) ) + ( temp_output_5_0_g195 * temp_output_5_0_g195 ) ) ) * _Intensity );
				float2 appendResult14_g196 = (float2(localStepX160_g194 , 0.0));
				float4 tex2DNode16_g196 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g196 ) );
				float temp_output_2_0_g196 = (tex2DNode16_g196).r;
				float temp_output_4_0_g196 = (tex2DNode16_g196).g;
				float temp_output_5_0_g196 = (tex2DNode16_g196).b;
				float localRight178_g194 = ( sqrt( ( ( ( temp_output_2_0_g196 * temp_output_2_0_g196 ) + ( temp_output_4_0_g196 * temp_output_4_0_g196 ) ) + ( temp_output_5_0_g196 * temp_output_5_0_g196 ) ) ) * _Intensity );
				float2 appendResult14_g197 = (float2(localStepX160_g194 , localNegStepY165_g194));
				float4 tex2DNode16_g197 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g197 ) );
				float temp_output_2_0_g197 = (tex2DNode16_g197).r;
				float temp_output_4_0_g197 = (tex2DNode16_g197).g;
				float temp_output_5_0_g197 = (tex2DNode16_g197).b;
				float localBottomRight179_g194 = ( sqrt( ( ( ( temp_output_2_0_g197 * temp_output_2_0_g197 ) + ( temp_output_4_0_g197 * temp_output_4_0_g197 ) ) + ( temp_output_5_0_g197 * temp_output_5_0_g197 ) ) ) * _Intensity );
				float temp_output_133_0_g194 = ( ( localTopLeft172_g194 + ( localLeft173_g194 * 2 ) + localBottomLeft174_g194 + -localTopRight177_g194 + ( localRight178_g194 * -2 ) + -localBottomRight179_g194 ) / 6.0 );
				float2 appendResult14_g200 = (float2(0.0 , localStepY164_g194));
				float4 tex2DNode16_g200 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g200 ) );
				float temp_output_2_0_g200 = (tex2DNode16_g200).r;
				float temp_output_4_0_g200 = (tex2DNode16_g200).g;
				float temp_output_5_0_g200 = (tex2DNode16_g200).b;
				float localTop175_g194 = ( sqrt( ( ( ( temp_output_2_0_g200 * temp_output_2_0_g200 ) + ( temp_output_4_0_g200 * temp_output_4_0_g200 ) ) + ( temp_output_5_0_g200 * temp_output_5_0_g200 ) ) ) * _Intensity );
				float2 appendResult14_g199 = (float2(0.0 , localNegStepY165_g194));
				float4 tex2DNode16_g199 = tex2D( _MainTex, ( localCenter138_g194 + appendResult14_g199 ) );
				float temp_output_2_0_g199 = (tex2DNode16_g199).r;
				float temp_output_4_0_g199 = (tex2DNode16_g199).g;
				float temp_output_5_0_g199 = (tex2DNode16_g199).b;
				float localBottom176_g194 = ( sqrt( ( ( ( temp_output_2_0_g199 * temp_output_2_0_g199 ) + ( temp_output_4_0_g199 * temp_output_4_0_g199 ) ) + ( temp_output_5_0_g199 * temp_output_5_0_g199 ) ) ) * _Intensity );
				float temp_output_135_0_g194 = ( ( -localTopLeft172_g194 + ( localTop175_g194 * -2 ) + -localTopRight177_g194 + localBottomLeft174_g194 + ( localBottom176_g194 * 2 ) + localBottomRight179_g194 ) / 6.0 );
				float temp_output_111_0_g194 = sqrt( ( ( temp_output_133_0_g194 * temp_output_133_0_g194 ) + ( temp_output_135_0_g194 * temp_output_135_0_g194 ) ) );
				float3 appendResult113_g194 = (float3(temp_output_111_0_g194 , temp_output_111_0_g194 , temp_output_111_0_g194));
				float3 temp_output_39_0 = appendResult113_g194;
				

				finalColor = float4( temp_output_39_0 , 0.0 );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14302
389;92;1064;673;-292.4488;435.6547;1.3;False;False
Node;AmplifyShaderEditor.RangedFloatNode;18;-200.715,-0.244751;Float;False;Property;_Step;Step;0;0;Create;True;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;12;-222.5603,-127.1968;Float;False;_MainTex_TexelSize;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;27.76758,-65.4624;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-83.01637,247.0819;Float;False;_MainTex;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;13;231.7997,-137.4999;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;213.2001,216.7001;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;827.4486,27.84405;Float;False;2;2;0;FLOAT3;0,0,0,0;False;1;COLOR;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;39;553.4998,-47.19983;Float;False;SobelMain;-1;;194;481788033fe47cd4893d0d4673016cbc;0;4;2;FLOAT;0.0;False;3;FLOAT;0.0;False;4;FLOAT2;0,0;False;1;SAMPLER2D;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;951.5491,184.7441;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;22;522.5495,353.7439;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;21;542.3502,128.5439;Float;False;Property;_Color0;Color 0;1;0;Create;True;0,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMasterNode;26;1093.604,-156.7999;Float;False;True;2;Float;ASEMaterialInspector;0;1;ASESampleShaders/Post Process/Sobel;c71b220b631b6344493ea3cf87110c93;ASETemplateShaders/PostProcess;Off;2;7;0;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;17;0;12;0
WireConnection;17;1;18;0
WireConnection;13;0;17;0
WireConnection;6;2;1;0
WireConnection;19;0;39;0
WireConnection;19;1;21;0
WireConnection;39;2;13;0
WireConnection;39;3;13;1
WireConnection;39;4;6;0
WireConnection;39;1;1;0
WireConnection;23;0;19;0
WireConnection;23;1;22;0
WireConnection;22;0;1;0
WireConnection;22;1;6;0
WireConnection;26;0;39;0
ASEEND*/
//CHKSM=695AB4DD693DC3FF3EF37007CD12B23A9515B963
