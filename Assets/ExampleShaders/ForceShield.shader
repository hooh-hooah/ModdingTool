// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X
Shader "ASESampleShaders/Community/TFHC/Force Shield"
{
	Properties
	{
		[HideInInspector] __dirty("", Int) = 1
		_Color("Color", Color) = (0,0,0,0)
		_Albedo("Albedo", 2D) = "white" {}
		_Normal("Normal", 2D) = "bump" {}
		_Opacity("Opacity", Range(0 , 1)) = 0.5
		_ShieldPatternColor("Shield Pattern Color", Color) = (0.2470588,0.7764706,0.9098039,1)
		_ShieldPattern("Shield Pattern", 2D) = "white" {}
		[IntRange]_ShieldPatternSize("Shield Pattern Size", Range(1 , 20)) = 5
		_ShieldPatternPower("Shield Pattern Power", Range(0 , 100)) = 5
		_ShieldRimPower("Shield Rim Power", Range(0 , 10)) = 7
		_ShieldAnimSpeed("Shield Anim Speed", Range(-10 , 10)) = 3
		_ShieldPatternWaves("Shield Pattern Waves", 2D) = "white" {}
		_ShieldDistortion("Shield Distortion", Range(0 , 0.03)) = 0.01
		_IntersectIntensity("Intersect Intensity", Range(0 , 1)) = 0.2
		_IntersectColor("Intersect Color", Color) = (0.03137255,0.2588235,0.3176471,1)
		_HitPosition("Hit Position", Vector) = (0,0,0,0)
		_HitTime("Hit Time", Float) = 0
		_HitColor("Hit Color", Color) = (1,1,1,1)
		_HitSize("Hit Size", Float) = 0.2
		[HideInInspector] _texcoord("", 2D) = "white" {}
	}

		SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
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
			float2 uv_texcoord;
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
			float2 texcoord_0;
			float2 texcoord_1;
			float4 screenPos;
		};

		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform float4 _Color;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform float4 _IntersectColor;
		uniform float _ShieldRimPower;
		uniform sampler2D _ShieldPattern;
		uniform float _ShieldPatternSize;
		uniform float _ShieldAnimSpeed;
		uniform sampler2D _ShieldPatternWaves;
		uniform float _HitTime;
		uniform float3 _HitPosition;
		uniform float _HitSize;
		uniform float4 _ShieldPatternColor;
		uniform float4 _HitColor;
		uniform sampler2D _CameraDepthTexture;
		uniform float _IntersectIntensity;
		uniform float _ShieldPatternPower;
		uniform float _Opacity;
		uniform float _ShieldDistortion;

		float3 mod289(float3 x) { return x - floor(x / 289.0) * 289.0; }

		float4 mod289(float4 x) { return x - floor(x / 289.0) * 289.0; }

		float4 permute(float4 x) { return mod289((x * 34.0 + 1.0) * x); }

		float4 taylorInvSqrt(float4 r) { return 1.79284291400159 - r * 0.85373472095314; }

		float snoise(float3 v)
		{
			const float2 C = float2(1.0 / 6.0, 1.0 / 3.0);
			float3 i = floor(v + dot(v, C.yyy));
			float3 x0 = v - i + dot(i, C.xxx);
			float3 g = step(x0.yzx, x0.xyz);
			float3 l = 1.0 - g;
			float3 i1 = min(g.xyz, l.zxy);
			float3 i2 = max(g.xyz, l.zxy);
			float3 x1 = x0 - i1 + C.xxx;
			float3 x2 = x0 - i2 + C.yyy;
			float3 x3 = x0 - 0.5;
			i = mod289(i);
			float4 p = permute(permute(permute(i.z + float4(0.0, i1.z, i2.z, 1.0)) + i.y + float4(0.0, i1.y, i2.y, 1.0)) + i.x + float4(0.0, i1.x, i2.x, 1.0));
			float4 j = p - 49.0 * floor(p / 49.0);  // mod(p,7*7)
			float4 x_ = floor(j / 7.0);
			float4 y_ = floor(j - 7.0 * x_);  // mod(j,N)
			float4 x = (x_ * 2.0 + 0.5) / 7.0 - 1.0;
			float4 y = (y_ * 2.0 + 0.5) / 7.0 - 1.0;
			float4 h = 1.0 - abs(x) - abs(y);
			float4 b0 = float4(x.xy, y.xy);
			float4 b1 = float4(x.zw, y.zw);
			float4 s0 = floor(b0) * 2.0 + 1.0;
			float4 s1 = floor(b1) * 2.0 + 1.0;
			float4 sh = -step(h, 0.0);
			float4 a0 = b0.xzyw + s0.xzyw * sh.xxyy;
			float4 a1 = b1.xzyw + s1.xzyw * sh.zzww;
			float3 g0 = float3(a0.xy, h.x);
			float3 g1 = float3(a0.zw, h.y);
			float3 g2 = float3(a1.xy, h.z);
			float3 g3 = float3(a1.zw, h.w);
			float4 norm = taylorInvSqrt(float4(dot(g0, g0), dot(g1, g1), dot(g2, g2), dot(g3, g3)));
			g0 *= norm.x;
			g1 *= norm.y;
			g2 *= norm.z;
			g3 *= norm.w;
			float4 m = max(0.6 - float4(dot(x0, x0), dot(x1, x1), dot(x2, x2), dot(x3, x3)), 0.0);
			m = m * m;
			m = m * m;
			float4 px = float4(dot(x0, g0), dot(x1, g1), dot(x2, g2), dot(x3, g3));
			return 42.0 * dot(m, px);
		}

		void vertexDataFunc(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			float2 appendResult130 = float2(_ShieldPatternSize , _ShieldPatternSize);
			float4 ShieldSpeed = (_Time * _ShieldAnimSpeed);
			float2 appendResult46 = float2(1 , ShieldSpeed.x);
			o.texcoord_0.xy = v.texcoord.xy * appendResult130 + appendResult46;
			float2 appendResult91 = float2(1 , (1.0 - (ShieldSpeed / 5.0)).x);
			o.texcoord_1.xy = v.texcoord.xy * float2(1,1) + appendResult91;
			float simplePerlin3D66 = snoise((float4(v.normal , 0.0) + (ShieldSpeed / 5.0)).xyz);
			float VertexOffset = ((_ShieldDistortion * -1.0) + (simplePerlin3D66 - 0.0) * (_ShieldDistortion - (_ShieldDistortion * -1.0)) / (1.0 - 0.0));
			float3 temp_cast_4 = (VertexOffset).xxx;
			v.vertex.xyz += temp_cast_4;
		}

		void surf(Input i , inout SurfaceOutputStandard o)
		{
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 Normal = UnpackNormal(tex2D(_Normal, uv_Normal));
			o.Normal = Normal;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 Albedo = (_Color * tex2D(_Albedo, uv_Albedo));
			o.Albedo = Albedo.rgb;
			float3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
			float3 ase_worldNormal = WorldNormalVector(i, float3(0, 0, 1));
			float ShieldRimPower = _ShieldRimPower;
			float fresnelFinalVal8 = (0.0 + 1.0 * pow(1.0 - dot(ase_worldNormal, worldViewDir) , (10.0 + (ShieldRimPower - 0.0) * (0.0 - 10.0) / (10.0 - 0.0))));
			float ShieldRim = fresnelFinalVal8;
			float4 ShieldPattern = tex2D(_ShieldPattern, i.texcoord_0);
			float4 waves = tex2D(_ShieldPatternWaves, i.texcoord_1);
			float4 ase_vertexPos = mul(unity_WorldToObject, float4(i.worldPos , 1));
			float temp_output_152_0 = distance(ase_vertexPos.xyz , _HitPosition);
			float HitSize = _HitSize;
			float4 ShieldPatternColor = _ShieldPatternColor;
			float4 HitColor = _HitColor;
			float4 hit = ((_HitTime > 0.0) ? ((temp_output_152_0 < HitSize) ? lerp(ShieldPatternColor , (HitColor * (HitSize / temp_output_152_0)) , (0.0 + (_HitTime - 0.0) * (1.0 - 0.0) / (100.0 - 0.0))) : ShieldPatternColor) : ShieldPatternColor);
			float4 ase_screenPos = float4(i.screenPos.xyz , i.screenPos.w + 0.00000000001);
			float screenDepth110 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth110 = abs((screenDepth110 - LinearEyeDepth(ase_screenPos.z / ase_screenPos.w)) / _IntersectIntensity);
			float ShieldPower = _ShieldPatternPower;
			float4 Emission = (lerp(_IntersectColor , (((ShieldRim + ShieldPattern) * waves) * (hit * ShieldPatternColor)) , clamp(distanceDepth110 , 0.0 , 1.0)) * ShieldPower);
			o.Emission = Emission.xyz;
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
				Input customInputData;
				vertexDataFunc(v, customInputData);
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
				half alphaRef = tex3D(_DitherMaskLOD, float3(vpos.xy * 0.25, o.Alpha * 0.9375)).a;
				clip(alphaRef - 0.01);
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
646;227;1066;638;6317.108;2106.027;6.142241;True;False
Node;AmplifyShaderEditor.CommentaryNode;267;-3724.017,-1789.098;Float;False;830.728;358.1541;Comment;4;35;34;36;84;Animation Speed;0;0
Node;AmplifyShaderEditor.TimeNode;34;-3600.425,-1739.099;Float;False;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;35;-3674.017,-1545.944;Float;False;Property;_ShieldAnimSpeed;Shield Anim Speed;9;0;3;-10;10;0;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;264;-3683.242,-319.7433;Float;False;1858.993;1001.87;Comment;22;137;247;195;167;239;260;263;152;136;142;205;246;200;245;257;250;170;206;140;141;138;139;Impact Effect;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-3357.889,-1615.685;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.CommentaryNode;268;-3701.449,-1016.252;Float;False;1608.543;477.595;Comment;10;93;88;92;90;89;91;97;87;86;94;Shield Wave Effect;0;0
Node;AmplifyShaderEditor.Vector3Node;136;-3624.635,276.1571;Float;False;Property;_HitPosition;Hit Position;14;0;0,0,0;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;142;-3633.242,91.85719;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;88;-3651.449,-740.2536;Float;False;84;0;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;93;-3624.584,-653.6565;Float;False;Constant;_Float0;Float 0;7;0;5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DistanceOpNode;152;-3393.037,175.4572;Float;False;2;0;FLOAT3;0.0;False;1;FLOAT3;0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;84;-3141.289,-1604.549;Float;False;ShieldSpeed;-1;True;1;0;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;140;-3553.337,-269.7433;Float;False;Property;_HitSize;Hit Size;17;0;0.2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;276;-2780.04,-1808.4;Float;False;1504.24;684.7161;Comment;12;44;129;130;46;41;1;17;85;3;12;6;15;Shield Main Pattern;0;0
Node;AmplifyShaderEditor.ColorNode;138;-3595.025,-162.8425;Float;False;Property;_HitColor;Hit Color;16;0;1,1,1,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;263;-3216.14,415.2251;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;260;-3173.049,344.7241;Float;False;141;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;92;-3443.617,-726.3981;Float;False;2;0;FLOAT4;0.0;False;1;FLOAT;0,5,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.CommentaryNode;275;-2010.258,-957.6005;Float;False;1030.896;385.0003;Comment;6;8;23;30;16;31;32;Shield RIM;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;141;-3340.137,-265.8431;Float;False;HitSize;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;3;-2716.901,-1757.5;Float;False;Property;_ShieldPatternColor;Shield Pattern Color;4;0;0.2470588,0.7764706,0.9098039,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.Vector2Node;44;-2642.899,-1440.7;Float;False;Constant;_Vector0;Vector 0;6;0;1,0;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;31;-1956.507,-905.8556;Float;False;Property;_ShieldRimPower;Shield Rim Power;8;0;7;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;129;-2730.04,-1558.843;Float;False;Property;_ShieldPatternSize;Shield Pattern Size;6;1;[IntRange];5;1;20;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;85;-2607.967,-1238.684;Float;False;84;0;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;250;-2961.252,459.8252;Float;False;139;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;139;-3313.854,-160.2898;Float;False;HitColor;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;137;-3157.953,205.9713;Float;False;Property;_HitTime;Hit Time;15;0;0;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.Vector2Node;89;-3303.329,-894.3962;Float;False;Constant;_Vector2;Vector 2;7;0;1,0;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;90;-3310.257,-736.7897;Float;False;1;0;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleDivideOpNode;239;-2978.346,549.1261;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;12;-2411.8,-1758.4;Float;False;ShieldPatternColor;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.TFHCRemap;247;-2924.85,284.5252;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;100.0;False;3;FLOAT;0.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;246;-2774.949,8.125095;Float;False;12;0;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;257;-2735.152,466.5251;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.AppendNode;130;-2390.04,-1534.843;Float;False;FLOAT2;0;0;0;0;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.AppendNode;46;-2364.299,-1326.101;Float;False;FLOAT2;0;0;0;0;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.Vector2Node;97;-3110.929,-966.2515;Float;False;Constant;_Vector3;Vector 3;7;0;1,1;0;3;FLOAT2;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-1602.599,-907.6003;Float;False;ShieldRimPower;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;16;-1960.258,-774.4995;Float;False;32;0;1;FLOAT
Node;AmplifyShaderEditor.AppendNode;91;-3107.62,-842.438;Float;False;FLOAT2;0;0;0;0;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.WireNode;195;-2864.125,74.0632;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;87;-2911.91,-851.0977;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;167;-2793.819,134.2182;Float;False;141;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;30;-1664.799,-774.5996;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;10.0;False;3;FLOAT;10.0;False;4;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;245;-2595.05,273.4252;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0;False;1;COLOR
Node;AmplifyShaderEditor.TextureCoordinatesNode;41;-2180.397,-1393.801;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TFHCCompareLower;200;-2404.936,152.4901;Float;False;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.FresnelNode;8;-1453.2,-772.8999;Float;False;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;5.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;86;-2670.01,-866.47;Float;True;Property;_ShieldPatternWaves;Shield Pattern Waves;10;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;269;-3643.936,791.2545;Float;False;1652.997;650.1895;Mix of Pattern, Wave, Rim , Impact and adding intersection highlight;18;125;22;53;210;262;5;122;113;124;127;126;120;114;110;96;95;270;20;Shield Mix for Emission;0;0
Node;AmplifyShaderEditor.SamplerNode;1;-1921.001,-1410.9;Float;True;Property;_ShieldPattern;Shield Pattern;5;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.WireNode;206;-2903.502,-28.46932;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.TFHCCompareGreater;205;-2263.548,-95.30942;Float;False;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;COLOR;0.0;False;3;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.CommentaryNode;274;-1717.715,-307.0486;Float;False;1223.975;464.9008;Comment;11;78;271;66;75;65;77;70;76;102;103;273;Shield Distortion;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-1222.362,-776.9688;Float;False;ShieldRim;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;94;-2335.905,-876.1152;Float;False;waves;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;22;-3584.001,980.0004;Float;False;23;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;17;-1531.8,-1409.1;Float;False;ShieldPattern;-1;True;1;0;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;20;-3575.06,1149.144;Float;False;94;0;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;125;-3593.936,1070.857;Float;False;17;0;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;210;-3343.573,1156.821;Float;False;170;0;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;53;-3356.611,1019.996;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.WireNode;270;-3376.64,1137.324;Float;False;1;0;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;77;-1628.587,-0.2153163;Float;False;Constant;_Float1;Float 1;7;0;5;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;70;-1667.715,-98.43153;Float;False;84;0;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;96;-3423.322,1239.746;Float;False;12;0;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;114;-3430.724,1320.123;Float;False;Property;_IntersectIntensity;Intersect Intensity;12;0;0.2;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;170;-2067.248,-91.50217;Float;False;hit;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.DepthFade;110;-3064.584,1323.016;Float;False;1;0;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-3180.476,1043.63;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.NormalVertexDataNode;65;-1538.567,-257.0485;Float;False;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;76;-1443.8,-69.77253;Float;False;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;262;-3099.446,1224.126;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.ColorNode;122;-2961.037,841.2547;Float;False;Property;_IntersectColor;Intersect Color;13;0;0.03137255,0.2588235,0.3176471,1;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;6;-2023.2,-1712.1;Float;False;Property;_ShieldPatternPower;Shield Pattern Power;7;0;5;0;100;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;102;-1432.937,42.85229;Float;False;Property;_ShieldDistortion;Shield Distortion;11;0;0.01;0;0.03;0;1;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;113;-2848.431,1285.444;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;75;-1275.199,-227.1813;Float;False;2;2;0;FLOAT3;0.0;False;1;FLOAT4;0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.CommentaryNode;284;-1631.041,335.9565;Float;False;837.0001;689.9695;Comment;6;278;128;279;282;281;277;Textures;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;95;-2938.129,1038.449;Float;True;2;2;0;FLOAT4;0.0;False;1;COLOR;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.NoiseGeneratorNode;66;-1129.406,-211.8437;Float;False;Simplex3D;1;0;FLOAT3;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;127;-2642.838,1189.758;Float;False;15;0;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;128;-1553.537,385.9566;Float;False;Property;_Color;Color;0;0;0,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;124;-2659.837,1049.354;Float;False;3;0;COLOR;0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;2;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.WireNode;273;-1017.54,35.32507;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;277;-1574.641,576.7259;Float;True;Property;_Albedo;Albedo;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;15;-1703.199,-1702.2;Float;False;ShieldPower;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-1109.437,-114.2458;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;-1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;278;-1200.241,544.7261;Float;False;2;2;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;126;-2417.239,1079.357;Float;False;2;2;0;FLOAT4;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SamplerNode;281;-1581.041,795.9265;Float;True;Property;_Normal;Normal;2;0;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TFHCRemap;78;-940.037,-166.6066;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-0.01;False;4;FLOAT;0.01;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;272;-846.4404,-1252.875;Float;False;271;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;28;-893.5145,-1351.604;Float;False;Property;_Opacity;Opacity;3;0;0.5;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;121;-797.6182,-1439.73;Float;False;120;0;1;FLOAT4
Node;AmplifyShaderEditor.GetLocalVarNode;280;-795.4412,-1626.674;Float;False;279;0;1;COLOR
Node;AmplifyShaderEditor.GetLocalVarNode;283;-822.6411,-1533.874;Float;False;282;0;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;120;-2233.938,1054.355;Float;False;Emission;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.RegisterLocalVarNode;282;-1193.841,803.9265;Float;False;Normal;-1;True;1;0;FLOAT3;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.RegisterLocalVarNode;271;-743.7402,-158.5751;Float;False;VertexOffset;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;279;-1037.041,538.3261;Float;False;Albedo;-1;True;1;0;COLOR;0.0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-551.0419,-1550.427;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;ASESampleShaders/Community/TFHC/Force Shield;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;Back;1;7;False;0;0;Transparent;0.5;True;True;0;False;Transparent;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;-1;-1;-1;-1;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;152;0;142;0
WireConnection;152;1;136;0
WireConnection;84;0;36;0
WireConnection;263;0;152;0
WireConnection;92;0;88;0
WireConnection;92;1;93;0
WireConnection;141;0;140;0
WireConnection;139;0;138;0
WireConnection;90;0;92;0
WireConnection;239;0;260;0
WireConnection;239;1;263;0
WireConnection;12;0;3;0
WireConnection;247;0;137;0
WireConnection;257;0;250;0
WireConnection;257;1;239;0
WireConnection;130;0;129;0
WireConnection;130;1;129;0
WireConnection;46;0;44;1
WireConnection;46;1;85;0
WireConnection;32;0;31;0
WireConnection;91;0;89;1
WireConnection;91;1;90;0
WireConnection;195;0;152;0
WireConnection;87;0;97;0
WireConnection;87;1;91;0
WireConnection;30;0;16;0
WireConnection;245;0;246;0
WireConnection;245;1;257;0
WireConnection;245;2;247;0
WireConnection;41;0;130;0
WireConnection;41;1;46;0
WireConnection;200;0;195;0
WireConnection;200;1;167;0
WireConnection;200;2;245;0
WireConnection;200;3;246;0
WireConnection;8;3;30;0
WireConnection;86;1;87;0
WireConnection;1;1;41;0
WireConnection;206;0;137;0
WireConnection;205;0;206;0
WireConnection;205;2;200;0
WireConnection;205;3;246;0
WireConnection;23;0;8;0
WireConnection;94;0;86;0
WireConnection;17;0;1;0
WireConnection;53;0;22;0
WireConnection;53;1;125;0
WireConnection;270;0;20;0
WireConnection;170;0;205;0
WireConnection;110;0;114;0
WireConnection;5;0;53;0
WireConnection;5;1;270;0
WireConnection;76;0;70;0
WireConnection;76;1;77;0
WireConnection;262;0;210;0
WireConnection;262;1;96;0
WireConnection;113;0;110;0
WireConnection;75;0;65;0
WireConnection;75;1;76;0
WireConnection;95;0;5;0
WireConnection;95;1;262;0
WireConnection;66;0;75;0
WireConnection;124;0;122;0
WireConnection;124;1;95;0
WireConnection;124;2;113;0
WireConnection;273;0;102;0
WireConnection;15;0;6;0
WireConnection;103;0;102;0
WireConnection;278;0;128;0
WireConnection;278;1;277;0
WireConnection;126;0;124;0
WireConnection;126;1;127;0
WireConnection;78;0;66;0
WireConnection;78;3;103;0
WireConnection;78;4;273;0
WireConnection;120;0;126;0
WireConnection;282;0;281;0
WireConnection;271;0;78;0
WireConnection;279;0;278;0
WireConnection;0;0;280;0
WireConnection;0;1;283;0
WireConnection;0;2;121;0
WireConnection;0;9;28;0
WireConnection;0;11;272;0
ASEEND*/
//CHKSM=DFB0510FEFCC5D069AF3947B1A89A8F595BCD026