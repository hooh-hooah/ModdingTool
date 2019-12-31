// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "UnlitWithLightmap"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		

		Pass
		{
			
			Tags { "LightMode"="VertexLMRGBM" "RenderType"="Opaque" }
			Name "Unlit LM"
			CGPROGRAM
			#pragma target 2.0
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			// uniform sampler2D unity_Lightmap;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float2 uv2_g5 = v.ase_texcoord1 * float2( 1,1 ) + float2( 0,0 );
				float2 vertexToFrag10_g5 = ( ( uv2_g5 * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
				o.ase_texcoord.xy = vertexToFrag10_g5;
				
				o.ase_texcoord.zw = v.ase_texcoord.xy;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float2 vertexToFrag10_g5 = i.ase_texcoord.xy;
				float3 decodeLightMap6_g5 = DecodeLightmap( UNITY_SAMPLE_TEX2D( unity_Lightmap, vertexToFrag10_g5 ) );
				float2 uv_MainTex = i.ase_texcoord.zw * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 appendResult8 = (float4(( decodeLightMap6_g5 * (tex2D( _MainTex, uv_MainTex )).rgb ) , 1.0));
				
				
				finalColor = appendResult8;
				return finalColor;
			}
			ENDCG
		}
		
		Pass
		{
			
			Tags { "LightMode"="VertexLM" "RenderType"="Opaque" }
			Name "Unlit LM Mobile"
			CGPROGRAM
			#pragma target 2.0
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			// uniform sampler2D unity_Lightmap;
			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float2 uv2_g5 = v.ase_texcoord1 * float2( 1,1 ) + float2( 0,0 );
				float2 vertexToFrag10_g5 = ( ( uv2_g5 * (unity_LightmapST).xy ) + (unity_LightmapST).zw );
				o.ase_texcoord.xy = vertexToFrag10_g5;
				
				o.ase_texcoord.zw = v.ase_texcoord.xy;
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float2 vertexToFrag10_g5 = i.ase_texcoord.xy;
				float3 decodeLightMap6_g5 = DecodeLightmap( UNITY_SAMPLE_TEX2D( unity_Lightmap, vertexToFrag10_g5 ) );
				float2 uv_MainTex = i.ase_texcoord.zw * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 appendResult8 = (float4(( decodeLightMap6_g5 * (tex2D( _MainTex, uv_MainTex )).rgb ) , 1.0));
				
				
				finalColor = appendResult8;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16105
289;92;953;701;432.0117;130.2233;1;True;False
Node;AmplifyShaderEditor.SamplerNode;5;-466.1202,154.9717;Float;True;Property;_MainTex;MainTex;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;29;-179.4124,-139.861;Float;False;FetchLightmapValue;0;;5;43de3d4ae59f645418fdd020d1b8e78e;0;0;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;6;-109.2208,156.4722;Float;False;True;True;True;False;1;0;COLOR;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-7.021393,247.4722;Float;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;92.27861,-34.62788;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;8;231.3786,62.87191;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;17;371.8,-33.8;Float;False;False;2;Float;ASEMaterialInspector;0;8;ASECustomTemplateShaders/UnlitLM;899e609c083c74c4ca567477c39edef0;0;1;Unlit LM Mobile;0;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;2;LightMode=VertexLM;RenderType=Opaque=RenderType;True;0;0;;0;0;Standard;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;16;441.9998,-13;Float;False;True;2;Float;ASEMaterialInspector;0;11;UnlitWithLightmap;899e609c083c74c4ca567477c39edef0;0;0;Unlit LM;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;2;LightMode=VertexLMRGBM;RenderType=Opaque=RenderType;True;0;0;;0;0;Standard;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;6;0;5;0
WireConnection;7;0;29;0
WireConnection;7;1;6;0
WireConnection;8;0;7;0
WireConnection;8;3;9;0
WireConnection;16;0;8;0
ASEEND*/
//CHKSM=3F5EBC414FBDA00CBCA1EDEAD64B5686D4C9546F