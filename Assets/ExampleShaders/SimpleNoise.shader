// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Simple/SimpleNoise"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MaskClipValue( "Mask Clip Value", Float ) = 0.28
		_Size("Size", Vector) = (0,0,0,0)
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_Strength("Strength", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 4.6
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;
		uniform float2 _Size;
		uniform float _Strength;
		uniform float _MaskClipValue = 0.28;


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


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float simplePerlin2D205 = snoise( ( _Size * uv_TextureSample0 ) );
			float2 temp_cast_0 = ( simplePerlin2D205 * _Strength );
			o.Emission = tex2D( _TextureSample0,( uv_TextureSample0 + temp_cast_0 )).xyz;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=5002
339;92;1190;648;-1333.154;591.699;1.3;False;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;213;1604.246,-180.3998;Float;0;210;2;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.SimpleAddOpNode;214;1868.557,-58.60012;Float;FLOAT2;0.0;FLOAT;0.0,0
Node;AmplifyShaderEditor.SamplerNode;210;2028.653,-126.8006;Float;Property;_TextureSample0;Texture Sample 0;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;SAMPLER2D;;FLOAT2;0,0;FLOAT;1.0;FLOAT2;0,0;FLOAT2;0,0;FLOAT;1.0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;212;1715.259,47.89908;Float;FLOAT;0.0;FLOAT;0.0
Node;AmplifyShaderEditor.RangedFloatNode;211;1538.458,108.999;Float;Property;_Strength;Strength;2;0;0;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;200;1398.767,-79.30207;Float;FLOAT2;0.0;FLOAT2;0.0,0
Node;AmplifyShaderEditor.TextureCoordinatesNode;198;1095.557,21.3978;Float;0;210;2;FLOAT2;1,1;FLOAT2;0,0
Node;AmplifyShaderEditor.Vector2Node;199;1194.76,-149.3016;Float;Property;_Size;Size;1;0;0,0
Node;AmplifyShaderEditor.NoiseGeneratorNode;205;1546.165,-24.90001;Float;Simplex2D;FLOAT2;0,0,0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2385.304,-300.1997;Float;True;6;Float;ASEMaterialInspector;Standard;ASESampleShaders/Simple/SimpleNoise;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Masked;0.28;True;True;0;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;1;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;FLOAT;0.0;FLOAT3;0,0,0;FLOAT3;0,0,0;FLOAT;0.0;FLOAT;0.0;OBJECT;0;FLOAT3;0.0,0,0;FLOAT3;0.0,0,0;OBJECT;0;FLOAT4;0,0,0,0;FLOAT3;0,0,0
WireConnection;214;0;213;0
WireConnection;214;1;212;0
WireConnection;210;1;214;0
WireConnection;212;0;205;0
WireConnection;212;1;211;0
WireConnection;200;0;199;0
WireConnection;200;1;198;0
WireConnection;205;0;200;0
WireConnection;0;2;210;0
ASEEND*/
//CHKSM=BBB0EE18F9E3836D4D7B31D048E8F2E5439D58CB
