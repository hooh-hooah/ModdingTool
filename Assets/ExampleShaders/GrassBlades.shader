// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "GrassBlades"
{
	Properties
	{
		_TessValue( "Max Tessellation", Range( 1, 32 ) ) = 15
		_TreeOffset("Tree Offset", Vector) = (0,5,0,0)
		_MainTex("MainTex", 2D) = "white" {}
		_TreeInstanceColor("TreeInstanceColor", Color) = (0,0,0,0)
		_TreeInstanceScale("_TreeInstanceScale", Vector) = (0,0,0,0)
		_SecondaryFactor("SecondaryFactor", Float) = 0
		_PrimaryFactor("PrimaryFactor", Float) = 0
		_EdgeFlutter("EdgeFlutter", Float) = 1
		_BranchPhase("BranchPhase", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TreeBillboard"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Off
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 4.6
		#include "TerrainEngine.cginc"
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float _BranchPhase;
		uniform float _EdgeFlutter;
		uniform float _PrimaryFactor;
		uniform float _SecondaryFactor;
		uniform float3 _TreeOffset;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _TessValue;


		float4 WindAnimateVertex1_g2( float4 Pos , float3 Normal , float4 AnimParams )
		{
			return AnimateVertex(Pos,Normal,AnimParams);
		}


		float4 tessFunction( )
		{
			return _TessValue;
		}

		void vertexDataFunc( inout appdata_full v )
		{
			float4 ase_vertex4Pos = v.vertex;
			float4 Pos1_g2 = ase_vertex4Pos;
			float3 ase_vertexNormal = v.normal.xyz;
			float3 Normal1_g2 = ase_vertexNormal;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float3 normalizeResult52 = normalize( ase_worldPos );
			float4 appendResult15 = (float4(_BranchPhase , ( _EdgeFlutter * ( (normalizeResult52).x + (normalizeResult52).z ) ) , _PrimaryFactor , _SecondaryFactor));
			float4 AnimParams1_g2 = appendResult15;
			float4 localWindAnimateVertex1_g2 = WindAnimateVertex1_g2( Pos1_g2 , Normal1_g2 , AnimParams1_g2 );
			v.vertex.xyz = ( ( localWindAnimateVertex1_g2 * _TreeInstanceScale ) + float4( _TreeOffset , 0.0 ) ).xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 tex2DNode3 = tex2D( _MainTex, uv_MainTex );
			o.Albedo = ( _TreeInstanceColor * tex2DNode3 ).rgb;
			o.Alpha = tex2DNode3.a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc tessellate:tessFunction 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 4.6
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
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
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
				surfIN.worldPos = worldPos;
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
Version=16103
480;92;951;705;388.167;249.3669;1;False;False
Node;AmplifyShaderEditor.WorldPosInputsNode;47;-1613.94,374.7962;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.NormalizeNode;52;-1433.848,405.8031;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;53;-1276.848,359.8031;Float;False;FLOAT;0;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;54;-1282.758,461.1884;Float;False;FLOAT;2;1;2;3;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-940.1017,344.933;Float;False;Property;_EdgeFlutter;EdgeFlutter;12;0;Create;True;0;0;False;0;1;0.2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-1107.126,391.6696;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-855.2003,648.8994;Float;False;Property;_SecondaryFactor;SecondaryFactor;10;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-863.3002,544.9996;Float;False;Property;_PrimaryFactor;PrimaryFactor;11;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-873.9003,235.7;Float;False;Property;_BranchPhase;BranchPhase;13;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;-781.8696,411.4852;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-609.5466,421.1271;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector4Node;31;-349.7917,473.8345;Float;False;Property;_TreeInstanceScale;_TreeInstanceScale;9;0;Fetch;True;0;0;False;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;6;-413.5,307;Float;False;Terrain Wind Animate Vertex;-1;;2;3bc81bd4568a7094daabf2ccd6a7e125;0;3;2;FLOAT4;0,0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;3;-422.5,-168;Float;True;Property;_MainTex;MainTex;7;0;Create;True;0;0;False;0;None;b3101af65b8fa814e8bbcda4070eef97;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;30;-210.4572,-369.9227;Float;False;Property;_TreeInstanceColor;TreeInstanceColor;8;0;Fetch;True;0;0;False;0;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-87.62848,267.1468;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.Vector3Node;23;-46.3596,535.886;Float;False;Property;_TreeOffset;Tree Offset;6;0;Create;True;0;0;False;0;0,5,0;0,0.48,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TexCoordVertexDataNode;27;-1096.637,111.2048;Float;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;24;-773.6367,-57.79521;Float;False;TerrainBillboardTree(Pos, Offset, OffsetZ)@$return@;7;False;3;True;Pos;FLOAT4;0,0,0,0;InOut;;Float;True;Offset;FLOAT2;0,0;In;;Float;True;OffsetZ;FLOAT;0;In;;Float;TerrainBillboardTree;True;False;0;4;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT2;0,0;False;3;FLOAT;0;False;2;FLOAT;0;FLOAT4;2
Node;AmplifyShaderEditor.TexCoordVertexDataNode;26;-1101.637,-46.79521;Float;False;1;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;24.54279,-228.9227;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.PosVertexDataNode;25;-1072.637,-223.7951;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;22;89.28527,242.6021;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;7;222,-64;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;GrassBlades;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TreeBillboard;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;True;1;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Absolute;0;;0;-1;-1;1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;52;0;47;0
WireConnection;53;0;52;0
WireConnection;54;0;52;0
WireConnection;48;0;53;0
WireConnection;48;1;54;0
WireConnection;56;0;17;0
WireConnection;56;1;48;0
WireConnection;15;0;16;0
WireConnection;15;1;56;0
WireConnection;15;2;18;0
WireConnection;15;3;19;0
WireConnection;6;4;15;0
WireConnection;28;0;6;0
WireConnection;28;1;31;0
WireConnection;24;1;25;0
WireConnection;24;2;26;0
WireConnection;24;3;27;2
WireConnection;29;0;30;0
WireConnection;29;1;3;0
WireConnection;22;0;28;0
WireConnection;22;1;23;0
WireConnection;7;0;29;0
WireConnection;7;9;3;4
WireConnection;7;11;22;0
ASEEND*/
//CHKSM=789681A32E4027B79521C92C1D10F3381F411AA5