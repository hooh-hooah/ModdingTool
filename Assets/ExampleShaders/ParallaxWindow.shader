// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Parallax/ParallaxWindow"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Back("Back", 2D) = "white" {}
		_BackDark("Back Dark", Float) = 0.7
		_BackDepthScale("Back Depth Scale", Range( 0 , 1)) = 0
		_Mid("Mid", 2D) = "white" {}
		_MidDark("Mid Dark", Float) = 0.3
		_MidDepthScale("Mid Depth Scale", Range( 0 , 1)) = 0.3
		_Front("Front", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
		_Specular("Specular", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 2.5
		#ifdef UNITY_PASS_SHADOWCASTER
			#undef INTERNAL_DATA
			#undef WorldReflectionVector
			#undef WorldNormalVector
			#define INTERNAL_DATA half3 internalSurfaceTtoW0; half3 internalSurfaceTtoW1; half3 internalSurfaceTtoW2;
			#define WorldReflectionVector(data,normal) reflect (data.worldRefl, half3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal)))
			#define WorldNormalVector(data,normal) fixed3(dot(data.internalSurfaceTtoW0,normal), dot(data.internalSurfaceTtoW1,normal), dot(data.internalSurfaceTtoW2,normal))
		#endif
		struct Input
		{
			float2 texcoord_0;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform sampler2D _Back;
		uniform fixed _BackDepthScale;
		uniform fixed _BackDark;
		uniform sampler2D _Mid;
		uniform fixed _MidDepthScale;
		uniform fixed _MidDark;
		uniform sampler2D _Mask;
		uniform sampler2D _Front;
		uniform fixed _Specular;
		uniform fixed _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			o.Normal = fixed3(0,0,1);
			float2 Offset75 = ( ( 0.0 - 1.0 ) * i.viewDir.xy * _BackDepthScale ) + i.texcoord_0;
			float2 OffsetBack = Offset75;
			float2 Offset76 = ( ( 0.0 - 1.0 ) * i.viewDir.xy * _MidDepthScale ) + i.texcoord_0;
			float2 OffsetMid = Offset76;
			fixed4 tex2DNode62 = tex2D( _Mask, i.texcoord_0 );
			o.Albedo = lerp( lerp( ( tex2D( _Back, OffsetBack ) * _BackDark ) , ( tex2D( _Mid, OffsetMid ) * _MidDark ) , tex2D( _Mask, OffsetMid ).g ) , tex2D( _Front, i.texcoord_0 ) , tex2DNode62.r ).xyz;
			float temp_output_87_0 = ( 1.0 - tex2DNode62.r );
			fixed3 temp_cast_1 = (( temp_output_87_0 * _Specular )).xxx;
			o.Specular = temp_cast_1;
			o.Smoothness = ( temp_output_87_0 * _Smoothness );
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			# include "HLSLSupport.cginc"
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
				float3 worldPos : TEXCOORD6;
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			fixed4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = IN.tSpace0.xyz * worldViewDir.x + IN.tSpace1.xyz * worldViewDir.y + IN.tSpace2.xyz * worldViewDir.z;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandardSpecular o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandardSpecular, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10011
412;100;931;639;1697.759;-31.65363;1;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1716.362,402.5095;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;54;-1339.354,167.9353;Float;False;Property;_BackDepthScale;Back Depth Scale;3;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;49;-1354.041,412.4043;Float;False;Property;_MidDepthScale;Mid Depth Scale;6;0;0.3;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;86;-1398.606,375.6921;Float;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;85;-1416.174,174.5851;Float;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;51;-1104.096,239.0735;Float;False;Tangent;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ParallaxMappingNode;76;-946.2023,332.5014;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.ParallaxMappingNode;75;-953.2018,119.736;Float;False;Normal;4;0;FLOAT2;0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT3;0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;95;-1362.383,609.8043;Float;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;92;-1331.782,534.7811;Float;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;64;-166.3069,629.3103;Float;False;Property;_MidDark;Mid Dark;5;0;0.3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;70;-627.5119,138.6462;Float;False;OffsetBack;1;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-619.4551,390.4736;Float;False;OffsetMid;2;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;93;-607.8077,594.7998;Float;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;98;-7.037296,568.9813;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;46;-323.2037,449.3041;Float;True;Property;_Mid;Mid;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1.0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;94;-656.5728,703.5836;Float;False;1;0;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.RangedFloatNode;61;-163.8694,364.756;Float;False;Property;_BackDark;Back Dark;2;0;0.7;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;45;-326.5037,181.3044;Float;True;Property;_Back;Back;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1.0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;47;-318.1801,725.5137;Float;True;Property;_Mask;Mask;8;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1.0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;96;78.49758,648.8132;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;62;-343.6602,1229.647;Float;True;Property;_TextureSample0;Texture Sample 0;-1;0;None;True;0;False;white;Auto;False;Instance;47;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1.0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;57;-329.4955,980.0483;Float;True;Property;_Front;Front;7;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1.0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;63;115.598,454.4031;Float;False;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;112.1981,277.5027;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.WireNode;80;220.0073,788.4324;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;101;175.4373,700.1351;Float;False;1;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.LerpOp;48;316.0967,430.2044;Float;False;3;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0;False;2;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;73;376.3207,972.8581;Float;False;Property;_Specular;Specular;9;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;74;383.9784,1165.016;Float;False;Property;_Smoothness;Smoothness;10;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;87;411.4357,739.0054;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;89;720.4633,883.5364;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;58;689.1907,430.6974;Float;False;3;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;2;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.Vector3Node;50;703.1962,561.9033;Float;False;Constant;_Vector0;Vector 0;-1;0;0,0,1;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;88;711.759,725.038;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1026.3,428.7931;Fixed;False;True;1;Fixed;ASEMaterialInspector;0;StandardSpecular;ASESampleShaders/Parallax/ParallaxWindow;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0.0;False;7;FLOAT3;0.0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0.0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;86;0;9;0
WireConnection;85;0;9;0
WireConnection;76;0;86;0
WireConnection;76;2;49;0
WireConnection;76;3;51;0
WireConnection;75;0;85;0
WireConnection;75;2;54;0
WireConnection;75;3;51;0
WireConnection;95;0;9;0
WireConnection;92;0;9;0
WireConnection;70;0;75;0
WireConnection;15;0;76;0
WireConnection;93;0;92;0
WireConnection;98;0;64;0
WireConnection;46;1;15;0
WireConnection;94;0;95;0
WireConnection;45;1;70;0
WireConnection;47;1;15;0
WireConnection;96;0;47;2
WireConnection;62;1;94;0
WireConnection;57;1;93;0
WireConnection;63;0;46;0
WireConnection;63;1;98;0
WireConnection;59;0;45;0
WireConnection;59;1;61;0
WireConnection;80;0;62;1
WireConnection;101;0;57;0
WireConnection;48;0;59;0
WireConnection;48;1;63;0
WireConnection;48;2;96;0
WireConnection;87;0;62;1
WireConnection;89;0;87;0
WireConnection;89;1;74;0
WireConnection;58;0;48;0
WireConnection;58;1;101;0
WireConnection;58;2;80;0
WireConnection;88;0;87;0
WireConnection;88;1;73;0
WireConnection;0;0;58;0
WireConnection;0;1;50;0
WireConnection;0;3;88;0
WireConnection;0;4;89;0
ASEEND*/
//CHKSM=9D95C8FF9D46FBEF1B1416D392DB07337014F340
