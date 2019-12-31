// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Projectors/ProjectorShadow"
{
	Properties
	{
		_ShadowTex("ShadowTex", 2D) = "white" {}
		_FalloffTex("FalloffTex", 2D) = "white" {}
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		ZWrite Off
		ZTest LEqual
		ColorMask RGB
		Blend DstColor Zero
		Cull Back
		Offset -1 , -1
		

		Pass
		{
			CGPROGRAM
			#pragma target 3.0 
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


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
				float4 ase_texcoord1 : TEXCOORD1;
			};

			uniform sampler2D _ShadowTex;
			float4x4 unity_Projector;
			uniform sampler2D _FalloffTex;
			float4x4 unity_ProjectorClip;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float4 vertexToFrag11 = mul( unity_Projector, v.vertex );
				o.ase_texcoord = vertexToFrag11;
				float4 vertexToFrag15 = mul( unity_ProjectorClip, v.vertex );
				o.ase_texcoord1 = vertexToFrag15;
				
				
				v.vertex.xyz +=  float3(0,0,0) ;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				fixed4 finalColor;
				float4 vertexToFrag11 = i.ase_texcoord;
				float4 tex2DNode18 = tex2D( _ShadowTex, ( (vertexToFrag11).xy / (vertexToFrag11).w ) );
				float4 appendResult25 = (float4(tex2DNode18.rgb , ( 1.0 - tex2DNode18.a )));
				float4 vertexToFrag15 = i.ase_texcoord1;
				float4 lerpResult39 = lerp( float4(1,1,1,0) , appendResult25 , tex2D( _FalloffTex, ( (vertexToFrag15).xy / (vertexToFrag15).w ) ).a);
				
				
				finalColor = lerpResult39;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15306
465;615;1039;403;1448.448;136.0805;2;False;False
Node;AmplifyShaderEditor.UnityProjectorMatrixNode;8;-1408,0;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.PosVertexDataNode;10;-1408,80;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1200,0;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PosVertexDataNode;13;-1408,464;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexToFragmentNode;11;-1056,0;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.UnityProjectorClipMatrixNode;9;-1408,384;Float;False;0;1;FLOAT4x4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-1200,384;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ComponentMaskNode;21;-816,0;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;22;-816,80;Float;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexToFragmentNode;15;-1056,384;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;20;-576,0;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;18;-432,0;Float;True;Property;_ShadowTex;ShadowTex;0;0;Create;True;0;0;False;0;None;84508b93f15f2b64386ec07486afc7a3;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComponentMaskNode;32;-816,384;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ComponentMaskNode;33;-816,464;Float;False;False;False;False;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-128,96;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;31;-576,384;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;48,0;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;40;-96,224;Float;False;Constant;_Vector0;Vector 0;3;0;Create;True;0;0;False;0;1,1,1,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-432,384;Float;True;Property;_FalloffTex;FalloffTex;1;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;39;256,256;Float;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;38;416,256;Float;False;True;2;Float;ASEMaterialInspector;0;10;ASESampleShaders/Projectors/ProjectorShadow;0770190933193b94aaa3065e307002fa;0;0;SubShader 0 Pass 0;2;True;6;2;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;True;0;False;-1;True;True;True;True;False;0;False;-1;False;True;2;False;-1;True;0;False;-1;True;True;-1;False;-1;-1;False;-1;True;1;RenderType=Opaque;False;0;0;0;False;False;False;False;False;False;False;False;False;True;2;0;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;12;0;8;0
WireConnection;12;1;10;0
WireConnection;11;0;12;0
WireConnection;14;0;9;0
WireConnection;14;1;13;0
WireConnection;21;0;11;0
WireConnection;22;0;11;0
WireConnection;15;0;14;0
WireConnection;20;0;21;0
WireConnection;20;1;22;0
WireConnection;18;1;20;0
WireConnection;32;0;15;0
WireConnection;33;0;15;0
WireConnection;30;0;18;4
WireConnection;31;0;32;0
WireConnection;31;1;33;0
WireConnection;25;0;18;0
WireConnection;25;3;30;0
WireConnection;34;1;31;0
WireConnection;39;0;40;0
WireConnection;39;1;25;0
WireConnection;39;2;34;4
WireConnection;38;0;39;0
ASEEND*/
//CHKSM=23054C79779874CA7E3BB6ABFA778DDEE26F9959
