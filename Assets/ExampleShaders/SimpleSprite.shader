// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Sprites/SimpleSprite"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		_Color ("Tint", Color) = (1,1,1,1)
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
	}

	SubShader
	{
		Tags
		{ 
			"Queue"="Transparent" 
			"IgnoreProjector"="True" 
			"RenderType"="Transparent" 
			"PreviewType"="Plane"
			"CanUseSpriteAtlas"="True"
			
		}

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		

		
		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 2.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			
			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
			};
			
			uniform fixed4 _Color;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform sampler2D _TextureSample2;
			uniform float4 _TextureSample2_ST;
			uniform float4 _MainTex_ST;
			uniform float4 _AlphaTex_ST;
			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				
				OUT.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				color.a = tex2D (_AlphaTex, uv).r;
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				float2 uv_TextureSample2 = IN.texcoord.xy*_TextureSample2_ST.xy + _TextureSample2_ST.zw;
				float2 uv_MainTex = IN.texcoord.xy*_MainTex_ST.xy + _MainTex_ST.zw;
				float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
				float2 uv_AlphaTex = IN.texcoord.xy*_AlphaTex_ST.xy + _AlphaTex_ST.zw;
				#ifdef ETC1_EXTERNAL_ALPHA
				float simpleKeywordVar9 = tex2D( _AlphaTex, uv_AlphaTex ).a;
				#else
				float simpleKeywordVar9 = tex2DNode2.a;
				#endif
				float4 appendResult6 = (float4((( tex2D( _TextureSample2, uv_TextureSample2 ) * tex2DNode2 )).xyz , simpleKeywordVar9));
				fixed4 c = ( IN.color * appendResult6 );
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
}
/*ASEBEGIN
Version=13001
488;92;947;650;346.7066;453.8015;1;True;False
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-979.2017,-164.8999;Float;False;_MainTex;0;1;SAMPLER2D
Node;AmplifyShaderEditor.SamplerNode;2;-734.8011,-169.7001;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;3;-874.6004,109.6998;Float;False;_AlphaTex;0;1;SAMPLER2D
Node;AmplifyShaderEditor.SamplerNode;14;-856.1957,-443.0991;Float;True;Property;_TextureSample2;Texture Sample 2;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;4;-668.6,79.69983;Float;True;Property;_TextureSample1;Texture Sample 1;0;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-410.1957,-362.0991;Float;False;2;2;0;FLOAT4;0.0,0,0,0;False;1;FLOAT4;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SwizzleNode;5;-211.1996,-220.9001;Float;False;FLOAT3;0;1;2;3;1;0;FLOAT4;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.KeywordSwitchNode;9;-312.6,88.69981;Float;False;ETC1_EXTERNAL_ALPHA;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;12;-64.59998,-426.3002;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;6;-62.59998,-200.3002;Float;False;FLOAT4;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;142.4,-283.3002;Float;False;2;2;0;COLOR;0.0,0,0,0;False;1;FLOAT4;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.TemplateMasterNode;0;307,-148;Float;False;True;2;Float;ASEMaterialInspector;0;4;ASESampleShaders/Sprites/SimpleSprite;0f8ba0101102bb14ebf021ddadce9b49;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;2;0;1;0
WireConnection;4;0;3;0
WireConnection;16;0;14;0
WireConnection;16;1;2;0
WireConnection;5;0;16;0
WireConnection;9;0;4;4
WireConnection;9;1;2;4
WireConnection;6;0;5;0
WireConnection;6;1;9;0
WireConnection;13;0;12;0
WireConnection;13;1;6;0
WireConnection;0;0;13;0
ASEEND*/
//CHKSM=C9F12EBD4D58223ED5AE5D5DFFA0182CEC714060
