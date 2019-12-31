// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/RefractedShadows"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		[HideInInspector]_SpecColor("SpecularColor",Color)=(1,1,1,1)
		_NormalMap("Normal Map", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 1)) = 0
		_ShadowTransform("Shadow Transform", Range( 0 , 5)) = 0.5
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGINCLUDE
		#include "UnityStandardUtils.cginc"
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
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
			float3 worldNormal;
			INTERNAL_DATA
			float2 uv_texcoord;
			float3 worldPos;
			float4 screenPos;
		};

		uniform float _NormalScale;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _GrabTexture;
		uniform float _ShadowTransform;

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = float3(0,0,1);
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			float3 tex2DNode10 = UnpackScaleNormal( tex2D( _NormalMap, uv_NormalMap ) ,_NormalScale );
			float3 ase_worldPos = i.worldPos;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float dotResult25 = dot( WorldNormalVector( i , tex2DNode10 ) , ase_worldViewDir );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPos9 = ase_screenPos;
			#if UNITY_UV_STARTS_AT_TOP
			float scale9 = -1.0;
			#else
			float scale9 = 1.0;
			#endif
			float halfPosW9 = ase_screenPos9.w * 0.5;
			ase_screenPos9.y = ( ase_screenPos9.y - halfPosW9 ) * _ProjectionParams.x* scale9 + halfPosW9;
			ase_screenPos9.xyzw /= ase_screenPos9.w;
			float4 screenColor8 = tex2Dproj( _GrabTexture, UNITY_PROJ_COORD( ( ase_screenPos9 + float4( tex2DNode10 , 0.0 ) ) ) );
			o.Emission = ( ( 1.0 - ( dotResult25 * 0.8 ) ) * screenColor8 ).rgb;
			float3 ase_worldlightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			float dotResult6 = dot( WorldNormalVector( i , tex2DNode10 ) , ase_worldlightDir );
			o.Alpha = ( 1.0 - saturate( (dotResult6*_ShadowTransform + _ShadowTransform) ) );
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf BlinnPhong keepalpha fullforwardshadows exclude_path:deferred 

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
				float4 screenPos : TEXCOORD7;
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
				o.screenPos = ComputeScreenPos( o.pos );
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
				surfIN.screenPos = IN.screenPos;
				SurfaceOutput o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutput, o )
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
Version=13202
487;574;979;444;2025.876;664.6953;3.45599;False;False
Node;AmplifyShaderEditor.RangedFloatNode;13;-1398.398,237.6999;Float;False;Property;_NormalScale;Normal Scale;1;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;10;-1064.799,169.1;Float;True;Property;_NormalMap;Normal Map;0;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;31;-648.5012,-490.8;Float;False;476.999;396.6;Traditional nDotV to fake thickness;3;25;28;26;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;33;-682.7992,411.2999;Float;False;444.1991;333.4001;Traditional nDotL to fake custom shadowing;3;6;4;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldNormalVector;26;-598.5012,-440.8002;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;4;-632.7992,461.2999;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;32;-553.2001,-27.89989;Float;False;681.9003;359.4998;Simple Refraction with normal perturbance;3;8;12;9;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;7;-626.5995,632.7;Float;False;1;0;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;28;-522.2015,-283.2002;Float;False;World;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GrabScreenPosition;9;-503.2005,22.10012;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;6;-397.6001,530.8999;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;25;-330.5021,-322.8004;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;22;-539.9011,771.3002;Float;False;Property;_ShadowTransform;Shadow Transform;2;0;0.5;0;5;0;1;FLOAT
Node;AmplifyShaderEditor.ScaleAndOffsetNode;23;-176.8009,670.4999;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.5;False;2;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-256,144;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.ScaleNode;30;-97.90162,-189.4999;Float;False;0.8;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ScreenColorNode;8;-88.29998,119.5999;Float;False;Global;_GrabScreen0;Grab Screen 0;1;0;Object;-1;False;1;0;FLOAT4;0,0,0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SaturateNode;20;33.49896,590.6998;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;29;94.29845,-138.0001;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;18;212.4997,445.4994;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;295.2985,-33.50013;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;526.9,-104.2;Float;False;True;2;Float;ASEMaterialInspector;0;0;BlinnPhong;ASESampleShaders/RefractedShadows;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Translucent;0.5;True;True;0;False;Opaque;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;14;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;10;5;13;0
WireConnection;26;0;10;0
WireConnection;4;0;10;0
WireConnection;6;0;4;0
WireConnection;6;1;7;0
WireConnection;25;0;26;0
WireConnection;25;1;28;0
WireConnection;23;0;6;0
WireConnection;23;1;22;0
WireConnection;23;2;22;0
WireConnection;12;0;9;0
WireConnection;12;1;10;0
WireConnection;30;0;25;0
WireConnection;8;0;12;0
WireConnection;20;0;23;0
WireConnection;29;0;30;0
WireConnection;18;0;20;0
WireConnection;27;0;29;0
WireConnection;27;1;8;0
WireConnection;0;2;27;0
WireConnection;0;9;18;0
ASEEND*/
//CHKSM=07C921B5E38AF05C003671AE4D03E15F1682F35C
