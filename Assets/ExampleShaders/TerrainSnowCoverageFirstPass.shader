// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Terrain/TerrainSnowCoverageFirstPass"
{
	Properties
	{
		[Toggle] _CoverageFade("Coverage Fade", Float) = 0.0
		_CoverageAlbedo("Coverage Albedo", 2D) = "white" {}
		_TransitionDistance("Transition Distance", Float) = 0
		_TransitionFalloff("Transition Falloff", Float) = 0
		_CoverageNormal("Coverage Normal", 2D) = "bump" {}
		_CoverageNormalIntensity("Coverage Normal Intensity", Float) = 1
		_SnowCoverageAmount("Snow Coverage Amount", Range( -1 , 1)) = 0
		_SnowCoverageFalloff("Snow Coverage Falloff", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_MainTex("MainTex", 2D) = "white" {}
		_Color("Color", Color) = (0,0,0,0)
		_Control("Control", 2D) = "white" {}
		_Splat3("Splat3", 2D) = "white" {}
		_Splat2("Splat2", 2D) = "white" {}
		_Splat1("Splat1", 2D) = "white" {}
		_Splat0("Splat0", 2D) = "white" {}
		_Normal0("Normal0", 2D) = "white" {}
		_Normal1("Normal1", 2D) = "white" {}
		_Normal2("Normal2", 2D) = "white" {}
		_Normal3("Normal3", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry-100" "SplatCount"="4" }
		Cull Back
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		#pragma shader_feature _COVERAGEFADE_ON
		#pragma multi_compile_fog
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
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Control;
		uniform float4 _Control_ST;
		uniform sampler2D _Normal0;
		uniform sampler2D _Splat0;
		uniform float4 _Splat0_ST;
		uniform sampler2D _Normal1;
		uniform sampler2D _Splat1;
		uniform float4 _Splat1_ST;
		uniform sampler2D _Normal2;
		uniform sampler2D _Splat2;
		uniform float4 _Splat2_ST;
		uniform sampler2D _Normal3;
		uniform sampler2D _Splat3;
		uniform float4 _Splat3_ST;
		uniform float _CoverageNormalIntensity;
		uniform sampler2D _CoverageNormal;
		uniform float4 _CoverageNormal_ST;
		uniform float _TransitionDistance;
		uniform float _TransitionFalloff;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float4 _Color;
		uniform sampler2D _CoverageAlbedo;
		uniform float4 _CoverageAlbedo_ST;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float _SnowCoverageAmount;
		uniform float _SnowCoverageFalloff;
		uniform float _Metallic;
		uniform float _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float localCalculateTangents1818 = ( 0.0 );
			v.tangent.xyz = cross ( v.normal, float3( 0, 0, 1 ) );
			v.tangent.w = -1;
			float3 temp_cast_0 = (localCalculateTangents1818).xxx;
			v.vertex.xyz += temp_cast_0;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Control = i.uv_texcoord * _Control_ST.xy + _Control_ST.zw;
			float4 tex2DNode1 = tex2D( _Control, uv_Control );
			float2 uv_Splat0 = i.uv_texcoord * _Splat0_ST.xy + _Splat0_ST.zw;
			float2 uv_Splat1 = i.uv_texcoord * _Splat1_ST.xy + _Splat1_ST.zw;
			float2 uv_Splat2 = i.uv_texcoord * _Splat2_ST.xy + _Splat2_ST.zw;
			float2 uv_Splat3 = i.uv_texcoord * _Splat3_ST.xy + _Splat3_ST.zw;
			float4 weightedBlendVar11 = tex2DNode1;
			float4 weightedBlend11 = ( weightedBlendVar11.x*tex2D( _Normal0, uv_Splat0 ) + weightedBlendVar11.y*tex2D( _Normal1, uv_Splat1 ) + weightedBlendVar11.z*tex2D( _Normal2, uv_Splat2 ) + weightedBlendVar11.w*tex2D( _Normal3, uv_Splat3 ) );
			float2 uv_CoverageNormal = i.uv_texcoord * _CoverageNormal_ST.xy + _CoverageNormal_ST.zw;
			float3 tex2DNode43 = UnpackScaleNormal( tex2D( _CoverageNormal, uv_CoverageNormal ) ,_CoverageNormalIntensity );
			float3 ase_worldPos = i.worldPos;
			float clampResult35 = clamp( pow( ( distance( ase_worldPos , _WorldSpaceCameraPos ) / _TransitionDistance ) , _TransitionFalloff ) , 0.0 , 1.0 );
			float Distance56 = clampResult35;
			float3 lerpResult41 = lerp( UnpackNormal( weightedBlend11 ) , tex2DNode43 , Distance56);
			float3 normalizeResult42 = normalize( lerpResult41 );
			#ifdef _COVERAGEFADE_ON
				float3 staticSwitch45 = normalizeResult42;
			#else
				float3 staticSwitch45 = UnpackNormal( weightedBlend11 );
			#endif
			o.Normal = staticSwitch45;
			float4 weightedBlendVar10 = tex2DNode1;
			float4 weightedBlend10 = ( weightedBlendVar10.x*tex2D( _Splat0, uv_Splat0 ) + weightedBlendVar10.y*tex2D( _Splat1, uv_Splat1 ) + weightedBlendVar10.z*tex2D( _Splat2, uv_Splat2 ) + weightedBlendVar10.w*tex2D( _Splat3, uv_Splat3 ) );
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 lerpResult14 = lerp( tex2D( _MainTex, uv_MainTex ) , _Color , 0.0);
			float4 lerpResult16 = lerp( weightedBlend10 , lerpResult14 , 0.0);
			float2 uv_CoverageAlbedo = i.uv_texcoord * _CoverageAlbedo_ST.xy + _CoverageAlbedo_ST.zw;
			float4 lerpResult24 = lerp( lerpResult16 , tex2D( _CoverageAlbedo, uv_CoverageAlbedo ) , Distance56);
			#ifdef _COVERAGEFADE_ON
				float4 staticSwitch39 = lerpResult24;
			#else
				float4 staticSwitch39 = lerpResult16;
			#endif
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float3 temp_cast_2 = (_SnowCoverageFalloff).xxx;
			float SnowMask72 = pow( saturate( ( WorldNormalVector( i , tex2DNode43 ) + _SnowCoverageAmount ) ) , temp_cast_2 ).y;
			float4 lerpResult67 = lerp( staticSwitch39 , tex2D( _TextureSample0, uv_TextureSample0 ) , SnowMask72);
			o.Albedo = lerpResult67.rgb;
			o.Metallic = _Metallic;
			float lerpResult69 = lerp( _Smoothness , 0.5 , SnowMask72);
			o.Smoothness = lerpResult69;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma exclude_renderers gles 
		#pragma surface surf Standard keepalpha fullforwardshadows vertex:vertexDataFunc 

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
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float4 tSpace0 : TEXCOORD2;
				float4 tSpace1 : TEXCOORD3;
				float4 tSpace2 : TEXCOORD4;
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
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
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
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}

	Dependency "BaseMapShader"="ASESampleShaders/TerrainBase"
	Fallback "Nature/Terrain/Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14301
389;92;1064;626;2939.606;1826.845;3.235619;True;False
Node;AmplifyShaderEditor.CommentaryNode;59;-2714.191,-1485.26;Float;False;1968.271;500.7608;Distance Control;9;27;37;29;31;30;33;34;35;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;37;-2664.191,-1246.405;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;27;-2657.929,-1421.025;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;44;212.8771,406.9246;Float;False;Property;_CoverageNormalIntensity;Coverage Normal Intensity;5;0;Create;True;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;29;-2360.201,-1347.89;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-2282.559,-1099.499;Float;False;Property;_TransitionDistance;Transition Distance;2;0;Create;True;0;2.34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;75;1071.507,367.4314;Float;False;1454.748;552.0461;Simple Snow Coverage Effect;8;60;61;62;63;68;64;65;72;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;43;592.1921,245.3864;Float;True;Property;_CoverageNormal;Coverage Normal;4;0;Create;True;None;77fdad851e93f394c9f8a1b1a63b56f3;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;61;1121.506,695.0643;Float;False;Property;_SnowCoverageAmount;Snow Coverage Amount;6;0;Create;True;0;-1;-1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-1901.146,-1116.486;Float;False;Property;_TransitionFalloff;Transition Falloff;3;0;Create;True;0;2.19;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;30;-2014.701,-1346.282;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;60;1145.249,417.4314;Float;False;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-880,336;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;77;-865,523;Float;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;78;-851,761;Float;False;0;3;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;79;-880,992;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-594.937,302.1464;Float;True;Property;_Normal0;Normal0;17;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-634.5041,-150.3657;Float;True;Property;_Splat2;Splat2;14;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;1517.111,583.9039;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;5;-663.126,-550.462;Float;True;Property;_Splat0;Splat0;16;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;13;-234.242,-1559.333;Float;False;Property;_Color;Color;11;0;Create;True;0,0,0,0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;4;-648.222,-351.1321;Float;True;Property;_Splat1;Splat1;15;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;7;-599.87,516.3218;Float;True;Property;_Normal1;Normal1;18;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-607.751,954.6912;Float;True;Property;_Normal3;Normal3;20;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;8;-604.761,730.0314;Float;True;Property;_Normal2;Normal2;19;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;15;-116.3495,-1276.721;Float;False;Constant;_Float0;Float 0;11;0;Create;True;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;12;-238.3848,-1775.582;Float;True;Property;_MainTex;MainTex;10;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;34;-1645.099,-1347.889;Float;True;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-613.83,54.96295;Float;True;Property;_Splat3;Splat3;13;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-663.939,-774.7358;Float;True;Property;_Control;Control;12;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;63;1677.112,583.9039;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SummedBlendNode;11;30.6221,133.4914;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SummedBlendNode;10;59.80904,-310.4797;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0;False;2;COLOR;0.0,0,0,0;False;3;COLOR;0.0,0,0,0;False;4;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;35;-1310.849,-1350.903;Float;True;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;68;1356.331,804.4778;Float;False;Property;_SnowCoverageFalloff;Snow Coverage Falloff;7;0;Create;True;0;0.156;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;14;67.63457,-1432.156;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;16;315.6208,-1187.193;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;19;296.6526,152.313;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1.0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;57;489.4643,-754.7751;Float;False;56;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;668.1784,494.7191;Float;False;56;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-988.9198,-1435.259;Float;False;Distance;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;23;376.1109,-952.9803;Float;True;Property;_CoverageAlbedo;Coverage Albedo;1;0;Create;True;None;138df4511c079324cabae1f7f865c1c1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;64;1837.112,583.9039;Float;False;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;24;949.8305,-933.4713;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;1,1,1,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;65;2011.061,581.8517;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;41;989.9506,51.0748;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;42;1162.343,-149.7701;Float;False;1;0;FLOAT3;0.0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;20;1672.433,-221.2505;Float;False;Property;_Smoothness;Smoothness;8;0;Create;True;0;0.168;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;74;1859.652,-53.60783;Float;False;72;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;39;1287.976,-998.7753;Float;False;Property;_CoverageFade;Coverage Fade;0;0;Create;True;0;False;True;True;;Toggle;2;1;COLOR;0,0,0,0;False;0;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;72;2283.255,594.3326;Float;False;SnowMask;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;73;1810.331,-607.6244;Float;False;72;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;66;1492.186,-697.1776;Float;True;Property;_TextureSample0;Texture Sample 0;21;0;Create;True;None;4112a019314dad94f9ffc2f8481f31bc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CustomExpressionNode;18;2320.469,-134.0521;Float;False;v.tangent.xyz = cross ( v.normal, float3( 0, 0, 1 ) )@$v.tangent.w = -1@;1;True;0;CalculateTangents;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;1960.96,-445.3441;Float;False;Property;_Metallic;Metallic;9;0;Create;True;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;45;1330.188,-420.1055;Float;False;Property;_CoverageFade;Coverage Fade;0;0;Create;True;0;False;True;True;;Toggle;2;1;FLOAT3;0,0,0;False;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;67;2028.625,-816.3794;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;69;2128.003,-211.0074;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.5;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2533.775,-692.96;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Terrain/TerrainSnowCoverageFirstPass;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;False;0;Opaque;0.5;True;True;-100;False;Opaque;Geometry;All;True;True;True;False;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;Nature/Terrain/Diffuse;-1;-1;-1;-1;0;1;SplatCount=4;1;multi_compile_fog;False;1;BaseMapShader=ASESampleShaders/TerrainBase;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;29;0;27;0
WireConnection;29;1;37;0
WireConnection;43;5;44;0
WireConnection;30;0;29;0
WireConnection;30;1;31;0
WireConnection;60;0;43;0
WireConnection;6;1;76;0
WireConnection;62;0;60;0
WireConnection;62;1;61;0
WireConnection;7;1;77;0
WireConnection;9;1;79;0
WireConnection;8;1;78;0
WireConnection;34;0;30;0
WireConnection;34;1;33;0
WireConnection;63;0;62;0
WireConnection;11;0;1;0
WireConnection;11;1;6;0
WireConnection;11;2;7;0
WireConnection;11;3;8;0
WireConnection;11;4;9;0
WireConnection;10;0;1;0
WireConnection;10;1;5;0
WireConnection;10;2;4;0
WireConnection;10;3;3;0
WireConnection;10;4;2;0
WireConnection;35;0;34;0
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;14;2;15;0
WireConnection;16;0;10;0
WireConnection;16;1;14;0
WireConnection;16;2;15;0
WireConnection;19;0;11;0
WireConnection;56;0;35;0
WireConnection;64;0;63;0
WireConnection;64;1;68;0
WireConnection;24;0;16;0
WireConnection;24;1;23;0
WireConnection;24;2;57;0
WireConnection;65;0;64;0
WireConnection;41;0;19;0
WireConnection;41;1;43;0
WireConnection;41;2;58;0
WireConnection;42;0;41;0
WireConnection;39;1;16;0
WireConnection;39;0;24;0
WireConnection;72;0;65;1
WireConnection;45;1;19;0
WireConnection;45;0;42;0
WireConnection;67;0;39;0
WireConnection;67;1;66;0
WireConnection;67;2;73;0
WireConnection;69;0;20;0
WireConnection;69;2;74;0
WireConnection;0;0;67;0
WireConnection;0;1;45;0
WireConnection;0;3;21;0
WireConnection;0;4;69;0
WireConnection;0;11;18;0
ASEEND*/
//CHKSM=77C739307055E874E63B8CD867E6BF11C4D63B16
