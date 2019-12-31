// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/PostProcess/Pixelize/ScreenAndMask"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		
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
			#include "UnityShaderVariables.cginc"


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
				float4 ase_texcoord4 : TEXCOORD4;
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float3 _SpherePosition;
			uniform sampler2D _CameraDepthTexture;
			uniform float _SphereRadius;
			uniform float _MaskDensity;
			uniform float _MaskExponent;

			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord4 = screenPos;
				
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
				float3 CamPosition11_g2 = _WorldSpaceCameraPos;
				float3 SphereCenter4_g2 = _SpherePosition;
				float3 SphereToCam17_g2 = ( CamPosition11_g2 - SphereCenter4_g2 );
				float4 screenPos = i.ase_texcoord4;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float4 tex2DNode36_g1 = tex2D( _CameraDepthTexture, ase_screenPosNorm.xy );
				#ifdef UNITY_REVERSED_Z
				float4 staticSwitch38_g1 = ( 1.0 - tex2DNode36_g1 );
				#else
				float4 staticSwitch38_g1 = tex2DNode36_g1;
				#endif
				float3 appendResult39_g1 = (float3(ase_screenPosNorm.x , ase_screenPosNorm.y , staticSwitch38_g1.r));
				float4 appendResult42_g1 = (float4((appendResult39_g1*2.0 + -1.0) , 1.0));
				float4 temp_output_43_0_g1 = mul( unity_CameraInvProjection, appendResult42_g1 );
				float4 appendResult49_g1 = (float4(( ( (temp_output_43_0_g1).xyz / (temp_output_43_0_g1).w ) * float3( 1,1,-1 ) ) , 1.0));
				float3 WorldPosition122_g2 = mul( unity_CameraToWorld, appendResult49_g1 ).xyz;
				float3 temp_output_9_0_g2 = ( _WorldSpaceCameraPos - WorldPosition122_g2 );
				float3 normalizeResult10_g2 = normalize( temp_output_9_0_g2 );
				float3 ViewDirection12_g2 = normalizeResult10_g2;
				float dotResult20_g2 = dot( SphereToCam17_g2 , ViewDirection12_g2 );
				float DirectionsSimilarity21_g2 = dotResult20_g2;
				float dotResult24_g2 = dot( SphereToCam17_g2 , SphereToCam17_g2 );
				float SphereRadius5_g2 = _SphereRadius;
				float Ratio25_g2 = ( ( DirectionsSimilarity21_g2 * DirectionsSimilarity21_g2 ) - ( dotResult24_g2 - ( SphereRadius5_g2 * SphereRadius5_g2 ) ) );
				float SqrtRatio37_g2 = sqrt( Ratio25_g2 );
				float temp_output_40_0_g2 = ( SqrtRatio37_g2 + -DirectionsSimilarity21_g2 );
				float DistanceToPixel114_g2 = -length( temp_output_9_0_g2 );
				float RejectionValue162_g2 = (( temp_output_40_0_g2 < DistanceToPixel114_g2 ) ? -1.0 :  Ratio25_g2 );
				float temp_output_41_0_g2 = ( -DirectionsSimilarity21_g2 - SqrtRatio37_g2 );
				float3 ExitPoint44_g2 = ( CamPosition11_g2 + ( ViewDirection12_g2 * max( temp_output_41_0_g2 , DistanceToPixel114_g2 ) ) );
				float DistanceToEntryPoint139_g2 = temp_output_40_0_g2;
				float3 EntryPoint45_g2 = ( ( DistanceToEntryPoint139_g2 * ViewDirection12_g2 ) + CamPosition11_g2 );
				float temp_output_170_0_g2 = ( 1.0 - ( distance( SphereCenter4_g2 , ( ( ExitPoint44_g2 + EntryPoint45_g2 ) * float3( 0.5,0.5,0.5 ) ) ) / SphereRadius5_g2 ) );
				float LinearDensity173_g2 = temp_output_170_0_g2;
				float4 appendResult136 = (float4(tex2D( _MainTex, i.uv.xy ).rgb , pow( ( (( RejectionValue162_g2 < 0.0 ) ? 0.0 :  LinearDensity173_g2 ) * _MaskDensity ) , _MaskExponent )));
				

				finalColor = appendResult136;

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16304
1722;92;1161;923;-154.8722;649.91;1.449605;True;False
Node;AmplifyShaderEditor.Vector3Node;4;380.8583,44.91288;Float;False;Global;_SpherePosition;_SpherePosition;7;0;Create;True;0;0;False;0;0,0,0;0,1.5,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;10;379.863,211.7047;Float;False;Global;_SphereRadius;_SphereRadius;2;0;Create;True;0;0;False;0;1;6;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;140;220.753,-42.58594;Float;False;Reconstruct World Position From Depth;0;;1;e7094bcbcc80eb140b2a3dbe6a861de8;0;0;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;8;993.168,198.614;Float;False;Global;_MaskDensity;_MaskDensity;2;0;Create;True;0;0;False;0;1;4.9;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;141;724.8454,-38.27131;Float;False;Compute Volumetric Sphere;-1;;2;21b394060dee4e24d99ea8f6db991160;2,164,1,154,1;3;3;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;1;False;7;FLOAT;97;FLOAT;178;FLOAT;88;FLOAT;0;FLOAT3;68;FLOAT3;75;INT;53
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;1362.593,152.5419;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;137;1240.171,296.0089;Float;False;Global;_MaskExponent;_MaskExponent;2;0;Create;True;0;0;False;0;3;3;0.2;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;131;752.8643,-365.0398;Float;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1;673.2322,-285.6174;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;139;1581.171,162.0089;Float;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;132;937.8646,-362.0398;Float;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;136;1872.132,-94.7847;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;2109.486,-96.0928;Float;False;True;2;Float;ASEMaterialInspector;0;2;Hidden/PostProcess/Pixelize/ScreenAndMask;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;141;3;140;0
WireConnection;141;1;4;0
WireConnection;141;2;10;0
WireConnection;9;0;141;97
WireConnection;9;1;8;0
WireConnection;139;0;9;0
WireConnection;139;1;137;0
WireConnection;132;0;131;0
WireConnection;132;1;1;0
WireConnection;136;0;132;0
WireConnection;136;3;139;0
WireConnection;0;0;136;0
ASEEND*/
//CHKSM=6B2FEFF5038291CDD78AE92807ECD78FC43BB37D