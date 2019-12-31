// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Simple/SimpleRefraction"
{
	Properties
	{
		[HideInInspector] __dirty( "", Int ) = 1
		_BrushedMetalNormal("BrushedMetalNormal", 2D) = "bump" {}
		_Distortion("Distortion", Range( 0 , 1)) = 0.292
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float4 screenPos;
			float2 uv_texcoord;
		};

		uniform sampler2D _GrabTexture;
		uniform sampler2D _BrushedMetalNormal;
		uniform float4 _BrushedMetalNormal_ST;
		uniform float _Distortion;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPos40 = ase_screenPos;
			#if UNITY_UV_STARTS_AT_TOP
			float scale40 = -1.0;
			#else
			float scale40 = 1.0;
			#endif
			float halfPosW40 = ase_screenPos40.w * 0.5;
			ase_screenPos40.y = ( ase_screenPos40.y - halfPosW40 ) * _ProjectionParams.x* scale40 + halfPosW40;
			ase_screenPos40.xyzw /= ase_screenPos40.w;
			float2 uv_BrushedMetalNormal = i.uv_texcoord * _BrushedMetalNormal_ST.xy + _BrushedMetalNormal_ST.zw;
			float4 screenColor8 = tex2D( _GrabTexture, ( (ase_screenPos40).xy + (( UnpackNormal( tex2D( _BrushedMetalNormal, uv_BrushedMetalNormal ) ) * _Distortion )).xy ) );
			o.Emission = screenColor8.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13202
487;574;979;444;889.9358;180.2048;1.699979;False;False
Node;AmplifyShaderEditor.RangedFloatNode;31;-830.9375,433.5321;Float;False;Property;_Distortion;Distortion;1;0;0.292;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;29;-855.48,221.599;Float;True;Property;_BrushedMetalNormal;BrushedMetalNormal;0;0;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GrabScreenPosition;40;-447.4607,49.29217;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-441.6739,287.2988;Float;False;2;2;0;FLOAT3;0.0,0,0;False;1;FLOAT;0.0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.ComponentMaskNode;39;-191.7806,65.19897;Float;False;True;True;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.ComponentMaskNode;36;-248.5805,285.0987;Float;False;True;True;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleAddOpNode;30;36.62508,137.2995;Float;False;2;2;0;FLOAT2;0.0,0;False;1;FLOAT2;0.0,0,0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.ScreenColorNode;8;224.0004,85.8997;Float;False;Global;_ScreenGrab0;Screen Grab 0;-1;0;Object;-1;False;1;0;FLOAT2;0,0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;536.7999,-33.8;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;ASESampleShaders/Simple/SimpleRefraction;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;3;False;0;0;Translucent;0.5;True;True;0;False;Opaque;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;OBJECT;0.0;False;11;FLOAT3;0.0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;32;0;29;0
WireConnection;32;1;31;0
WireConnection;39;0;40;0
WireConnection;36;0;32;0
WireConnection;30;0;39;0
WireConnection;30;1;36;0
WireConnection;8;0;30;0
WireConnection;0;2;8;0
ASEEND*/
//CHKSM=0B5226CEA863513E547197127E5C490AB617C827
