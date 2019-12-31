// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Triplanar"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_TriplanarAlbedo("Triplanar Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_TopAlbedo("Top Albedo", 2D) = "white" {}
		_TopNormal("Top Normal", 2D) = "bump" {}
		[IntRange]_WorldtoObjectSwitch("World to Object Switch", Range( 0 , 1)) = 0
		_CoverageAmount("Coverage Amount", Range( -1 , 1)) = 0
		_CoverageFalloff("Coverage Falloff", Range( 0.01 , 2)) = 0.5
		_Specular("Specular", Range( 0 , 1)) = 0.02
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		ZTest LEqual
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
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
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
		};

		uniform sampler2D _Normal;
		uniform sampler2D _TopNormal;
		uniform float4 _TopNormal_ST;
		uniform float _CoverageAmount;
		uniform float _CoverageFalloff;
		uniform sampler2D _TriplanarAlbedo;
		uniform sampler2D _TopAlbedo;
		uniform float _WorldtoObjectSwitch;
		uniform float _Specular;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float2 appendResult332 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float3 temp_output_72_0 = abs( mul( unity_WorldToObject, float4( ase_worldNormal , 0.0 ) ).xyz );
			float dotResult73 = dot( temp_output_72_0 , float3(1,1,1) );
			float3 BlendComponents147 = ( temp_output_72_0 / dotResult73 );
			float2 appendResult331 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 appendResult330 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.y));
			float2 uv_TopNormal = i.uv_texcoord * _TopNormal_ST.xy + _TopNormal_ST.zw;
			float3 lerpResult284 = lerp( ( ( ( UnpackNormal( tex2D( _Normal, appendResult332 ) ) * BlendComponents147.x ) + ( UnpackNormal( tex2D( _Normal, appendResult331 ) ) * BlendComponents147.y ) ) + ( UnpackNormal( tex2D( _Normal, appendResult330 ) ) * BlendComponents147.z ) ) , UnpackNormal( tex2D( _TopNormal, uv_TopNormal ) ) , pow( saturate( ( ase_worldNormal.y + _CoverageAmount ) ) , _CoverageFalloff ));
			float3 CalculatedNormal292 = lerpResult284;
			o.Normal = CalculatedNormal292;
			float2 appendResult336 = (float2(ase_vertex3Pos.y , ase_vertex3Pos.z));
			float2 appendResult335 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.z));
			float2 appendResult334 = (float2(ase_vertex3Pos.x , ase_vertex3Pos.y));
			float3 ase_worldPos = i.worldPos;
			float WorldObjectSwitch192 = _WorldtoObjectSwitch;
			float3 lerpResult187 = lerp( ase_worldPos , ase_vertex3Pos , WorldObjectSwitch192);
			float2 appendResult333 = (float2(lerpResult187.x , lerpResult187.z));
			float3 PixelNormal315 = WorldNormalVector( i , CalculatedNormal292 );
			float3 lerpResult186 = lerp( PixelNormal315 , mul( unity_WorldToObject, float4( PixelNormal315 , 0.0 ) ).xyz , WorldObjectSwitch192);
			float3 temp_cast_4 = (_CoverageFalloff).xxx;
			float4 lerpResult105 = lerp( ( ( ( tex2D( _TriplanarAlbedo, appendResult336 ) * BlendComponents147.x ) + ( tex2D( _TriplanarAlbedo, appendResult335 ) * BlendComponents147.y ) ) + ( tex2D( _TriplanarAlbedo, appendResult334 ) * BlendComponents147.z ) ) , tex2D( _TopAlbedo, appendResult333 ) , pow( saturate( ( lerpResult186 + _CoverageAmount ) ) , temp_cast_4 ).y);
			o.Albedo = lerpResult105.xyz;
			float3 temp_cast_6 = (_Specular).xxx;
			o.Specular = temp_cast_6;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardSpecular keepalpha fullforwardshadows exclude_path:deferred 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.5
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
				float4 tSpace0 : TEXCOORD1;
				float4 tSpace1 : TEXCOORD2;
				float4 tSpace2 : TEXCOORD3;
				float4 texcoords01 : TEXCOORD4;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
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
				surfIN.uv_texcoord.xy = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
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
Version=13201
436;92;888;768;2373.662;1178.269;4.6;True;False
Node;AmplifyShaderEditor.WorldToObjectMatrix;329;-2272,192;Float;False;0;1;FLOAT4x4
Node;AmplifyShaderEditor.WorldNormalVector;144;-2272,288;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-2000,256;Float;False;2;2;0;FLOAT4x4;0,0,0;False;1;FLOAT3;0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.Vector3Node;264;-1873.118,436.4499;Float;False;Constant;_Vector0;Vector 0;-1;0;1,1,1;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.AbsOpNode;72;-1840,256;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.DotProductOpNode;73;-1666.1,322.3978;Float;False;2;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;75;-1504,256;Float;False;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;147;-1344,256;Float;True;BlendComponents;1;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;245;-1504,2256;Float;False;147;0;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;110;-339.4074,1528.998;Float;False;Property;_CoverageAmount;Coverage Amount;5;0;0;-1;1;0;1;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;270;-1168,2112;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;115;-335.5072,1649.297;Float;False;Property;_CoverageFalloff;Coverage Falloff;6;0;0.5;0.01;2;0;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;280;-816,2448;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;282;-1168,2400;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;277;-816,2144;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;242;-816,1872;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;322;-896,2576;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;309;-16,1840;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;325;-896,2064;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;310;32,1792;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;330;-583.699,2465.962;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;331;-566.5652,2169.431;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;332;-575.5652,1907.431;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;243;-400,1856;Float;True;Property;_Normal;Normal;1;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;273;-1168,2256;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;324;-864,2032;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;274;-400,2128;Float;True;Property;_TextureSample4;Texture Sample 4;1;0;None;True;0;True;bump;Auto;True;Instance;243;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;304;240,1760;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;281;-400,2432;Float;True;Property;_TextureSample5;Texture Sample 5;1;0;None;True;0;True;bump;Auto;True;Instance;243;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;308;512,2096;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;312;320,1952;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;323;-864,2608;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;303;480,1936;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;249;0,2560;Float;True;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;251;0,2256;Float;True;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;307;528,2192;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;253;0,1984;Float;True;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;252;240,2096;Float;True;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SaturateNode;305;640,2128;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;316;560,2224;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;285;400,2512;Float;True;Property;_TopNormal;Top Normal;3;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;250;224,2400;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.PowerNode;306;816,2176;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;301;768,2400;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;248;480,2288;Float;True;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.LerpOp;284;1008,2288;Float;False;3;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;292;1184,2288;Float;True;CalculatedNormal;2;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.CommentaryNode;170;-524.7089,1125.127;Float;False;436.2993;336.8007;Coverage in Object mode;3;149;313;328;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;314;1472,2352;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;185;-656,1024;Float;False;Property;_WorldtoObjectSwitch;World to Object Switch;4;1;[IntRange];0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;192;-320.3076,1021.095;Float;False;WorldObjectSwitch;4;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;238;-1040,96;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;240;-1040,384;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;313;-490.9794,1325.861;Float;False;315;0;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;315;1699.42,2298.961;Float;True;PixelNormal;3;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WorldToObjectMatrix;328;-490.01,1223.038;Float;False;0;1;FLOAT4x4
Node;AmplifyShaderEditor.CommentaryNode;172;-422.9069,762.4951;Float;False;317.8;243.84;Coverage in World mode;1;293;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;174;64,800;Float;False;235.9301;237.3099;Coverage in Object mode;1;119;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-247.4096,1245.228;Float;False;2;2;0;FLOAT4x4;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3;0.0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.CommentaryNode;175;64,528;Float;False;224;239;Coverage in World mode;1;161;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WireNode;198;-768,48;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;317;-29.97948,820.2599;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;293;-353.8859,869.5626;Float;False;315;0;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;298;-768,528;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;98;-688,-160;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;193;82.09288,1493.795;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;239;-1040,240;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;96;-688,384;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;188;17.79165,780.8954;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;119;96,864;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;296;-736,560;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;186;16,1072;Float;False;3;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WorldPosInputsNode;161;96,592;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;90;-736,16;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;97;-688,96;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;319;0,288;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;318;0,560;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;153;224,1072;Float;False;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.WireNode;181;350.9923,1673.196;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;89;0,16;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;334;-442.0647,401.6313;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;336;-435.9647,-128.9687;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.LerpOp;187;336,688;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0;False;2;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.DynamicAppendNode;335;-442.9647,127.0313;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;180;441.7923,1577.996;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;320;32,-16;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;33;-254.9974,360.4987;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;297;32,528;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;1;-252.6997,-172.9003;Float;True;Property;_TriplanarAlbedo;Triplanar Albedo;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SaturateNode;152;384,1072;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.BreakToComponentsNode;287;496,688;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;295;32,256;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;302;-257.7821,82.56178;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;None;True;0;False;white;Auto;False;Instance;1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;112,80;Float;True;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.DynamicAppendNode;333;744.6346,703.8308;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;112,320;Float;True;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.PowerNode;155;544,1072;Float;False;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;112,-192;Float;True;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;104;880,672;Float;True;Property;_TopAlbedo;Top Albedo;2;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;268;720,1072;Float;False;FLOAT3;1;0;FLOAT3;0.0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;120;368,272;Float;False;1;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;32;352,-80;Float;True;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.WireNode;299;1510.917,2008.36;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleAddOpNode;35;608,176;Float;True;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.WireNode;326;1225.392,1002.939;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.WireNode;190;1203.291,377.2951;Float;False;1;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.LerpOp;105;1296,176;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;212;1296,416;Float;False;Property;_Specular;Specular;7;0;0.02;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.WireNode;300;1680.917,300.2614;Float;False;1;0;FLOAT3;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.RangedFloatNode;213;1296,496;Float;False;Property;_Smoothness;Smoothness;8;0;0.5;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1808,176;Float;False;True;1;Float;ASEMaterialInspector;0;0;StandardSpecular;ASESampleShaders/Triplanar;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0.0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;145;0;329;0
WireConnection;145;1;144;0
WireConnection;72;0;145;0
WireConnection;73;0;72;0
WireConnection;73;1;264;0
WireConnection;75;0;72;0
WireConnection;75;1;73;0
WireConnection;147;0;75;0
WireConnection;270;0;245;0
WireConnection;282;0;245;0
WireConnection;322;0;282;2
WireConnection;309;0;115;0
WireConnection;325;0;270;0
WireConnection;310;0;110;0
WireConnection;330;0;280;1
WireConnection;330;1;280;2
WireConnection;331;0;277;1
WireConnection;331;1;277;3
WireConnection;332;0;242;2
WireConnection;332;1;242;3
WireConnection;243;1;332;0
WireConnection;273;0;245;0
WireConnection;324;0;325;0
WireConnection;274;1;331;0
WireConnection;281;1;330;0
WireConnection;308;0;309;0
WireConnection;312;0;310;0
WireConnection;323;0;322;0
WireConnection;303;0;304;2
WireConnection;303;1;312;0
WireConnection;249;0;281;0
WireConnection;249;1;323;0
WireConnection;251;0;274;0
WireConnection;251;1;273;1
WireConnection;307;0;308;0
WireConnection;253;0;243;0
WireConnection;253;1;324;0
WireConnection;252;0;253;0
WireConnection;252;1;251;0
WireConnection;305;0;303;0
WireConnection;316;0;307;0
WireConnection;250;0;249;0
WireConnection;306;0;305;0
WireConnection;306;1;316;0
WireConnection;301;0;285;0
WireConnection;248;0;252;0
WireConnection;248;1;250;0
WireConnection;284;0;248;0
WireConnection;284;1;301;0
WireConnection;284;2;306;0
WireConnection;292;0;284;0
WireConnection;314;0;292;0
WireConnection;192;0;185;0
WireConnection;238;0;147;0
WireConnection;240;0;147;0
WireConnection;315;0;314;0
WireConnection;149;0;328;0
WireConnection;149;1;313;0
WireConnection;198;0;238;0
WireConnection;317;0;192;0
WireConnection;298;0;240;2
WireConnection;193;0;110;0
WireConnection;239;0;147;0
WireConnection;188;0;317;0
WireConnection;296;0;298;0
WireConnection;186;0;293;0
WireConnection;186;1;149;0
WireConnection;186;2;192;0
WireConnection;90;0;198;0
WireConnection;319;0;239;1
WireConnection;318;0;296;0
WireConnection;153;0;186;0
WireConnection;153;1;193;0
WireConnection;181;0;115;0
WireConnection;89;0;90;0
WireConnection;334;0;96;1
WireConnection;334;1;96;2
WireConnection;336;0;98;2
WireConnection;336;1;98;3
WireConnection;187;0;161;0
WireConnection;187;1;119;0
WireConnection;187;2;188;0
WireConnection;335;0;97;1
WireConnection;335;1;97;3
WireConnection;180;0;181;0
WireConnection;320;0;89;0
WireConnection;33;1;334;0
WireConnection;297;0;318;0
WireConnection;1;1;336;0
WireConnection;152;0;153;0
WireConnection;287;0;187;0
WireConnection;295;0;319;0
WireConnection;302;1;335;0
WireConnection;31;0;302;0
WireConnection;31;1;295;0
WireConnection;333;0;287;0
WireConnection;333;1;287;2
WireConnection;34;0;33;0
WireConnection;34;1;297;0
WireConnection;155;0;152;0
WireConnection;155;1;180;0
WireConnection;28;0;1;0
WireConnection;28;1;320;0
WireConnection;104;1;333;0
WireConnection;268;0;155;0
WireConnection;120;0;34;0
WireConnection;32;0;28;0
WireConnection;32;1;31;0
WireConnection;299;0;292;0
WireConnection;35;0;32;0
WireConnection;35;1;120;0
WireConnection;326;0;268;1
WireConnection;190;0;104;0
WireConnection;105;0;35;0
WireConnection;105;1;190;0
WireConnection;105;2;326;0
WireConnection;300;0;299;0
WireConnection;0;0;105;0
WireConnection;0;1;300;0
WireConnection;0;3;212;0
WireConnection;0;4;213;0
ASEEND*/
//CHKSM=316ECE5042FEF6509FBA90C4635486F73A5AC616
