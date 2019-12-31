// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Post Process/FilmGrain"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Strength("Strength", Float) = 0
		[Toggle]_ToggleSwitch0("Toggle Switch0", Float) = 1
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}

	SubShader
	{
		
		
		ZTest Always
		Cull Off
		ZWrite Off


		Pass
		{ 
			CGPROGRAM 

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"


			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _ToggleSwitch0;
			uniform float _Strength;

			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				o.pos = UnityObjectToClipPos ( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv_MainTex = i.uv.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 tex2DNode2 = tex2D( _MainTex, uv_MainTex );
				float mulTime10 = _Time.y * 10.0;
				float2 uv4 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float x13 = ( mulTime10 * ( ( 4.0 + uv4.x ) * ( uv4.y + 4.0 ) ) );
				float grain31 = ( ( fmod( ( ( fmod( x13 , 13.0 ) + 1.0 ) * ( fmod( x13 , 123.0 ) + 1.0 ) ) , 0.01 ) - 0.005 ) * _Strength );
				

				finalColor = lerp(( tex2DNode2 * ( 1.0 - grain31 ) ),( grain31 + tex2DNode2 ),_ToggleSwitch0);

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14302
389;92;1064;673;1461.39;-233.5696;2.440291;False;False
Node;AmplifyShaderEditor.CommentaryNode;17;-1071,192.5;Float;False;1215;457;X;10;4;5;7;8;6;9;11;10;12;13;X;1,1,1,1;0;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1021,333.5;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-886,250.5;Float;False;Constant;_Float0;Float 0;1;0;Create;True;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-882,534.5;Float;False;Constant;_Float1;Float 1;1;0;Create;True;4;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-651,242.5;Float;False;Constant;_Float2;Float 2;1;0;Create;True;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-689,468.5;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-686,365.5;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;10;-474,286.5;Float;False;1;0;FLOAT;1.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-478,426.5;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;32;-1070.199,782.9008;Float;False;1658.099;1099.398;Grain;18;23;24;25;22;19;20;21;18;30;3;31;29;26;27;28;16;15;14;Grain;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;11;-295,359.5;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;21;-1003.9,1276.62;Float;False;13;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;13;-99,377.5;Float;False;x;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;20;-1002.399,1405.921;Float;False;Constant;_Float5;Float 5;1;0;Create;True;123;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1018.699,962.2014;Float;False;Constant;_Float3;Float 3;1;0;Create;True;13;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;15;-1020.199,832.9008;Float;False;13;0;1;FLOAT;0
Node;AmplifyShaderEditor.FmodOpNode;22;-786.9996,1344.92;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;24;-981.0984,1543.521;Float;False;Constant;_Float6;Float 6;1;0;Create;True;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FmodOpNode;14;-803.2992,901.1997;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;19;-997.398,1099.801;Float;False;Constant;_Float4;Float 4;1;0;Create;True;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-618.0983,1379.52;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;18;-618.3979,998.8009;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-486.0992,1504.701;Float;False;Constant;_Float7;Float 7;1;0;Create;True;0.01;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;25;-448.2988,1252.101;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-319.0991,1683.701;Float;False;Constant;_Float8;Float 8;1;0;Create;True;0.005;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FmodOpNode;26;-193.2992,1335.101;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;28;24.90087,1521.701;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-71.50049,1767.299;Float;False;Property;_Strength;Strength;0;0;Create;True;0;34.84;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;178.2995,1687.999;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;46;-1070.102,-394.101;Float;False;1441.289;476.5997;Final Composition;7;42;43;2;1;41;40;39;Final Composition;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;1;-1020.102,-214.4006;Float;False;_MainTex;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;40;-407.014,-133.6004;Float;False;31;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;31;344.8998,1661.997;Float;False;grain;-1;True;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-881.0005,-179.7007;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;42;-211.5128,-212.9008;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-178.1139,-50.5013;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;5.985176,-344.101;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;43;149.1871,-110.7008;Float;False;Property;_ToggleSwitch0;Toggle Switch0;1;1;[Toggle];Create;True;1;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMasterNode;0;650.6996,-265.2;Float;False;True;2;Float;ASEMaterialInspector;0;1;ASESampleShaders/Post Process/FilmGrain;c71b220b631b6344493ea3cf87110c93;ASETemplateShaders/PostProcess;Off;2;7;0;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;7;0;4;2
WireConnection;7;1;8;0
WireConnection;5;0;6;0
WireConnection;5;1;4;1
WireConnection;10;0;12;0
WireConnection;9;0;5;0
WireConnection;9;1;7;0
WireConnection;11;0;10;0
WireConnection;11;1;9;0
WireConnection;13;0;11;0
WireConnection;22;0;21;0
WireConnection;22;1;20;0
WireConnection;14;0;15;0
WireConnection;14;1;16;0
WireConnection;23;0;22;0
WireConnection;23;1;24;0
WireConnection;18;0;14;0
WireConnection;18;1;19;0
WireConnection;25;0;18;0
WireConnection;25;1;23;0
WireConnection;26;0;25;0
WireConnection;26;1;27;0
WireConnection;28;0;26;0
WireConnection;28;1;29;0
WireConnection;30;0;28;0
WireConnection;30;1;3;0
WireConnection;31;0;30;0
WireConnection;2;0;1;0
WireConnection;42;0;40;0
WireConnection;41;0;40;0
WireConnection;41;1;2;0
WireConnection;39;0;2;0
WireConnection;39;1;42;0
WireConnection;43;0;39;0
WireConnection;43;1;41;0
WireConnection;0;0;43;0
ASEEND*/
//CHKSM=F4A870683667C802F593CA260F9D5505BC3996B0
