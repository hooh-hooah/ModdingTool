// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/MultiPassDistortion"
{
	Properties
	{
		_DistortionAmount("Distortion Amount", Range( 0 , 0.1)) = 0.292
		_DepthFadeDistance("Depth Fade Distance", Float) = 0
		_TextureSample1("Texture Sample 1", 2D) = "bump" {}
		_TimeScale("Time Scale", Float) = 0
		_ForcefieldTint("Forcefield Tint", Color) = (0,0,0,0)
		_IntersectionColor("Intersection Color", Color) = (0.4338235,0.4377282,1,0)
		_FresnelPower("Fresnel Power", Float) = 0
		_FresnelScale("Fresnel Scale", Float) = 0
	}
	
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		
		Pass
		{
			
			Name "First Pass"
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Off
			ColorMask RGBA
			ZWrite Off
			ZTest LEqual
			Offset 0 , 0
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform float4 _IntersectionColor;
			uniform sampler2D _CameraDepthTexture;
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _DepthFadeDistance;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord = screenPos;
				
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float4 IntersectionColor184 = _IntersectionColor;
				float4 screenPos = i.ase_texcoord;
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth146 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( screenPos ))));
				float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFadeDistance ) );
				float SaturatedDepthFade186 = saturate( distanceDepth146 );
				float4 appendResult143 = (float4((IntersectionColor184).rgb , ( 1.0 - SaturatedDepthFade186 )));
				
				
				finalColor = appendResult143;
				return finalColor;
			}
			ENDCG
		}

		GrabPass{ }

		Pass
		{
			Name "Second Pass"
			
			CGINCLUDE
			#pragma target 3.0
			ENDCG
			Blend SrcAlpha OneMinusSrcAlpha
			Cull Back
			ColorMask RGBA
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "UnityStandardUtils.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
				float3 ase_normal : NORMAL;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
			};

			uniform sampler2D _GrabTexture;
			uniform float _DistortionAmount;
			uniform sampler2D _TextureSample1;
			uniform float _TimeScale;
			uniform float4 _ForcefieldTint;
			uniform float4 _IntersectionColor;
			uniform float _FresnelScale;
			uniform float _FresnelPower;
			uniform sampler2D _CameraDepthTexture;
			uniform float4 _CameraDepthTexture_TexelSize;
			uniform float _DepthFadeDistance;
			inline float4 ASE_ComputeGrabScreenPos( float4 pos )
			{
				#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
				#else
				float scale = 1.0;
				#endif
				float4 o = pos;
				o.y = pos.w * 0.5f;
				o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
				return o;
			}
			
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float4 ase_clipPos = UnityObjectToClipPos(v.vertex);
				float4 screenPos = ComputeScreenPos(ase_clipPos);
				o.ase_texcoord1 = screenPos;
				float3 ase_worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.ase_texcoord2.xyz = ase_worldPos;
				float3 ase_worldNormal = UnityObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord3.xyz = ase_worldNormal;
				
				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				o.ase_texcoord2.w = 0;
				o.ase_texcoord3.w = 0;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float2 uv160 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float mulTime169 = _Time.y * _TimeScale;
				float cos162 = cos( mulTime169 );
				float sin162 = sin( mulTime169 );
				float2 rotator162 = mul( uv160 - float2( 0.5,0.5 ) , float2x2( cos162 , -sin162 , sin162 , cos162 )) + float2( 0.5,0.5 );
				float4 screenPos = i.ase_texcoord1;
				float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( screenPos );
				float4 ase_grabScreenPosNorm = ase_grabScreenPos / ase_grabScreenPos.w;
				float4 screenColor151 = tex2D( _GrabTexture, ( float4( UnpackScaleNormal( tex2D( _TextureSample1, rotator162 ), _DistortionAmount ) , 0.0 ) + ase_grabScreenPosNorm ).xy );
				float4 IntersectionColor184 = _IntersectionColor;
				float3 ase_worldPos = i.ase_texcoord2.xyz;
				float3 ase_worldViewDir = UnityWorldSpaceViewDir(ase_worldPos);
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_worldNormal = i.ase_texcoord3.xyz;
				float fresnelNdotV175 = dot( ase_worldNormal, ase_worldViewDir );
				float fresnelNode175 = ( 0.0 + _FresnelScale * pow( 1.0 - fresnelNdotV175, _FresnelPower ) );
				float4 lerpResult179 = lerp( ( float4( (screenColor151).rgb , 0.0 ) * _ForcefieldTint ) , ( IntersectionColor184 * fresnelNode175 ) , fresnelNode175);
				float4 ase_screenPosNorm = screenPos / screenPos.w;
				ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
				float screenDepth146 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD( screenPos ))));
				float distanceDepth146 = abs( ( screenDepth146 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFadeDistance ) );
				float SaturatedDepthFade186 = saturate( distanceDepth146 );
				float4 appendResult154 = (float4((lerpResult179).rgb , SaturatedDepthFade186));
				
				
				finalColor = appendResult154;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16301
296;303;1066;701;-2409.089;1187.519;1.912795;True;False
Node;AmplifyShaderEditor.CommentaryNode;190;1061.024,-968.78;Float;False;1820.48;460.2398;;13;171;167;151;189;152;164;150;160;162;159;170;169;163;Calculate and apply Distortion;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;170;1111.024,-662.78;Float;False;Property;_TimeScale;Time Scale;3;0;Create;True;0;0;False;0;0;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;169;1271.024,-662.78;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;159;1271.024,-790.78;Float;False;Constant;_Vector0;Vector 0;-1;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TextureCoordinatesNode;160;1223.024,-918.78;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;188;1586,-1560.752;Float;False;1268.871;416.1864;;9;143;174;148;184;186;149;172;146;147;First Pass only renders intersection;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;162;1495.024,-838.78;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;163;1495.024,-710.78;Float;False;Property;_DistortionAmount;Distortion Amount;0;0;Create;True;0;0;False;0;0.292;0.01662117;0;0.1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;164;1783.024,-902.78;Float;True;Property;_TextureSample1;Texture Sample 1;2;0;Create;True;0;0;False;0;None;302951faffe230848aa0d3df7bb70faa;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;172;1940,-1508;Float;False;Property;_IntersectionColor;Intersection Color;5;0;Create;True;0;0;False;0;0.4338235,0.4377282,1,0;0.485294,0.4888435,1,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;191;2194.36,-413.8124;Float;False;752.7268;415.7021;;5;185;175;183;182;181;Adding Rim effect;1,1,1,1;0;0
Node;AmplifyShaderEditor.GrabScreenPosition;150;1847.024,-694.78;Float;False;0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;152;2103.025,-806.78;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;184;2180,-1508;Float;False;IntersectionColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;182;2244.36,-121.5248;Float;False;Property;_FresnelPower;Fresnel Power;6;0;Create;True;0;0;False;0;0;2.32;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;183;2260.36,-217.5248;Float;False;Property;_FresnelScale;Fresnel Scale;7;0;Create;True;0;0;False;0;0;1.99;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;185;2427.82,-355.7924;Float;False;184;IntersectionColor;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;147;1636,-1252;Float;False;Property;_DepthFadeDistance;Depth Fade Distance;1;0;Create;True;0;0;False;0;0;0.4;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ScreenColorNode;151;2248.941,-881.3849;Float;False;Global;_GrabScreen0;Grab Screen 0;2;0;Create;True;0;0;False;0;Object;-1;False;False;1;0;FLOAT2;0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FresnelNode;175;2455.879,-251.1103;Float;True;Standard;WorldNormal;ViewDir;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;189;2463.987,-870.9428;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DepthFade;146;1876,-1268;Float;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;181;2778.086,-363.8124;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;171;2448,-784;Float;False;Property;_ForcefieldTint;Forcefield Tint;4;0;Create;True;0;0;False;0;0,0,0,0;0.5294118,1,0.6689655,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;194;2955.211,-272.4411;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;149;2068,-1268;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;167;2704,-800;Float;False;2;2;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.WireNode;193;2972.06,-399.5829;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;192;3064.798,-606.6831;Float;False;668.4583;299.6378;;4;180;154;187;179;Combining everything through generated alphas;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;186;2244,-1300;Float;False;SaturatedDepthFade;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;179;3114.798,-513.8989;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ComponentMaskNode;180;3323.008,-556.6831;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;187;3292.39,-422.0453;Float;False;186;SaturatedDepthFade;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;154;3560.256,-498.2751;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;174;2414.56,-1510.752;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;148;2500.241,-1323.973;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;143;2682.616,-1443.884;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;138;3778.501,-515.9439;Float;False;False;2;Float;ASEMaterialInspector;0;15;ASETemplateShaders/DoublePassUnlit;003dfa9c16768d048b74f75c088119d8;True;Second;0;1;Second Pass;2;False;False;False;False;False;False;False;False;False;True;1;RenderType=Opaque=RenderType;False;0;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;True;2;0;;0;0;Standard;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;135;2913.303,-1447.391;Float;False;True;2;Float;ASEMaterialInspector;0;15;ASESampleShaders/MultiPassDistortion;003dfa9c16768d048b74f75c088119d8;True;First;0;0;First Pass;2;False;False;False;False;False;False;False;False;False;True;2;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;False;0;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;2;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;2;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;0;True;2;0;;0;0;Standard;0;0;2;True;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;169;0;170;0
WireConnection;162;0;160;0
WireConnection;162;1;159;0
WireConnection;162;2;169;0
WireConnection;164;1;162;0
WireConnection;164;5;163;0
WireConnection;152;0;164;0
WireConnection;152;1;150;0
WireConnection;184;0;172;0
WireConnection;151;0;152;0
WireConnection;175;2;183;0
WireConnection;175;3;182;0
WireConnection;189;0;151;0
WireConnection;146;0;147;0
WireConnection;181;0;185;0
WireConnection;181;1;175;0
WireConnection;194;0;175;0
WireConnection;149;0;146;0
WireConnection;167;0;189;0
WireConnection;167;1;171;0
WireConnection;193;0;181;0
WireConnection;186;0;149;0
WireConnection;179;0;167;0
WireConnection;179;1;193;0
WireConnection;179;2;194;0
WireConnection;180;0;179;0
WireConnection;154;0;180;0
WireConnection;154;3;187;0
WireConnection;174;0;184;0
WireConnection;148;0;186;0
WireConnection;143;0;174;0
WireConnection;143;3;148;0
WireConnection;138;0;154;0
WireConnection;135;0;143;0
ASEEND*/
//CHKSM=A758A5D3C80D58BE849D94748B6856C7D2410609