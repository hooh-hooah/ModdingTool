// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/Sprites/UISpriteFX 3"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		[Header(UI Sprite Effect Layer)]
		_Fire("Fire", 2D) = "black" {}
		[NoScaleOffset][Normal]_DistortionNormalMap("Distortion Normal Map", 2D) = "bump" {}
		_DistortAmount("Distort Amount", Range( 0 , 1)) = 0
		[NoScaleOffset]_Texture0("Texture 0", 2D) = "white" {}
		[NoScaleOffset]_Flow("Flow", 2D) = "white" {}
		[NoScaleOffset]_EnergyFlow("Energy Flow", 2D) = "white" {}
		[NoScaleOffset]_FlowDirection("Flow Direction", 2D) = "white" {}
		[NoScaleOffset]_Rotation("Rotation", 2D) = "black" {}
		[NoScaleOffset]_RotationMask("Rotation Mask", 2D) = "black" {}
		_RotationPosScale("Rotation Pos Scale", Vector) = (0,0,1,1)
		[NoScaleOffset]_BlendFireMask("Blend Fire Mask", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#include "UnityStandardUtils.cginc"


			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform sampler2D _Flow;
			uniform sampler2D _FlowDirection;
			uniform float4 _FlowDirection_ST;
			uniform float4 _MainTex_ST;
			uniform sampler2D _Fire;
			uniform sampler2D _DistortionNormalMap;
			uniform float4 _Fire_ST;
			uniform float _DistortAmount;
			uniform sampler2D _BlendFireMask;
			uniform sampler2D _Texture0;
			uniform sampler2D _EnergyFlow;
			uniform float4 _EnergyFlow_ST;
			uniform sampler2D _Rotation;
			uniform float4 _RotationPosScale;
			uniform sampler2D _RotationMask;
			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
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
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				float2 uv_FlowDirection = IN.texcoord.xy * _FlowDirection_ST.xy + _FlowDirection_ST.zw;
				float4 tex2DNode14_g583 = tex2D( _FlowDirection, uv_FlowDirection );
				float2 appendResult20_g583 = (float2(tex2DNode14_g583.r , tex2DNode14_g583.g));
				float TimeVar197_g583 = _SinTime.w;
				float2 temp_cast_0 = (TimeVar197_g583).xx;
				float2 temp_output_18_0_g583 = ( appendResult20_g583 - temp_cast_0 );
				float4 tex2DNode72_g583 = tex2D( _Flow, temp_output_18_0_g583 );
				float4 _FlowTint = float4(0,0.213793,1,1);
				float2 uv_MainTex = IN.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float4 temp_output_192_0_g582 = ( tex2D( _MainTex, uv_MainTex ) * _Color );
				float2 uv_Fire = IN.texcoord.xy * _Fire_ST.xy + _Fire_ST.zw;
				float2 MainUvs222_g582 = uv_Fire;
				float4 tex2DNode65_g582 = tex2D( _DistortionNormalMap, MainUvs222_g582 );
				float4 appendResult82_g582 = (float4(0.0 , tex2DNode65_g582.g , 0.0 , tex2DNode65_g582.r));
				float2 temp_output_84_0_g582 = (UnpackScaleNormal( appendResult82_g582 ,_DistortAmount )).xy;
				float2 panner179_g582 = ( MainUvs222_g582 + 1.0 * _Time.y * float2( 0,-0.1 ));
				float2 temp_output_71_0_g582 = ( temp_output_84_0_g582 + panner179_g582 );
				float4 tex2DNode96_g582 = tex2D( _Fire, temp_output_71_0_g582 );
				float2 uv_BlendFireMask232_g582 = IN.texcoord.xy;
				float4 temp_output_192_0_g583 = ( temp_output_192_0_g582 + ( ( tex2DNode96_g582 * tex2DNode96_g582.a * tex2D( _BlendFireMask, uv_BlendFireMask232_g582 ).g ) * (temp_output_192_0_g582).a ) );
				float4 temp_output_192_0_g585 = ( ( ( tex2DNode72_g583 * tex2DNode14_g583.a ) * _FlowTint ) + temp_output_192_0_g583 );
				float2 uv_EnergyFlow = IN.texcoord.xy * _EnergyFlow_ST.xy + _EnergyFlow_ST.zw;
				float4 tex2DNode14_g585 = tex2D( _EnergyFlow, uv_EnergyFlow );
				float2 appendResult20_g585 = (float2(tex2DNode14_g585.r , tex2DNode14_g585.g));
				float2 appendResult753 = (float2(_SinTime.y , _SinTime.x));
				float2 temp_output_18_0_g585 = ( appendResult20_g585 - appendResult753 );
				float4 tex2DNode72_g585 = tex2D( _Texture0, temp_output_18_0_g585 );
				float4 temp_output_192_0_g584 = ( temp_output_192_0_g585 + ( ( ( tex2DNode72_g585 * tex2DNode14_g585.a ) * _FlowTint ) * (temp_output_192_0_g585).a ) );
				float4 temp_output_57_0_g584 = _RotationPosScale;
				float2 temp_output_2_0_g584 = (temp_output_57_0_g584).zw;
				float2 temp_cast_1 = (1.0).xx;
				float2 temp_output_13_0_g584 = ( ( ( IN.texcoord.xy + (temp_output_57_0_g584).xy ) * temp_output_2_0_g584 ) + -( ( temp_output_2_0_g584 - temp_cast_1 ) * 0.5 ) );
				float TimeVar197_g584 = _Time.y;
				float cos17_g584 = cos( TimeVar197_g584 );
				float sin17_g584 = sin( TimeVar197_g584 );
				float2 rotator17_g584 = mul( temp_output_13_0_g584 - float2( 0.5,0.5 ) , float2x2( cos17_g584 , -sin17_g584 , sin17_g584 , cos17_g584 )) + float2( 0.5,0.5 );
				float4 tex2DNode97_g584 = tex2D( _Rotation, rotator17_g584 );
				float2 temp_cast_2 = (1.0).xx;
				float temp_output_115_0_g584 = step( ( (temp_output_13_0_g584).y + -0.5 ) , 0.0 );
				float lerpResult125_g584 = lerp( 1.0 , tex2D( _RotationMask, IN.texcoord.xy ).g , ( 1.0 - temp_output_115_0_g584 ));
				
				fixed4 c = ( temp_output_192_0_g584 + ( ( ( tex2DNode97_g584 * lerpResult125_g584 * tex2DNode97_g584.a ) * float4(0,0.3379312,1,1) ) * (temp_output_192_0_g584).a ) );
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14301
487;594;979;424;8846.694;3040.367;10.10963;True;False
Node;AmplifyShaderEditor.CommentaryNode;534;-6118.536,-986.7712;Float;False;849.0742;480.2428;Comment;4;529;476;528;477;Base Sprite;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;477;-6091.057,-930.9922;Float;True;_MainTex;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;476;-5723.057,-706.9918;Float;False;_Color;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;528;-5835.057,-930.9922;Float;True;Property;_TextureSample4;Texture Sample 4;26;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;109;-4869.938,-992;Float;False;1023.074;537.6009;Comment;5;509;68;69;554;725;Layer 1 - Fire Distortion;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;773;-2208,-976;Float;False;1125.491;577.4147;Comment;6;753;741;731;774;770;730;Layer 3 - Energy Field;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;529;-5466.464,-931.1265;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;725;-4255.756,-674.6586;Float;True;Property;_BlendFireMask;Blend Fire Mask;17;1;[NoScaleOffset];Create;True;None;596678c53fd54a640bf95ba7dfafd092;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;509;-4805.938,-864;Float;True;Property;_Fire;Fire;7;0;Create;True;None;36be8d528a4fa024faa4680d7658642c;False;black;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;68;-4805.938,-672;Float;True;Property;_DistortionNormalMap;Distortion Normal Map;8;2;[NoScaleOffset];[Normal];Create;True;None;dd2fd2df93418444c8e280f1d34deeb5;True;bump;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;110;-3593.306,-984.7995;Float;False;1151.387;530.2474;Comment;5;74;72;73;768;775;Layer 2 - Flow;1,1,1,1;0;0
Node;AmplifyShaderEditor.Vector2Node;554;-4565.938,-800;Float;False;Constant;_Vector0;Vector 0;27;0;Create;True;0,-0.1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;69;-4581.938,-592;Float;False;Property;_DistortAmount;Distort Amount;9;0;Create;True;0;0.15;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;73;-3552,-672;Float;True;Property;_FlowDirection;Flow Direction;13;1;[NoScaleOffset];Create;True;None;7b0842e3d0da6bf468f08b4a0ad9db9b;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TexturePropertyNode;72;-3552,-864;Float;True;Property;_Flow;Flow;11;1;[NoScaleOffset];Create;True;None;131633c45b26caa4f9673a16077a1970;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.SinTimeNode;775;-3212.686,-646.0574;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;74;-2992,-688;Float;False;Constant;_FlowTint;Flow Tint;11;0;Create;True;0,0.213793,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinTimeNode;741;-1856,-608;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;767;-4149.94,-928;Float;False;UI-Sprite Effect Layer;0;;582;789bf62641c5cfe4ab7126850acc22b8;17,74,0,191,0,225,0,242,0,237,0,249,0,186,0,177,1,182,0,229,1,92,1,98,1,234,0,126,0,129,0,130,0,31,2;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1.0;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0.0;False;231;FLOAT;1.0;False;30;FLOAT;1.0;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.WireNode;774;-1872,-704;Float;False;1;0;COLOR;0.0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexturePropertyNode;731;-2160,-624;Float;True;Property;_EnergyFlow;Energy Flow;12;1;[NoScaleOffset];Create;True;None;b9f1c2125557bf34c98df0614dff4483;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;768;-2784,-928;Float;False;UI-Sprite Effect Layer;0;;583;789bf62641c5cfe4ab7126850acc22b8;17,74,1,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,1,234,0,126,0,129,0,130,0,31,1;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1.0;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0.0;False;231;FLOAT;1.0;False;30;FLOAT;1.0;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TexturePropertyNode;730;-2160,-864;Float;True;Property;_Texture0;Texture 0;10;1;[NoScaleOffset];Create;True;None;9fbef4b79ca3b784ba023cb1331520d5;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;105;-736,-992;Float;False;1106.464;555.6915;Comment;5;59;60;56;81;769;Layer 4 - Rotation Effect;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;753;-1680,-608;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;56;-672,-672;Float;True;Property;_Rotation;Rotation;14;1;[NoScaleOffset];Create;True;None;ce384aed77a765144bdb41c367961753;False;black;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.ColorNode;81;-672,-848;Float;False;Constant;_RotationTint;Rotation Tint;11;0;Create;True;0,0.3379312,1,1;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;59;-192,-672;Float;False;Property;_RotationPosScale;Rotation Pos Scale;16;0;Create;True;0,0,1,1;0,0,0.92,3.52;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;770;-1392,-928;Float;False;UI-Sprite Effect Layer;0;;585;789bf62641c5cfe4ab7126850acc22b8;17,74,1,191,1,225,0,242,0,237,0,249,1,186,0,177,0,182,0,229,0,92,1,98,1,234,0,126,0,129,0,130,0,31,2;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1.0;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0.0;False;231;FLOAT;1.0;False;30;FLOAT;1.0;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TexturePropertyNode;60;-432,-672;Float;True;Property;_RotationMask;Rotation Mask;15;1;[NoScaleOffset];Create;True;None;596678c53fd54a640bf95ba7dfafd092;False;black;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.FunctionNode;769;96,-928;Float;False;UI-Sprite Effect Layer;0;;584;789bf62641c5cfe4ab7126850acc22b8;17,74,2,191,1,225,0,242,0,237,0,249,0,186,0,177,0,182,0,229,0,92,1,98,1,234,0,126,0,129,1,130,1,31,2;18;192;COLOR;1,1,1,1;False;39;COLOR;1,1,1,1;False;37;SAMPLER2D;;False;218;FLOAT2;0,0;False;239;FLOAT2;0,0;False;181;FLOAT2;0,0;False;75;SAMPLER2D;;False;80;FLOAT;1.0;False;183;FLOAT2;0,0;False;188;SAMPLER2D;;False;33;SAMPLER2D;;False;248;FLOAT2;0,0;False;233;SAMPLER2D;;False;101;SAMPLER2D;;False;57;FLOAT4;0,0,0,0;False;40;FLOAT;0.0;False;231;FLOAT;1.0;False;30;FLOAT;1.0;False;2;COLOR;0;FLOAT2;172
Node;AmplifyShaderEditor.TemplateMasterNode;728;720,-928;Float;False;True;2;Float;ASEMaterialInspector;0;4;ASESampleShaders/Sprites/UISpriteFX 3;0f8ba0101102bb14ebf021ddadce9b49;Sprites Default;3;One;OneMinusSrcAlpha;0;One;Zero;Off;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;528;0;477;0
WireConnection;529;0;528;0
WireConnection;529;1;476;0
WireConnection;767;192;529;0
WireConnection;767;37;509;0
WireConnection;767;181;554;0
WireConnection;767;75;68;0
WireConnection;767;80;69;0
WireConnection;767;233;725;0
WireConnection;774;0;74;0
WireConnection;768;192;767;0
WireConnection;768;39;74;0
WireConnection;768;37;72;0
WireConnection;768;33;73;0
WireConnection;768;40;775;4
WireConnection;753;0;741;2
WireConnection;753;1;741;1
WireConnection;770;192;768;0
WireConnection;770;39;774;0
WireConnection;770;37;730;0
WireConnection;770;33;731;0
WireConnection;770;248;753;0
WireConnection;769;192;770;0
WireConnection;769;39;81;0
WireConnection;769;37;56;0
WireConnection;769;101;60;0
WireConnection;769;57;59;0
WireConnection;728;0;769;0
ASEEND*/
//CHKSM=0F879B3ED753AE1EF8F06CC82715D8A747911E59
