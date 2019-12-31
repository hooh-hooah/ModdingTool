// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/CustomLightingToon"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_ASEOutlineColor( "Outline Color", Color ) = (0,0,0,0)
		_ASEOutlineWidth( "Outline Width", Float ) = 0.02
		_ToonRamp("Toon Ramp", 2D) = "white" {}
		[HDR]_RimColor("Rim Color", Color) = (0,1,0.8758622,0)
		_RimPower("Rim Power", Range( 0 , 10)) = 0.5
		_RimOffset("Rim Offset", Float) = 0.24
		_Diffuse("Diffuse", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ }
		Cull Front
		CGPROGRAM
		#pragma target 3.0
		#pragma surface outlineSurf Outline keepalpha noshadow noambient novertexlights nolightmap nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:outlineVertexDataFunc
		uniform fixed4 _ASEOutlineColor;
		uniform fixed _ASEOutlineWidth;
		void outlineVertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += ( v.normal * _ASEOutlineWidth );
		}
		inline fixed4 LightingOutline( SurfaceOutput s, half3 lightDir, half atten ) { return fixed4 ( 0,0,0, s.Alpha); }
		void outlineSurf( Input i, inout SurfaceOutput o ) { o.Emission = _ASEOutlineColor.rgb; o.Alpha = 1; }
		ENDCG
		

		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityPBSLighting.cginc"
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
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
			float2 uv_texcoord;
			float3 worldNormal;
			float3 worldPos;
			float3 viewDir;
			INTERNAL_DATA
		};

		struct SurfaceOutputCustomLightingCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			Input SurfInput;
			UnityGIInput GIData;
		};

		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform sampler2D _ToonRamp;
		uniform float _RimOffset;
		uniform float _RimPower;
		uniform float4 _RimColor;

		inline half4 LightingStandardCustomLighting( inout SurfaceOutputCustomLightingCustom s, half3 viewDir, UnityGI gi )
		{
			UnityGIInput data = s.GIData;
			Input i = s.SurfInput;
			half4 c = 0;
			#if DIRECTIONAL
			float ase_lightAtten = data.atten;
			if( _LightColor0.a == 0)
			ase_lightAtten = 0;
			#else
			float3 ase_lightAttenRGB = gi.light.color / ( ( _LightColor0.rgb ) + 0.000001 );
			float ase_lightAtten = max( max( ase_lightAttenRGB.r, ase_lightAttenRGB.g ), ase_lightAttenRGB.b );
			#endif
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			float3 ase_worldPos = i.worldPos;
			float3 ase_lightDir = normalize( UnityWorldSpaceLightDir( ase_worldPos ) );
			float temp_output_3_0 = dot( i.worldNormal , ase_lightDir );
			float2 temp_cast_0 = (saturate( (temp_output_3_0*0.5 + 0.5) )).xx;
			float3 ase_worldNormal = i.worldNormal;
			float3 ase_indirectDiffuse = ShadeSH9( float4( ase_worldNormal, 1 ) );
			float3 temp_cast_2 = (ase_lightAtten).xxx;
			c.rgb = ( ( ( tex2D( _Diffuse, uv_Diffuse ) * tex2D( _ToonRamp, temp_cast_0 ) ) * ( _LightColor0 * float4( ( ase_indirectDiffuse + temp_cast_2 ) , 0.0 ) ) ) + ( saturate( ( ( ase_lightAtten * temp_output_3_0 ) * pow( ( 1.0 - saturate( ( dot( i.worldNormal , i.viewDir ) + _RimOffset ) ) ) , _RimPower ) ) ) * ( _RimColor * _LightColor0 ) ) ).rgb;
			c.a = 1;
			return c;
		}

		inline void LightingStandardCustomLighting_GI( inout SurfaceOutputCustomLightingCustom s, UnityGIInput data, inout UnityGI gi )
		{
			s.GIData = data;
		}

		void surf( Input i , inout SurfaceOutputCustomLightingCustom o )
		{
			o.SurfInput = i;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf StandardCustomLighting keepalpha fullforwardshadows 

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
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
				o.texcoords01 = float4( v.texcoord.xy, v.texcoord1.xy );
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
				surfIN.uv_texcoord.xy = IN.texcoords01.xy;
				float3 worldPos = float3( IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w );
				fixed3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				surfIN.viewDir = worldViewDir;
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3( IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z );
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputCustomLightingCustom o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputCustomLightingCustom, o )
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
Version=10003
468;546;979;430;2767.59;654.1011;3.999999;True;False
Node;AmplifyShaderEditor.CommentaryNode;49;-2016,528;Float;False;507.201;385.7996;Comment;3;36;37;38;N . V;0;0
Node;AmplifyShaderEditor.WorldNormalVector;36;-1968,576;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;37;-1920,736;Float;False;World;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;50;-1344,768;Float;False;1617.938;553.8222;;13;33;46;32;31;34;47;35;30;29;28;27;25;24;Rim Light;0;0
Node;AmplifyShaderEditor.DotProductOpNode;38;-1664,656;Float;False;2;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;48;-2016,32;Float;False;540.401;320.6003;Comment;3;1;3;2;N . L;0;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-1264,1040;Float;False;Property;_RimOffset;Rim Offset;3;0;0.24;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1056,928;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;51;-1143.099,-115.6995;Float;False;723.599;290;Also know as Lambert Wrap or Half Lambert;3;5;4;15;Diffuse Wrap;0;0
Node;AmplifyShaderEditor.WorldNormalVector;1;-1904,80;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldSpaceLightDirHlpNode;2;-1952,240;Float;False;1;0;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.CommentaryNode;52;-880,320;Float;False;812;304;Comment;5;7;8;11;10;12;Attenuation and Ambient;0;0
Node;AmplifyShaderEditor.DotProductOpNode;3;-1616,144;Float;False;2;0;FLOAT3;0.0;False;1;FLOAT3;0.0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;5;-1093.099,59.30051;Float;False;Constant;_WrapperValue;Wrapper Value;0;0;0.5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;27;-896,928;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;29;-720,928;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LightAttenuation;7;-809.6001,504;Float;False;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;28;-832,1056;Float;False;Property;_RimPower;Rim Power;2;0;0.5;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.ScaleAndOffsetNode;4;-827.6974,-65.69949;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;1.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.IndirectDiffuseLighting;11;-624,448;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.PowerNode;30;-528,928;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;15;-594.4999,-58.89988;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-544,816;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LightColorNode;47;-256,1216;Float;False;0;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-384,480;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.LightColorNode;8;-768,368;Float;False;0;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;6;-224,-80;Float;True;Property;_ToonRamp;Toon Ramp;0;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/WarmToonRamp.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;34;-368,1040;Float;False;Property;_RimColor;Rim Color;1;1;[HDR];0,1,0.8758622,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-288,896;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;43;-224,-304;Float;True;Property;_Diffuse;Diffuse;4;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Misc/Checkers.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-224,368;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;192,-96;Float;False;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-64,1024;Float;False;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SaturateNode;32;-96,896;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;485.6002,153.2;Float;False;2;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;96,896;Float;False;2;0;FLOAT;0.0,0,0,0;False;1;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;39;832,384;Float;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1077.3,350.7;Float;False;True;2;Float;ASEMaterialInspector;0;CustomLighting;ASESampleShaders/CustomLightingToon;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;True;0.02;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;14;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;38;0;36;0
WireConnection;38;1;37;0
WireConnection;25;0;38;0
WireConnection;25;1;24;0
WireConnection;3;0;1;0
WireConnection;3;1;2;0
WireConnection;27;0;25;0
WireConnection;29;0;27;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;4;2;5;0
WireConnection;30;0;29;0
WireConnection;30;1;28;0
WireConnection;15;0;4;0
WireConnection;35;0;7;0
WireConnection;35;1;3;0
WireConnection;12;0;11;0
WireConnection;12;1;7;0
WireConnection;6;1;15;0
WireConnection;31;0;35;0
WireConnection;31;1;30;0
WireConnection;10;0;8;0
WireConnection;10;1;12;0
WireConnection;42;0;43;0
WireConnection;42;1;6;0
WireConnection;46;0;34;0
WireConnection;46;1;47;0
WireConnection;32;0;31;0
WireConnection;23;0;42;0
WireConnection;23;1;10;0
WireConnection;33;0;32;0
WireConnection;33;1;46;0
WireConnection;39;0;23;0
WireConnection;39;1;33;0
WireConnection;0;2;39;0
ASEEND*/
//CHKSM=4929E7767ABD1D05878E240E0FF8092D594542B8
