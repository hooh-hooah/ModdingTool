Shader "Suimono2/Demo/HairSpec" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
	_Shininess ("Shininess", Range (0.03, 2.0)) = 0.078125
	_Cutoff ("Cutoff Range", Range (0.0, 1.0)) = 0.1
	_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_BumpMap ("Normalmap", 2D) = "bump" {}
	_ReflectionTex ("Reflection", CUBE) = "" {}
	_RimColor ("Rim Color", Color) = (0.26,0.19,0.16,0.0)
    _RimPower ("Rim Power", Range(0.01,1.0)) = 1.0
    _RimColor2 ("Rim Color2", Color) = (0.26,0.19,0.16,0.0)
    _RimPower2 ("Rim Power2", Range(0.1,8.0)) = 3.0
}

SubShader {
	Tags {"IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 400
	
CGPROGRAM
#pragma target 3.0
#pragma surface surf BlinnPhong alphatest:_Cutoff

sampler2D _MainTex;
sampler2D _BumpMap;
float4 _Color;
float _Shininess;

struct Input {
	float2 uv_MainTex;
	float2 uv_BumpMap;
	float3 viewDir;
};

void surf (Input IN, inout SurfaceOutput o) {
	half4 tex = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = _Color.rgb * tex.r;
	//o.Gloss = tex.b;
	o.Alpha = tex.a * _Color.a;
	o.Specular = _Shininess;
	o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
	
	half rim = saturate(dot(normalize(IN.viewDir), o.Normal));
	o.Gloss = rim * tex.b;
	
}
ENDCG
}

FallBack "Transparent/Cutout/VertexLit"
}
