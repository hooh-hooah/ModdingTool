// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Community/TFHC/Hologram Simple"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_Hologramcolor("Hologram color", Color) = (0.3973832,0.7720588,0.7410512,0)
		_Speed("Speed", Range( 0 , 100)) = 26
		_ScanLines("Scan Lines", Range( 0 , 10)) = 3
		_Opacity("Opacity", Range( 0 , 1)) = 0.5
		_RimNormalMap("Rim Normal Map", 2D) = "bump" {}
		_RimPower("Rim Power", Range( 0 , 10)) = 5
		_Intensity("Intensity", Range( 1 , 10)) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
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
			float3 worldPos;
			float2 texcoord_0;
			float3 viewDir;
			INTERNAL_DATA
		};

		uniform float4 _Hologramcolor;
		uniform float _ScanLines;
		uniform float _Speed;
		uniform sampler2D _RimNormalMap;
		uniform float _RimPower;
		uniform float _Intensity;
		uniform float _Opacity;


		float3 mod289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Normal = float3(0,0,1);
			float4 HologramColor32 = _Hologramcolor;
			float3 ase_worldPos = i.worldPos;
			float Speed156 = _Speed;
			float componentMask105 = ( 1.0 - ( Speed156 * _Time ) ).x;
			float temp_output_13_0 = sin( ( ( ( _ScanLines * ase_worldPos.y ) + componentMask105 ) * UNITY_PI ) );
			float clampResult15 = clamp( (0.0 + (temp_output_13_0 - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) , 0.0 , 1.0 );
			float4 lerpResult16 = lerp( float4(1,1,1,0) , float4(0,0,0,0) , clampResult15);
			float2 temp_cast_0 = (( ( ase_worldPos.z / 100.0 ) * _Time.x )).xx;
			float simplePerlin2D137 = snoise( temp_cast_0 );
			float myVarName3146 = ( simplePerlin2D137 * temp_output_13_0 );
			float4 temp_cast_1 = (myVarName3146).xxxx;
			float4 ScanLines30 = ( lerpResult16 - temp_cast_1 );
			float3 normalizeResult57 = normalize( i.viewDir );
			float dotResult55 = dot( UnpackNormal( tex2D( _RimNormalMap, ( ( ( Speed156 / 1000.0 ) * _Time ) + float4( i.texcoord_0, 0.0 , 0.0 ) ).xy ) ) , normalizeResult57 );
			float temp_output_60_0 = pow( ( 1.0 - saturate( dotResult55 ) ) , ( 10.0 - _RimPower ) );
			float Rim65 = temp_output_60_0;
			o.Emission = ( ( HologramColor32 * ( ScanLines30 + Rim65 ) ) * _Intensity ).rgb;
			o.Alpha = _Opacity;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

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
				fixed3 worldNormal = UnityObjectToWorldNormal( v.normal );
				fixed3 worldTangent = UnityObjectToWorldDir( v.tangent.xyz );
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross( worldNormal, worldTangent ) * tangentSign;
				o.tSpace0 = float4( worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x );
				o.tSpace1 = float4( worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y );
				o.tSpace2 = float4( worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z );
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
				surfIN.worldPos = worldPos;
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
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
Version=13201
465;92;958;768;2680.949;159.3924;1;False;False
Node;AmplifyShaderEditor.CommentaryNode;168;-1574.711,-440.4086;Float;False;614.0698;167.2261;Comment;2;6;156;Speed;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;170;-3047.519,563.0162;Float;False;2377.06;920.5361;Comment;26;26;157;27;10;8;2;106;105;107;3;144;11;143;150;13;145;137;14;18;15;149;17;16;146;155;30;Scan Lines;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1524.711,-388.1825;Float;False;Property;_Speed;Speed;1;0;26;0;100;0;1;FLOAT
Node;AmplifyShaderEditor.TimeNode;26;-2997.519,1281.553;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;156;-1194.641,-390.4085;Float;False;Speed;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;157;-2993.246,1177.753;Float;False;156;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-2769.481,1243.729;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT4;0;False;1;FLOAT4
Node;AmplifyShaderEditor.CommentaryNode;169;-3022.51,-122.5578;Float;False;2344.672;617.4507;Comment;18;58;57;119;55;63;62;64;68;60;65;59;66;163;158;162;167;166;165;Rim;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;8;-2611.384,1214.243;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;10;-2783.819,964.6287;Float;False;Property;_ScanLines;Scan Lines;2;0;3;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;162;-2972.51,-72.55784;Float;False;156;0;1;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;2;-2754.312,1057.975;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;167;-2720.792,-42.13026;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;1000.0;False;1;FLOAT
Node;AmplifyShaderEditor.TimeNode;165;-2968.947,36.28125;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-2400.944,1101.32;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;6.06;False;1;FLOAT
Node;AmplifyShaderEditor.ComponentMaskNode;105;-2434.701,1217.699;Float;False;True;False;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.WorldPosInputsNode;144;-2609.936,613.0162;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;158;-2763.859,253.5992;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PiNode;107;-2193.45,1213.31;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-2589.954,11.35542;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT4;0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleAddOpNode;3;-2208.283,1082.542;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;150;-2362.372,665.1646;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;100.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;163;-2419.413,25.78291;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0.0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-2002.272,1085.993;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.TimeNode;143;-2697.425,757.8511;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;58;-2208.716,196.8163;Float;False;Tangent;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;119;-2228.099,-27.17607;Float;True;Property;_RimNormalMap;Rim Normal Map;4;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/SceneTextures/TarpNormal.tif;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.NormalizeNode;57;-2054.684,223.904;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SinOpNode;13;-1847.759,1170.244;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-2267.856,811.0703;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;55;-1875.59,100.9621;Float;False;2;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.NoiseGeneratorNode;137;-2063.933,770.715;Float;False;Simplex2D;1;0;FLOAT2;100,100;False;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;14;-1639.093,1130.662;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;2;FLOAT;1.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;17;-1632.495,762.2489;Float;False;Constant;_Color0;Color 0;2;0;1,1,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-1810.827,884.863;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SaturateNode;63;-1687.319,157.5161;Float;False;1;0;FLOAT;1.23;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;62;-2158.147,356.4128;Float;False;Property;_RimPower;Rim Power;5;0;5;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;15;-1445.146,1120.62;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;18;-1634.394,936.9765;Float;False;Constant;_Color1;Color 1;2;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;-1656.203,668.247;Float;False;myVarName3;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;64;-1518.314,199.8154;Float;False;1;0;FLOAT;0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;16;-1252.978,949.5414;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleSubtractOpNode;68;-1742.309,285.1235;Float;False;2;0;FLOAT;10.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;155;-1067.775,881.9498;Float;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.PowerNode;60;-1325.516,223.2159;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;35;-2281.517,-488.6837;Float;False;590.8936;257.7873;Comment;2;32;28;Hologram Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.ColorNode;28;-2231.517,-438.6837;Float;False;Property;_Hologramcolor;Hologram color;0;0;0.3973832,0.7720588,0.7410512,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;65;-911.8385,239.3701;Float;False;Rim;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;33;-776.9076,-324.7064;Float;False;65;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-904.4599,898.7253;Float;False;ScanLines;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;114;-783.5459,-416.9459;Float;False;30;0;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;71;-520.487,-338.0593;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;127;-557.7931,-444.785;Float;False;32;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-1963.584,-399.5394;Float;False;HologramColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-302.4253,-399.4778;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;132;-542.2174,-228.0388;Float;False;Property;_Intensity;Intensity;6;0;1;1;10;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;59;-1083.116,238.4155;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;49;-317.1664,-56.16708;Float;False;Property;_Opacity;Opacity;3;0;0.5;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;133;-142.8775,-291.8895;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;66;-1368.539,379.8929;Float;False;32;0;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;89.8217,-401.0934;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Community/TFHC/Hologram Simple;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;156;0;6;0
WireConnection;27;0;157;0
WireConnection;27;1;26;0
WireConnection;8;0;27;0
WireConnection;167;0;162;0
WireConnection;106;0;10;0
WireConnection;106;1;2;2
WireConnection;105;0;8;0
WireConnection;166;0;167;0
WireConnection;166;1;165;0
WireConnection;3;0;106;0
WireConnection;3;1;105;0
WireConnection;150;0;144;3
WireConnection;163;0;166;0
WireConnection;163;1;158;0
WireConnection;11;0;3;0
WireConnection;11;1;107;0
WireConnection;119;1;163;0
WireConnection;57;0;58;0
WireConnection;13;0;11;0
WireConnection;145;0;150;0
WireConnection;145;1;143;1
WireConnection;55;0;119;0
WireConnection;55;1;57;0
WireConnection;137;0;145;0
WireConnection;14;0;13;0
WireConnection;149;0;137;0
WireConnection;149;1;13;0
WireConnection;63;0;55;0
WireConnection;15;0;14;0
WireConnection;146;0;149;0
WireConnection;64;0;63;0
WireConnection;16;0;17;0
WireConnection;16;1;18;0
WireConnection;16;2;15;0
WireConnection;68;1;62;0
WireConnection;155;0;16;0
WireConnection;155;1;146;0
WireConnection;60;0;64;0
WireConnection;60;1;68;0
WireConnection;65;0;60;0
WireConnection;30;0;155;0
WireConnection;71;0;114;0
WireConnection;71;1;33;0
WireConnection;32;0;28;0
WireConnection;126;0;127;0
WireConnection;126;1;71;0
WireConnection;59;0;60;0
WireConnection;59;1;66;0
WireConnection;133;0;126;0
WireConnection;133;1;132;0
WireConnection;0;2;133;0
WireConnection;0;9;49;0
ASEEND*/
//CHKSM=46A63FB40825A5A8DF622273C2D2468CC0C626C4
