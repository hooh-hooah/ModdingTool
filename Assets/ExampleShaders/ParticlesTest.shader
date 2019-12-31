// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/HeatHaze"
{
	Properties
	{
		_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
		_MainTex ("Particle Texture", 2D) = "white" {}
		_InvFade ("Soft Particles Factor", Range(0.01,3.0)) = 1.0
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_HazeHAmp("HazeHAmp", Float) = 0
		_HazeHFreq("HazeHFreq", Float) = 0
		_HazeVSpeed("HazeVSpeed", Float) = 0
		_HazeNormalIntensity("HazeNormalIntensity", Range( 0 , 1)) = 0.1
		_HazeMask("HazeMask", 2D) = "white" {}
	}

	Category 
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane"  }
		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask RGB
		Cull Off Lighting Off ZWrite Off
		
		SubShader
		{
			GrabPass{ "GrabScreen0" }

			Pass {
			
				CGPROGRAM
				#pragma vertex vert
				#pragma fragment frag
				#pragma target 2.0
				#pragma multi_compile_particles
				#pragma multi_compile_fog
				#include "UnityShaderVariables.cginc"


				#include "UnityCG.cginc"

				struct appdata_t 
				{
					float4 vertex : POSITION;
					fixed4 color : COLOR;
					float4 texcoord : TEXCOORD0;
				};

				struct v2f 
				{
					float4 vertex : SV_POSITION;
					fixed4 color : COLOR;
					float4 texcoord : TEXCOORD0;
					UNITY_FOG_COORDS(1)
					#ifdef SOFTPARTICLES_ON
					float4 projPos : TEXCOORD2;
					#endif
					float4 ase_texcoord3 : TEXCOORD3;
				};
				
				uniform sampler2D _MainTex;
				uniform fixed4 _TintColor;
				uniform float4 _MainTex_ST;
				uniform sampler2D_float _CameraDepthTexture;
				uniform float _InvFade;
				uniform sampler2D GrabScreen0;
				uniform sampler2D _TextureSample0;
				uniform float _HazeHAmp;
				uniform float _HazeHFreq;
				uniform float _HazeVSpeed;
				uniform float _HazeNormalIntensity;
				uniform sampler2D _HazeMask;
				uniform float4 _HazeMask_ST;

				v2f vert ( appdata_t v  )
				{
					v2f o;
					float4 clipPos = UnityObjectToClipPos(v.vertex.xyz);
					float4 screenPos = ComputeScreenPos(clipPos);
					o.ase_texcoord3 = screenPos;

					o.vertex.xyz +=  float3( 0, 0, 0 ) ;
					o.vertex = UnityObjectToClipPos(v.vertex);
					#ifdef SOFTPARTICLES_ON
						o.projPos = ComputeScreenPos (o.vertex);
						COMPUTE_EYEDEPTH(o.projPos.z);
					#endif
					o.color = v.color;
					o.texcoord = v.texcoord;
					o.texcoord.xy = TRANSFORM_TEX(v.texcoord,_MainTex);
					UNITY_TRANSFER_FOG(o,o.vertex);
					return o;
				}

				fixed4 frag ( v2f i  ) : SV_Target
				{
					#ifdef SOFTPARTICLES_ON
						float sceneZ = LinearEyeDepth (SAMPLE_DEPTH_TEXTURE_PROJ(_CameraDepthTexture, UNITY_PROJ_COORD(i.projPos)));
						float partZ = i.projPos.z;
						float fade = saturate (_InvFade * (sceneZ-partZ));
						i.color.a *= fade;
					#endif

					float4 screenPos = i.ase_texcoord3;
					float4 screenPos60 = screenPos;
					#if UNITY_UV_STARTS_AT_TOP
					float scale60 = -1.0;
					#else
					float scale60 = 1.0;
					#endif
					float halfPosW60 = screenPos60.w * 0.5;
					screenPos60.y = ( screenPos60.y - halfPosW60 ) * _ProjectionParams.x* scale60 + halfPosW60;
					screenPos60.xyzw /= screenPos60.w;
					float mulTime101 = _Time.y * _HazeHFreq;
					float mulTime38 = _Time.y * _HazeVSpeed;
					float2 appendResult112 = (float2(( _HazeHAmp * cos( mulTime101 ) ) , -mulTime38));
					float2 uv91 = i.texcoord * float2( 1,1 ) + appendResult112;
					float4 screenColor27 = tex2Dproj( GrabScreen0, UNITY_PROJ_COORD( ( screenPos60 + float4( ( UnpackNormal( tex2D( _TextureSample0, uv91 ) ) * _HazeNormalIntensity ) , 0.0 ) ) ) );
					float2 uv_HazeMask = i.texcoord * _HazeMask_ST.xy + _HazeMask_ST.zw;
					float4 appendResult113 = (float4(( (i.color).rgb * (screenColor27).rgb * (_TintColor).rgb ) , ( i.color.a * (_TintColor).a * tex2D( _HazeMask, uv_HazeMask ).r )));

					fixed4 col = appendResult113;
					UNITY_APPLY_FOG(i.fogCoord, col);
					return col;
				}
				ENDCG 
			}
		}	
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13202
487;574;979;444;1162.729;167.988;3.501128;False;False
Node;AmplifyShaderEditor.RangedFloatNode;97;-1060.256,596.4069;Float;False;Property;_HazeHFreq;HazeHFreq;4;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;42;-1092.361,749.8011;Float;False;Property;_HazeVSpeed;HazeVSpeed;1;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;101;-866.9058,625.057;Float;False;1;0;FLOAT;10.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;98;-1008.256,404.4069;Float;False;Property;_HazeHAmp;HazeHAmp;5;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.CosOpNode;43;-622.7609,632.7004;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleTimeNode;38;-887.6616,766.1013;Float;False;1;0;FLOAT;10.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;99;-465.2556,502.4069;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.NegateNode;93;-615.2629,711.0054;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;112;-373.5554,733.6063;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.TextureCoordinatesNode;91;-212.8628,783.0061;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;71;148.1356,688.5034;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;73;174.0337,897.8049;Float;False;Property;_HazeNormalIntensity;HazeNormalIntensity;4;0;0.1;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;520.1356,664.5034;Float;False;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.GrabScreenPosition;60;301.9374,263.3016;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;35;685.4393,307.6021;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.VertexColorNode;58;904.1384,93.60117;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ScreenColorNode;27;849.1401,398.602;Float;False;Global;GrabScreen0;Grab Screen 0;0;0;Object;-1;True;1;0;FLOAT4;0,0,0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;46;816.9399,672.4011;Float;False;_TintColor;0;1;COLOR
Node;AmplifyShaderEditor.SwizzleNode;106;1135.945,174.8068;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SwizzleNode;107;1097.944,632.006;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SwizzleNode;108;1065.145,491.4068;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.VertexColorNode;111;1311.144,690.1075;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SwizzleNode;110;1072.945,972.5054;Float;False;FLOAT;3;1;2;3;1;0;COLOR;0.0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;50;1230.135,1087.298;Float;True;Property;_HazeMask;HazeMask;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;1265.941,322.6024;Float;False;3;3;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0.0,0,0,0;False;2;FLOAT3;0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;1563.945,788.0067;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;113;1794.244,531.6075;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.TemplateMasterNode;26;1990.198,502.702;Float;False;True;2;Float;ASEMaterialInspector;0;5;ASESampleShaders/HeatHaze;0b6a9f8b4f707c74ca64c0be8e590de0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;101;0;97;0
WireConnection;43;0;101;0
WireConnection;38;0;42;0
WireConnection;99;0;98;0
WireConnection;99;1;43;0
WireConnection;93;0;38;0
WireConnection;112;0;99;0
WireConnection;112;1;93;0
WireConnection;91;1;112;0
WireConnection;71;1;91;0
WireConnection;72;0;71;0
WireConnection;72;1;73;0
WireConnection;35;0;60;0
WireConnection;35;1;72;0
WireConnection;27;0;35;0
WireConnection;106;0;58;0
WireConnection;107;0;46;0
WireConnection;108;0;27;0
WireConnection;110;0;46;0
WireConnection;28;0;106;0
WireConnection;28;1;108;0
WireConnection;28;2;107;0
WireConnection;109;0;111;4
WireConnection;109;1;110;0
WireConnection;109;2;50;1
WireConnection;113;0;28;0
WireConnection;113;1;109;0
WireConnection;26;0;113;0
ASEEND*/
//CHKSM=759CDDFD239B82B4CF405FCD075D74B082FDAD3E
