// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "ASESampleShaders/OrientationBasedSprite"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Columns("Columns", Float) = 0
		_Rows("Rows", Float) = 0
		_AnimSpeed("Anim Speed", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.5
		#pragma surface surf Unlit alpha:fade keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 vertexToFrag37_g11;
		};

		uniform sampler2D _Texture0;
		uniform float _Rows;
		uniform float _Columns;
		uniform float _AnimSpeed;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 normalizeResult8_g11 = normalize( ( (float4( unity_ObjectToWorld[0][3],unity_ObjectToWorld[1][3],unity_ObjectToWorld[2][3],unity_ObjectToWorld[3][3] )).xyz - _WorldSpaceCameraPos ) );
			float temp_output_41_0_g11 = _Rows;
			float temp_output_28_0_g11 = ( 1.0 / temp_output_41_0_g11 );
			float2 uv_TexCoord29_g11 = v.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
			float2 temp_output_43_0_g11 = uv_TexCoord29_g11;
			float temp_output_45_0_g11 = _Columns;
			float2 appendResult36_g11 = (float2(( ( floor( ( ( atan2( normalizeResult8_g11.z , normalizeResult8_g11.x ) + UNITY_PI ) / ( 6.28318548202515 / temp_output_41_0_g11 ) ) ) * temp_output_28_0_g11 ) + ( temp_output_28_0_g11 * temp_output_43_0_g11.x ) ) , (( ( temp_output_43_0_g11.y + ( temp_output_45_0_g11 - fmod( ( 1.0 + round( ( _AnimSpeed * _Time.y ) ) ) , temp_output_45_0_g11 ) ) ) / temp_output_45_0_g11 )).x));
			o.vertexToFrag37_g11 = appendResult36_g11;
			//Calculate new billboard vertex position and normal;
			float3 upCamVec = float3( 0, 1, 0 );
			float3 forwardCamVec = -normalize ( UNITY_MATRIX_V._m20_m21_m22 );
			float3 rightCamVec = normalize( UNITY_MATRIX_V._m00_m01_m02 );
			float4x4 rotationCamMatrix = float4x4( rightCamVec, 0, upCamVec, 0, forwardCamVec, 0, 0, 0, 0, 1 );
			v.normal = normalize( mul( float4( v.normal , 0 ), rotationCamMatrix ));
			//This unfortunately must be made to take non-uniform scaling into account;
			//Transform to world coords, apply rotation and transform back to local;
			v.vertex = mul( v.vertex , unity_ObjectToWorld );
			v.vertex = mul( v.vertex , rotationCamMatrix );
			v.vertex = mul( v.vertex , unity_WorldToObject );
		}

		inline fixed4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return fixed4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			float4 temp_output_634_0 = tex2D( _Texture0, i.vertexToFrag37_g11 );
			o.Emission = (temp_output_634_0).rgb;
			o.Alpha = (temp_output_634_0).a;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14402
389;92;1064;673;-14139.54;-334.5905;1.3;True;False
Node;AmplifyShaderEditor.RangedFloatNode;626;14580.05,785.025;Float;False;Property;_Columns;Columns;1;0;Create;True;0;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;625;14597.65,701.9684;Float;False;Property;_Rows;Rows;2;0;Create;True;0;8;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;622;14557.29,493.1182;Float;True;Property;_Texture0;Texture 0;0;0;Create;True;None;f2e0c334ffe42f740b78bcb2d549b12c;False;white;Auto;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.RangedFloatNode;628;14591.22,877.1921;Float;False;Property;_AnimSpeed;Anim Speed;3;0;Create;True;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;634;14808.67,629.2892;Float;False;OrientationBasedSprite;-1;;11;1da8bc02c5f4ead4bb2f573150575751;1,46,1;6;40;SAMPLER2D;0.0;False;43;FLOAT2;0,0;False;48;FLOAT;0.0;False;41;FLOAT;1.0;False;45;FLOAT;1.0;False;42;FLOAT;1.0;False;1;COLOR;0
Node;AmplifyShaderEditor.SwizzleNode;623;15142.5,615.1694;Float;False;FLOAT3;0;1;2;3;1;0;COLOR;0.0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;624;15158.63,785.073;Float;False;FLOAT;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;542;15387.83,586.0334;Float;False;True;3;Float;ASEMaterialInspector;0;0;Unlit;ASESampleShaders/OrientationBasedSprite;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;False;2;SrcAlpha;OneMinusSrcAlpha;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;True;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;634;40;622;0
WireConnection;634;41;625;0
WireConnection;634;45;626;0
WireConnection;634;42;628;0
WireConnection;623;0;634;0
WireConnection;624;0;634;0
WireConnection;542;2;623;0
WireConnection;542;9;624;0
ASEEND*/
//CHKSM=A551A09B886D77579E9BD53D127E8AD2B5591790
