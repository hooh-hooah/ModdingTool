// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Simple/SimpleBlurOFF"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MainSample("MainSample", 2D) = "white" {}
		[Toggle]_ToggleBlur("Toggle Blur", Range( 0 , 1)) = 0
		_BlurSize("Blur Size", Range( 0 , 0.05)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZTest LEqual
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _MainSample;
		uniform float4 _MainSample_ST;
		uniform float _BlurSize;
		uniform float _ToggleBlur;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainSample = i.uv_texcoord * _MainSample_ST.xy + _MainSample_ST.zw;
			float2 appendResult39 = (float2(0.0 , _BlurSize));
			float2 appendResult40 = (float2(_BlurSize , 0.0));
			float2 appendResult42 = (float2(_BlurSize , _BlurSize));
			float4 lerpResult31 = lerp( tex2D( _MainSample, uv_MainSample ) , ( ( ( ( tex2D( _MainSample, uv_MainSample ) * 0.4 ) + ( tex2D( _MainSample, ( uv_MainSample + appendResult39 ) ) * 0.2 ) ) + ( tex2D( _MainSample, ( uv_MainSample + appendResult40 ) ) * 0.2 ) ) + ( tex2D( _MainSample, ( uv_MainSample + appendResult42 ) ) * 0.2 ) ) , step( 0.5 , _ToggleBlur ));
			o.Emission = lerpResult31.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13112
302;92;1065;805;2125.111;204.0678;1;True;False
Node;AmplifyShaderEditor.RangedFloatNode;37;-1723.636,152.964;Float;False;Property;_BlurSize;Blur Size;2;0;0;0;0.05;0;1;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-1456.701,-428.3001;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0.01;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;39;-1333.334,-212.6361;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;38;-1152.334,-315.6361;Float;False;2;2;0;FLOAT2;0.0;False;1;FLOAT2;0.0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.TextureCoordinatesNode;9;-1187.613,-668.9401;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;40;-1301.334,224.3639;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.TextureCoordinatesNode;11;-1274.1,-41.00002;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.01,0;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;6;-947.9997,-324.3;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;None;True;0;False;white;Auto;False;Instance;5;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;42;-1351.135,575.364;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-1046.334,146.3639;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;29;-904.9965,-660.8977;Float;True;Property;_TextureSample3;Texture Sample 3;0;0;None;True;0;False;white;Auto;False;Instance;5;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;25;-690.4989,-456.8986;Float;False;Constant;_Float0;Float 0;-1;0;0.4;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;26;-657.999,-112.3987;Float;False;Constant;_Float1;Float 1;-1;0;0.2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.TextureCoordinatesNode;12;-1354.302,343.9003;Float;False;0;5;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.01,0.01;False;5;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-521.4998,-241.0996;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;43;-1121.135,517.7645;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;7;-898.8001,53.70006;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;None;True;0;False;white;Auto;False;Instance;5;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;21;-515.0012,-569.9993;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;27;-682.6975,319.201;Float;False;Constant;_Float2;Float 2;-1;0;0.2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;28;-618.9985,632.5013;Float;False;Constant;_Float3;Float 3;-1;0;0.2;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-525.3992,219.1006;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;8;-940.7994,448.3;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;None;True;0;False;white;Auto;False;Instance;5;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-346.0005,-372.3999;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;32;-13.60084,205.202;Float;False;Property;_ToggleBlur;Toggle Blur;1;1;[Toggle];0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-509.7991,483.0006;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-274.2003,-49.30003;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SamplerNode;5;-1185.401,-944.6984;Float;True;Property;_MainSample;MainSample;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StepOpNode;35;367.199,74.30202;Float;False;2;0;FLOAT;0.5;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-110,104.6;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.LerpOp;31;513.3992,-325.1979;Float;False;3;0;COLOR;0.0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;748.0002,-409.6999;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Simple/SimpleBlurOFF;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0.0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;39;1;37;0
WireConnection;38;0;10;0
WireConnection;38;1;39;0
WireConnection;40;0;37;0
WireConnection;6;1;38;0
WireConnection;42;0;37;0
WireConnection;42;1;37;0
WireConnection;41;0;11;0
WireConnection;41;1;40;0
WireConnection;29;1;9;0
WireConnection;22;0;6;0
WireConnection;22;1;26;0
WireConnection;43;0;12;0
WireConnection;43;1;42;0
WireConnection;7;1;41;0
WireConnection;21;0;29;0
WireConnection;21;1;25;0
WireConnection;23;0;7;0
WireConnection;23;1;27;0
WireConnection;8;1;43;0
WireConnection;13;0;21;0
WireConnection;13;1;22;0
WireConnection;24;0;8;0
WireConnection;24;1;28;0
WireConnection;14;0;13;0
WireConnection;14;1;23;0
WireConnection;35;1;32;0
WireConnection;15;0;14;0
WireConnection;15;1;24;0
WireConnection;31;0;5;0
WireConnection;31;1;15;0
WireConnection;31;2;35;0
WireConnection;0;2;31;0
ASEEND*/
//CHKSM=4AAC9CA87B070F700403451C9B0DE57D7F801BB3
