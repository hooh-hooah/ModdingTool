// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Mosaic Effect PPS"
{
	Properties
	{
		_TileSize("TileSize", Float) = 10
		_RadiusTweak("RadiusTweak", Float) = 0.9
		_InBetweenColor("InBetweenColor", Color) = (0,0,0,0)
	}

	SubShader
	{
		Cull Off
		ZWrite Off
		ZTest Always
		
		Pass
		{
			CGPROGRAM

			#pragma vertex Vert
			#pragma fragment Frag
			#pragma target 3.0

			#include "UnityCG.cginc"
			
		
			struct ASEAttributesDefault
			{
				float3 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				
			};

			struct ASEVaryingsDefault
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
				float2 texcoordStereo : TEXCOORD1;
			#if STEREO_INSTANCING_ENABLED
				uint stereoTargetEyeIndex : SV_RenderTargetArrayIndex;
			#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _TileSize;
			uniform float _RadiusTweak;
			uniform float4 _InBetweenColor;

			
			float2 TransformTriangleVertexToUV (float2 vertex)
			{
				float2 uv = (vertex + 1.0) * 0.5;
				return uv;
			}

			ASEVaryingsDefault Vert( ASEAttributesDefault v  )
			{
				ASEVaryingsDefault o;
				o.vertex = float4(v.vertex.xy, 0.0, 1.0);
				o.texcoord = TransformTriangleVertexToUV (v.vertex.xy);
#if UNITY_UV_STARTS_AT_TOP
				o.texcoord = o.texcoord * float2(1.0, -1.0) + float2(0.0, 1.0);
#endif
				o.texcoordStereo = TransformStereoScreenSpaceTex (o.texcoord, 1.0);

				v.texcoord = o.texcoordStereo;
				float4 ase_ppsScreenPosVertexNorm = float4(o.texcoordStereo,0,1);

				

				return o;
			}

			float4 Frag (ASEVaryingsDefault i  ) : SV_Target
			{
				float4 ase_ppsScreenPosFragNorm = float4(i.texcoordStereo,0,1);

				float2 FragmentPos56 = ( (_MainTex_TexelSize).zw * (ase_ppsScreenPosFragNorm).xy );
				float2 TilePos23 = ( floor( ( FragmentPos56 / _TileSize ) ) * _TileSize );
				float2 TileCenter32 = ( TilePos23 + ( _TileSize * 0.5 ) );
				float dist41 = length( ( TileCenter32 - FragmentPos56 ) );
				float Radius5 = ( 0.5 * _RadiusTweak * _TileSize );
				float2 TileUV25 = ( TileCenter32 * (_MainTex_TexelSize).xy );
				float4 tex2DNode10 = tex2D( _MainTex, TileUV25 );
				float4 ifLocalVar43 = 0;
				if( dist41 <= Radius5 )
				ifLocalVar43 = tex2DNode10;
				else
				ifLocalVar43 = _InBetweenColor;
				

				float4 color = ifLocalVar43;
				
				return color;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16706
357;73;921;645;1325.251;-443.1705;1.685138;False;False
Node;AmplifyShaderEditor.CommentaryNode;54;-1087.833,619.2771;Float;False;950.7971;413.5452;;6;65;66;56;51;53;52;Render Texture Pos;1,1,1,1;0;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;52;-1038.833,655.2767;Float;False;0;0;_MainTex_TexelSize;Pass;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateLocalVarsNode;65;-1048.173,855.8804;Float;False;0;0;ase_ppsScreenPosFragNorm;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;53;-769.2322,703.3762;Float;False;FLOAT2;2;3;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;66;-734.3396,867.5479;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;51;-548.3098,787.9337;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-364.3307,767.7734;Float;False;FragmentPos;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;21;-1083.5,1186.304;Float;False;892.3016;309.8983;;5;15;23;16;14;57;TilePos;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;1;-1609.505,1528.505;Float;False;Property;_TileSize;TileSize;0;0;Create;True;0;0;False;0;10;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;57;-1054.702,1250.802;Float;False;56;FragmentPos;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;15;-822.2004,1318.003;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FloorOpNode;14;-642.3983,1262.8;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;34;-1114.293,1604.201;Float;False;935.8;371.1958;Comment;5;31;30;28;32;62;TileCenter;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-533.2963,1383.305;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;28;-1013.493,1860.399;Float;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;23;-422.5938,1253.902;Float;False;TilePos;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;31;-1020.891,1659.201;Float;False;23;TilePos;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;62;-829.8955,1769.295;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;22;-1118.101,2802.498;Float;False;984.5472;358.8164;;5;25;61;24;19;18;TileUV;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-589.6921,1749.599;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;18;-1062.101,2972.099;Float;False;0;0;_MainTex_TexelSize;Pass;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;40;-1119.996,2034.6;Float;False;875.4005;286.4006;;5;41;35;36;58;37;Dist;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;32;-421.4933,1718.202;Float;False;TileCenter;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;58;-1084.6,2216.999;Float;False;56;FragmentPos;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SwizzleNode;19;-811.5981,2977.897;Float;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;37;-1100.996,2094.6;Float;False;32;TileCenter;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;24;-1070.496,2859.599;Float;False;32;TileCenter;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;33;-1105.602,2427.499;Float;False;732.6016;286.6998;;4;4;2;3;5;Radius;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1038.502,2494.4;Float;False;Constant;_Float0;Float 0;2;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;61;-629.6017,2869.992;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;36;-840.4964,2131.4;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;2;-1055.602,2577.499;Float;False;Property;_RadiusTweak;RadiusTweak;1;0;Create;True;0;0;False;0;0.9;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;63;-1131.414,3256.063;Float;False;996.2981;603.1008;;8;43;45;46;60;47;11;10;64;Fetch Render Texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;25;-448.6937,2956.698;Float;False;TileUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;3;-790.4005,2524.299;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;35;-640.0961,2136.2;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;5;-616.0007,2599.199;Float;False;Radius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;11;-1102.313,3629.967;Float;False;0;0;_MainTex;Pass;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;41;-481.8944,2177.598;Float;False;dist;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;47;-1112.114,3760.465;Float;False;25;TileUV;1;0;OBJECT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;46;-773.212,3407.163;Float;False;5;Radius;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;45;-774.4122,3335.363;Float;False;41;dist;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;60;-827.7154,3491.362;Float;False;Property;_InBetweenColor;InBetweenColor;2;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;10;-900.6134,3658.766;Float;True;Property;_TextureSample0;Texture Sample 0;3;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ConditionalIfNode;43;-516.9115,3434.26;Float;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;64;-323.8992,3510;Float;False;True;2;Float;ASEMaterialInspector;0;10;Mosaic Effect PPS;32139be9c1eb75640a847f011acf3bcf;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;False;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;53;0;52;0
WireConnection;66;0;65;0
WireConnection;51;0;53;0
WireConnection;51;1;66;0
WireConnection;56;0;51;0
WireConnection;15;0;57;0
WireConnection;15;1;1;0
WireConnection;14;0;15;0
WireConnection;16;0;14;0
WireConnection;16;1;1;0
WireConnection;23;0;16;0
WireConnection;62;0;1;0
WireConnection;62;1;28;0
WireConnection;30;0;31;0
WireConnection;30;1;62;0
WireConnection;32;0;30;0
WireConnection;19;0;18;0
WireConnection;61;0;24;0
WireConnection;61;1;19;0
WireConnection;36;0;37;0
WireConnection;36;1;58;0
WireConnection;25;0;61;0
WireConnection;3;0;4;0
WireConnection;3;1;2;0
WireConnection;3;2;1;0
WireConnection;35;0;36;0
WireConnection;5;0;3;0
WireConnection;41;0;35;0
WireConnection;10;0;11;0
WireConnection;10;1;47;0
WireConnection;43;0;45;0
WireConnection;43;1;46;0
WireConnection;43;2;60;0
WireConnection;43;3;10;0
WireConnection;43;4;10;0
WireConnection;64;0;43;0
ASEEND*/
//CHKSM=06FB6BB0F64FF8B43A7B6E53FF9E0179A0ECD714