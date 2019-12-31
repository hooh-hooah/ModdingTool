// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X
Shader "ASESampleShaders/Community/TFHC/2 Sided"
{
	Properties
	{
		[HideInInspector] __dirty("", Int) = 1
		_MaskClipValue("Mask Clip Value", Float) = 0.5
		_FrontFacesColor("Front Faces Color", Color) = (1,0,0,0)
		_FrontFacesAlbedo("Front Faces Albedo", 2D) = "white" {}
		_FrontFacesNormal("Front Faces Normal", 2D) = "bump" {}
		_BackFacesColor("Back Faces Color", Color) = (0,0.04827571,1,0)
		_BackFacesAlbedo("Back Faces Albedo", 2D) = "white" {}
		_BackFacesNormal("Back Faces Normal", 2D) = "bump" {}
		_OpacityMask("Opacity Mask", 2D) = "white" {}
		[HideInInspector] _texcoord("", 2D) = "white" {}
	}

		SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Off
		Stencil
		{
			Ref 1
			Comp Always
			Pass Replace
		}
		CGINCLUDE
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
			float2 uv_texcoord;
			float3 worldNormal;
			INTERNAL_DATA
			float3 worldPos;
		};

		uniform sampler2D _FrontFacesNormal;
		uniform float4 _FrontFacesNormal_ST;
		uniform sampler2D _BackFacesNormal;
		uniform float4 _BackFacesNormal_ST;
		uniform float4 _FrontFacesColor;
		uniform sampler2D _FrontFacesAlbedo;
		uniform float4 _FrontFacesAlbedo_ST;
		uniform float4 _BackFacesColor;
		uniform sampler2D _BackFacesAlbedo;
		uniform float4 _BackFacesAlbedo_ST;
		uniform sampler2D _OpacityMask;
		uniform float4 _OpacityMask_ST;
		uniform float _MaskClipValue = 0.5;

		void surf(Input i , inout SurfaceOutputStandard o)
		{
			float2 uv_FrontFacesNormal = i.uv_texcoord * _FrontFacesNormal_ST.xy + _FrontFacesNormal_ST.zw;
			float3 FrontFacesNormal = UnpackNormal(tex2D(_FrontFacesNormal, uv_FrontFacesNormal));
			float2 uv_BackFacesNormal = i.uv_texcoord * _BackFacesNormal_ST.xy + _BackFacesNormal_ST.zw;
			float3 BackFacesNormal = UnpackNormal(tex2D(_BackFacesNormal, uv_BackFacesNormal));
			float3 ase_worldNormal = WorldNormalVector(i, float3(0, 0, 1));
			float3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
			float FaceSign = (1.0 + (sign(dot(ase_worldNormal , worldViewDir)) - -1.0) * (0.0 - 1.0) / (1.0 - -1.0));
			o.Normal = lerp(FrontFacesNormal , BackFacesNormal , FaceSign);
			float2 uv_FrontFacesAlbedo = i.uv_texcoord * _FrontFacesAlbedo_ST.xy + _FrontFacesAlbedo_ST.zw;
			float4 FrontFacesAlbedo = (_FrontFacesColor * tex2D(_FrontFacesAlbedo, uv_FrontFacesAlbedo));
			float2 uv_BackFacesAlbedo = i.uv_texcoord * _BackFacesAlbedo_ST.xy + _BackFacesAlbedo_ST.zw;
			float4 BackFacesAlbedo = (_BackFacesColor * tex2D(_BackFacesAlbedo, uv_BackFacesAlbedo));
			o.Albedo = lerp(FrontFacesAlbedo , BackFacesAlbedo , FaceSign).rgb;
			o.Alpha = 1;
			float2 uv_OpacityMask = i.uv_texcoord * _OpacityMask_ST.xy + _OpacityMask_ST.zw;
			float OpacityMask = tex2D(_OpacityMask, uv_OpacityMask).a;
			clip(OpacityMask - _MaskClipValue);
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard keepalpha fullforwardshadows

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
			v2f vert(appdata_full v)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_OUTPUT(v2f, o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				fixed3 worldTangent = UnityObjectToWorldDir(v.tangent.xyz);
				fixed tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				fixed3 worldBinormal = cross(worldNormal, worldTangent) * tangentSign;
				o.tSpace0 = float4(worldTangent.x, worldBinormal.x, worldNormal.x, worldPos.x);
				o.tSpace1 = float4(worldTangent.y, worldBinormal.y, worldNormal.y, worldPos.y);
				o.tSpace2 = float4(worldTangent.z, worldBinormal.z, worldNormal.z, worldPos.z);
				o.texcoords01 = float4(v.texcoord.xy, v.texcoord1.xy);
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
				return o;
			}
			fixed4 frag(v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(IN);
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT(Input, surfIN);
				surfIN.uv_texcoord.xy = IN.texcoords01.xy;
				float3 worldPos = float3(IN.tSpace0.w, IN.tSpace1.w, IN.tSpace2.w);
				fixed3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				surfIN.worldPos = worldPos;
				surfIN.worldNormal = float3(IN.tSpace0.z, IN.tSpace1.z, IN.tSpace2.z);
				surfIN.internalSurfaceTtoW0 = IN.tSpace0.xyz;
				surfIN.internalSurfaceTtoW1 = IN.tSpace1.xyz;
				surfIN.internalSurfaceTtoW2 = IN.tSpace2.xyz;
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT(SurfaceOutputStandard, o)
				surf(surfIN, o);
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				SHADOW_CASTER_FRAGMENT(IN)
			}
			ENDCG
		}
	}
		Fallback "Diffuse"
					CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=10011
646;227;1066;638;1866.415;636.1154;1.9;True;False
Node;AmplifyShaderEditor.CommentaryNode;49;-1774.799,4.739527;Float;False;1094.131;402.4268;Comment;6;20;22;23;48;19;41;Face Sign (0 = Front, 1 = Back);0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;19;-1699.579,223.1664;Float;False;World;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WorldNormalVector;41;-1724.799,54.73954;Float;False;1;0;FLOAT3;0,0,0;False;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;20;-1466.548,149.8606;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;52;-1776.875,-811.7521;Float;False;870.9222;707.2373;Comment;6;43;44;28;42;50;51;Front Faces;0;0
Node;AmplifyShaderEditor.CommentaryNode;55;-864.2166,-812.0974;Float;False;865.924;714.2354;Comment;6;45;46;47;29;53;54;Back Faces;0;0
Node;AmplifyShaderEditor.ColorNode;28;-1708.367,-761.7521;Float;False;Property;_FrontFacesColor;Front Faces Color;0;0;1,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;29;-772.7956,-762.0974;Float;False;Property;_BackFacesColor;Back Faces Color;3;0;0,0.04827571,1,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;45;-814.2166,-573.6706;Float;True;Property;_BackFacesAlbedo;Back Faces Albedo;4;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;42;-1726.875,-565.9415;Float;True;Property;_FrontFacesAlbedo;Front Faces Albedo;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SignOpNode;22;-1298.996,161.4731;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;57;-614.5056,32.69087;Float;False;626.0693;280;Comment;2;56;27;Opacity Mask;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;46;-423.7787,-601.559;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT4;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1358.749,-630.0837;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT4;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;50;-1700.404,-334.5151;Float;True;Property;_FrontFacesNormal;Front Faces Normal;2;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;53;-762.2464,-327.8621;Float;True;Property;_BackFacesNormal;Back Faces Normal;5;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;23;-1136.493,143.3126;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;2;FLOAT;1.0;False;3;FLOAT;1.0;False;4;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;47;-245.2925,-601.559;Float;False;BackFacesAlbedo;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;-430.3735,-314.3162;Float;False;BackFacesNormal;-1;True;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;60;118.8098,-452.1644;Float;False;47;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;51;-1358.372,-334.5151;Float;False;FrontFacesNormal;-1;True;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;44;-1157.953,-630.0831;Float;False;FrontFacesAlbedo;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;62;119.0541,-269.2288;Float;False;51;0;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;48;-914.667,139.6586;Float;False;FaceSign;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;59;141.1735,-548.2174;Float;False;44;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;61;165.1398,-361.4234;Float;False;48;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;65;143.0204,-84.28967;Float;False;48;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;63;117.0938,-175.0307;Float;False;54;0;1;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;27;-564.5056,82.69086;Float;True;Property;_OpacityMask;Opacity Mask;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-222.4362,170.9077;Float;False;OpacityMask;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;64;375.2734,-209.8589;Float;False;3;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0;False;2;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;58;345.5315,126.3971;Float;False;56;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;24;404.8121,-409.0887;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;596.1226,-305.096;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;ASESampleShaders/Community/TFHC/2 Sided;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Masked;0.5;True;True;0;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;1;255;255;7;3;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;1,0.4344827,0,0;VertexScale;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;20;0;41;0
WireConnection;20;1;19;0
WireConnection;22;0;20;0
WireConnection;46;0;29;0
WireConnection;46;1;45;0
WireConnection;43;0;28;0
WireConnection;43;1;42;0
WireConnection;23;0;22;0
WireConnection;47;0;46;0
WireConnection;54;0;53;0
WireConnection;51;0;50;0
WireConnection;44;0;43;0
WireConnection;48;0;23;0
WireConnection;56;0;27;4
WireConnection;64;0;62;0
WireConnection;64;1;63;0
WireConnection;64;2;65;0
WireConnection;24;0;59;0
WireConnection;24;1;60;0
WireConnection;24;2;61;0
WireConnection;0;0;24;0
WireConnection;0;1;64;0
WireConnection;0;10;58;0
ASEEND*/
//CHKSM=C7892A3B0CD9F89298ADCEB0093D67A509CB3721