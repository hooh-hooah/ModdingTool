// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/TwoSideWithFace"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_MaskClipValue( "Mask Clip Value", Float ) = 0.5
		_Mask("Mask", 2D) = "white" {}
		_FrontAlbedo("FrontAlbedo", 2D) = "white" {}
		_FrontNormalMap("FrontNormalMap", 2D) = "bump" {}
		_FrontColor("FrontColor", Color) = (1,0.6691177,0.6691177,0)
		_BackAlbedo("BackAlbedo", 2D) = "white" {}
		_BackNormalMap("BackNormalMap", 2D) = "bump" {}
		_BackColor("BackColor", Color) = (0,0,1,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "AlphaTest+0" }
		Cull Off
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 texcoord_0;
			fixed ASEVFace : VFACE;
			float2 uv_texcoord;
		};

		uniform sampler2D _FrontNormalMap;
		uniform sampler2D _BackNormalMap;
		uniform sampler2D _FrontAlbedo;
		uniform float4 _FrontColor;
		uniform sampler2D _BackAlbedo;
		uniform float4 _BackColor;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float _MaskClipValue = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			o.texcoord_0.xy = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 switchResult3 = (((i.ASEVFace>0)?(UnpackNormal( tex2D( _FrontNormalMap,i.texcoord_0) )):(UnpackNormal( tex2D( _BackNormalMap,i.texcoord_0) ))));
			o.Normal = switchResult3;
			float4 switchResult2 = (((i.ASEVFace>0)?(( tex2D( _FrontAlbedo,i.texcoord_0) * _FrontColor )):(( tex2D( _BackAlbedo,i.texcoord_0) * _BackColor ))));
			o.Albedo = switchResult2.rgb;
			o.Alpha = 1;
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			clip( tex2D( _Mask,uv_Mask).a - _MaskClipValue );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=7003
293;121;953;624;1981.486;934.496;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;12;-1271.091,-592;Float;False;1252.009;1229.961;Inspired by 2Side Sample by The Four Headed Cat;12;14;4;5;8;7;10;11;6;9;3;1;2;Two Sided Shader using Switch by Face
Node;AmplifyShaderEditor.TextureCoordinatesNode;14;-1222.402,60.79997;Float;False;0;-1;2;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;FLOAT2;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;8;-865,-160;Float;True;Property;_BackAlbedo;BackAlbedo;4;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Rock/rock_d.tif;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-865,-528;Float;True;Property;_FrontAlbedo;FrontAlbedo;1;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Grass/Grass_A.jpg;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;7;-785,32;Float;False;Property;_BackColor;BackColor;6;0;0,0,1,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;5;-785,-336;Float;False;Property;_FrontColor;FrontColor;3;0;1,0.6691177,0.6691177,0;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-523.1008,-105.9;Float;False;0;FLOAT4;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SamplerNode;11;-809,408;Float;True;Property;_BackNormalMap;BackNormalMap;5;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Rock/rock_n.jpg;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;10;-825,210;Float;True;Property;_FrontNormalMap;FrontNormalMap;2;0;Assets/AmplifyShaderEditor/Examples/Assets/Textures/Grass/Grass_N.jpg;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-518.001,-241.8997;Float;False;0;FLOAT4;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.SwitchByFaceNode;3;-369,208;Float;False;0;FLOAT3;0.0,0,0;False;1;FLOAT3;0.0;False;FLOAT3
Node;AmplifyShaderEditor.SamplerNode;1;-353,336;Float;True;Property;_Mask;Mask;0;0;Assets/AmplifyShaderEditor/Examples/Community/2Sided/2smask.png;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SwitchByFaceNode;2;-257,-176;Float;False;0;COLOR;0.0;False;1;COLOR;0,0,0,0;False;COLOR
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;56.8,7.000003;Float;False;True;2;Float;ASEMaterialInspector;0;Standard;ASESampleShaders/TwoSideWithFace;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;0;False;0;0;Masked;0.5;True;True;0;False;TransparentCutout;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;Relative;0;;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;13;OBJECT;0.0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False
WireConnection;8;1;14;0
WireConnection;4;1;14;0
WireConnection;9;0;8;0
WireConnection;9;1;7;0
WireConnection;11;1;14;0
WireConnection;10;1;14;0
WireConnection;6;0;4;0
WireConnection;6;1;5;0
WireConnection;3;0;10;0
WireConnection;3;1;11;0
WireConnection;2;0;6;0
WireConnection;2;1;9;0
WireConnection;0;0;2;0
WireConnection;0;1;3;0
WireConnection;0;10;1;4
ASEEND*/
//CHKSM=06C08893D1EB311BDF9A3DAC56E6F187224BB806
