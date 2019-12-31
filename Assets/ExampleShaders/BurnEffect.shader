// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/BurnEffect"
{
	Properties
	{
		_AlbedoMix("Albedo Mix", Range( 0 , 1)) = 0.5
		_CharcoalMix("Charcoal Mix", Range( 0 , 1)) = 1
		EmberColorTint("Ember Color Tint", Color) = (0.9926471,0.6777384,0,1)
		Albedo("Albedo", 2D) = "white" {}
		Normals("Normals", 2D) = "bump" {}
		BaseEmber("Base Ember", Range( 0 , 1)) = 0
		GlowEmissionMultiplier("Glow Emission Multiplier", Range( 0 , 30)) = 1
		GlowColorIntensity("Glow Color Intensity", Range( 0 , 10)) = 0
		_BurnOffset("Burn Offset", Range( 0 , 5)) = 1
		_CharcoalNormalTile("Charcoal Normal Tile", Range( 2 , 5)) = 5
		_BurnTilling("Burn Tilling", Range( 0.1 , 1)) = 1
		GlowBaseFrequency("Glow Base Frequency", Range( 0 , 5)) = 1.1
		GlowOverride("Glow Override", Range( 0 , 10)) = 1
		Masks("Masks", 2D) = "white" {}
		BurntTileNormals("Burnt Tile Normals", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			fixed2 uv_texcoord;
		};

		uniform sampler2D Normals;
		uniform sampler2D BurntTileNormals;
		uniform fixed _CharcoalNormalTile;
		uniform fixed _CharcoalMix;
		uniform sampler2D Masks;
		uniform fixed _BurnOffset;
		uniform fixed _BurnTilling;
		uniform sampler2D Albedo;
		uniform fixed _AlbedoMix;
		uniform fixed BaseEmber;
		uniform fixed4 EmberColorTint;
		uniform fixed GlowColorIntensity;
		uniform fixed GlowBaseFrequency;
		uniform fixed GlowOverride;
		uniform fixed GlowEmissionMultiplier;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord179 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			fixed4 tex2DNode83 = tex2D( BurntTileNormals, ( uv_TexCoord179 * _CharcoalNormalTile ) );
			float4 appendResult182 = (fixed4(1.0 , tex2DNode83.g , 0 , tex2DNode83.r));
			float2 uv_TexCoord180 = i.uv_texcoord * float2( 1,1 ) + float2( 0,0 );
			float2 panner9 = ( ( uv_TexCoord180 * _BurnTilling ) + _BurnOffset * float2( 1,0.5 ));
			fixed4 tex2DNode98 = tex2D( Masks, panner9 );
			float temp_output_19_0 = ( _CharcoalMix + tex2DNode98.r );
			float3 lerpResult103 = lerp( UnpackNormal( tex2D( Normals, uv_TexCoord179 ) ) , UnpackNormal( appendResult182 ) , temp_output_19_0);
			o.Normal = lerpResult103;
			fixed4 tex2DNode80 = tex2D( Albedo, uv_TexCoord180 );
			fixed4 temp_cast_0 = (0.0).xxxx;
			float4 lerpResult28 = lerp( ( tex2DNode80 * _AlbedoMix ) , temp_cast_0 , temp_output_19_0);
			float4 lerpResult148 = lerp( ( fixed4(0.718,0.0627451,0,1) * ( tex2DNode83.a * 2.95 ) ) , ( fixed4(0.647,0.06297875,0,1) * ( tex2DNode83.a * 4.2 ) ) , tex2DNode98.g);
			float4 lerpResult152 = lerp( lerpResult28 , ( ( lerpResult148 * tex2DNode98.r ) * BaseEmber ) , ( tex2DNode98.r * 1.0 ));
			o.Albedo = lerpResult152.rgb;
			fixed4 temp_cast_2 = (0.0).xxxx;
			fixed4 temp_cast_3 = (100.0).xxxx;
			float4 clampResult176 = clamp( ( ( tex2DNode98.r * ( ( ( ( EmberColorTint * GlowColorIntensity ) * ( ( sin( ( _Time.y * GlowBaseFrequency ) ) * 0.5 ) + ( GlowOverride * ( tex2DNode98.r * tex2DNode83.a ) ) ) ) * tex2DNode98.g ) * tex2DNode83.a ) ) * GlowEmissionMultiplier ) , temp_cast_2 , temp_cast_3 );
			o.Emission = clampResult176.rgb;
			o.Smoothness = tex2DNode80.a;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=15204
345;92;1223;729;4222.202;1311.879;4.957839;False;False
Node;AmplifyShaderEditor.CommentaryNode;128;-3113.25,-277.6554;Float;False;1648.54;574.2015;;7;7;9;11;10;98;180;129;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;39;-2354.221,1634.534;Float;False;1523.056;586.484;Base + Burnt Detail Mix (1 Free Alpha channels if needed);9;103;181;182;6;5;179;82;40;183;;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;180;-3032.306,-240.7004;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;11;-3060.807,-39.78358;Float;False;Property;_BurnTilling;Burn Tilling;10;0;Create;True;0;0;False;0;1;0.179;0.1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-3061.854,59.54606;Float;False;Property;_BurnOffset;Burn Offset;8;0;Create;True;0;0;False;0;1;0.22;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;130;-2566.58,462.9727;Float;False;2529.991;765.4811;Emission;18;157;158;69;66;95;68;67;76;73;77;127;65;70;106;101;170;174;169;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;7;-2680.848,-125.3553;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2308.22,1995.127;Float;False;Property;_CharcoalNormalTile;Charcoal Normal Tile;9;0;Create;True;0;0;False;0;5;2;2;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;179;-2297.001,1722.1;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;76;-2501.525,1037.474;Float;False;Property;GlowBaseFrequency;Glow Base Frequency;11;0;Create;True;0;0;False;0;1.1;2.35;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;67;-2487.243,814.3365;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PannerNode;9;-2436.848,-67.1541;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0.5;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-2032,1872;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;40;-1862.12,1886.328;Float;False;343.3401;246.79;Emission in Alpha;1;83;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2214.131,864.2569;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;98;-2187.974,90.68339;Float;True;Property;Masks;Masks;13;0;Create;True;0;0;False;0;None;e24b2c680edaa90458d31f11544d79ca;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;83;-1837.837,1936.235;Float;True;Property;BurntTileNormals;Burnt Tile Normals;14;0;Create;True;0;0;False;0;None;e9742c575b8f4644fb9379e7347ff62e;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;95;-2048.016,1006.15;Float;False;Constant;GlowDuration;Glow Duration;-1;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;171;-2059.027,1470.798;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;169;-2503.727,1130.798;Float;False;Property;GlowOverride;Glow Override;12;0;Create;True;0;0;False;0;1;1.07;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;66;-2005.042,836.0363;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;170;-1863.427,1078.999;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;-1859.748,866.4651;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-2516.58,713.7126;Float;False;Property;GlowColorIntensity;Glow Color Intensity;7;0;Create;True;0;0;False;0;0;0.56;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;73;-2500.298,512.9727;Float;False;Property;EmberColorTint;Ember Color Tint;2;0;Create;True;0;0;False;0;0.9926471,0.6777384,0,1;0.966,0.1062519,0.004325263,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;138;-1244.786,362.2247;Float;False;Constant;R2;R2;-1;0;Create;True;0;0;False;0;4.2;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-1833.5,705.4734;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;144;-1201.686,-84.4754;Float;False;Constant;R2144;R2 144;-1;0;Create;True;0;0;False;0;2.95;0;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;174;-1695.621,992.7978;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;137;-877.9863,266.6246;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;134;-1253.789,180.1245;Float;False;Constant;ColorNode39134;ColorNode 39 134;-1;0;Create;True;0;0;False;0;0.647,0.06297875,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;145;-864.0865,-85.57518;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-1650.418,755.3741;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;147;-1134.788,-277.6757;Float;False;Constant;ColorNode39134147;ColorNode39134 147;-1;0;Create;True;0;0;False;0;0.718,0.0627451,0,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;101;-1374.632,659.5688;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;129;-2023.204,-221.9194;Float;False;471.6918;296.3271;Mix Base Albedo;2;13;19;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;136;-735.1851,46.52425;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;146;-718.0855,-186.0759;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;38;-1752.147,-1032.491;Float;False;1183.903;527.3994;Albedo - Smoothness in Alpha;5;35;27;34;28;80;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;80;-1643.756,-782.4553;Float;True;Property;Albedo;Albedo;3;0;Create;True;0;0;False;0;None;7130c16fd8005b546b111d341310a9a4;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;148;-532.6986,-105.8688;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;183;-1653.1,1805.106;Float;False;Constant;_Float0;Float 0;15;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-2012.303,-170.8193;Float;False;Property;_CharcoalMix;Charcoal Mix;1;0;Create;True;0;0;False;0;1;0.713;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-1666.103,-951.4903;Float;False;Property;_AlbedoMix;Albedo Mix;0;0;Create;True;0;0;False;0;0.5;0.356;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;106;-1147.638,615.7524;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-1277.102,-982.4909;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;150;-535.9109,125.925;Float;False;Property;BaseEmber;Base Ember;5;0;Create;True;0;0;False;0;0;0.133;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;156;-182.4112,109.8244;Float;False;Constant;RangedFloatNode156;RangedFloatNode 156;-1;0;Create;True;0;0;False;0;1;0;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-952.7081,532.5618;Float;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;182;-1500.6,1970.726;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-1279.204,-773.5922;Float;False;Constant;_RangedFloatNode27;_RangedFloatNode27;-1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;149;-348.4115,-25.67536;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-1726.307,-47.39226;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;158;-922.8376,723.2053;Float;False;Property;GlowEmissionMultiplier;Glow Emission Multiplier;6;0;Create;True;0;0;False;0;1;12.6;0;30;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;154;41.58921,-45.27597;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;177;-204.6184,257.1976;Float;False;Constant;RangedFloatNode177;RangedFloatNode 177;-1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;157;-597.8378,569.7058;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;178;30.78172,469.7978;Float;False;Constant;RangedFloatNode178;RangedFloatNode 178;-1;0;Create;True;0;0;False;0;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;82;-1360.313,1695.685;Float;True;Property;Normals;Normals;4;0;Create;True;0;0;False;0;None;11f03d9db1a617e40b7ece71f0a84f6f;True;2;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;1,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;151;-118.0104,-148.7752;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;28;-970.9127,-675.8198;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.UnpackScaleNormalNode;181;-1341.6,1914.726;Float;True;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.LerpOp;103;-1004.304,1816.428;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;152;247.1904,-253.5751;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ClampOpNode;176;257.5815,221.0976;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;521.204,-107.2724;Fixed;False;True;2;Fixed;ASEMaterialInspector;0;0;Standard;ASESampleShaders/BurnEffect;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;3;False;-1;False;0;0;False;0;Opaque;0;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;0;False;-1;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;7;0;180;0
WireConnection;7;1;11;0
WireConnection;9;0;7;0
WireConnection;9;1;10;0
WireConnection;5;0;179;0
WireConnection;5;1;6;0
WireConnection;68;0;67;2
WireConnection;68;1;76;0
WireConnection;98;1;9;0
WireConnection;83;1;5;0
WireConnection;171;0;98;1
WireConnection;171;1;83;4
WireConnection;66;0;68;0
WireConnection;170;0;169;0
WireConnection;170;1;171;0
WireConnection;69;0;66;0
WireConnection;69;1;95;0
WireConnection;65;0;73;0
WireConnection;65;1;77;0
WireConnection;174;0;69;0
WireConnection;174;1;170;0
WireConnection;137;0;83;4
WireConnection;137;1;138;0
WireConnection;145;0;83;4
WireConnection;145;1;144;0
WireConnection;70;0;65;0
WireConnection;70;1;174;0
WireConnection;101;0;70;0
WireConnection;101;1;98;2
WireConnection;136;0;134;0
WireConnection;136;1;137;0
WireConnection;146;0;147;0
WireConnection;146;1;145;0
WireConnection;80;1;180;0
WireConnection;148;0;146;0
WireConnection;148;1;136;0
WireConnection;148;2;98;2
WireConnection;106;0;101;0
WireConnection;106;1;83;4
WireConnection;34;0;80;0
WireConnection;34;1;35;0
WireConnection;127;0;98;1
WireConnection;127;1;106;0
WireConnection;182;0;183;0
WireConnection;182;1;83;2
WireConnection;182;3;83;1
WireConnection;149;0;148;0
WireConnection;149;1;98;1
WireConnection;19;0;13;0
WireConnection;19;1;98;1
WireConnection;154;0;98;1
WireConnection;154;1;156;0
WireConnection;157;0;127;0
WireConnection;157;1;158;0
WireConnection;82;1;179;0
WireConnection;151;0;149;0
WireConnection;151;1;150;0
WireConnection;28;0;34;0
WireConnection;28;1;27;0
WireConnection;28;2;19;0
WireConnection;181;0;182;0
WireConnection;103;0;82;0
WireConnection;103;1;181;0
WireConnection;103;2;19;0
WireConnection;152;0;28;0
WireConnection;152;1;151;0
WireConnection;152;2;154;0
WireConnection;176;0;157;0
WireConnection;176;1;177;0
WireConnection;176;2;178;0
WireConnection;0;0;152;0
WireConnection;0;1;103;0
WireConnection;0;2;176;0
WireConnection;0;4;80;4
ASEEND*/
//CHKSM=910736C52D413F02E8D7AA397B2C3CCAC5D43C81
