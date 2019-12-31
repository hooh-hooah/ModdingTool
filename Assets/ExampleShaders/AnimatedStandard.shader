// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AnimatedStandard"
{
	Properties
	{
		_LightAtlas("LightAtlas", 2D) = "white" {}
		_Speed("Speed", Float) = 4
		_TextureRows("TextureRows", Int) = 4
		_TextureColumns("TextureColumns", Int) = 1
		_DiffuseColor("DiffuseColor", Color) = (1,1,1,0)
		_EmissionColor("EmissionColor", Color) = (1,1,1,0)
		[Normal]_NormalMap("NormalMap", 2D) = "bump" {}
		_Metalic("Metalic", Range( 0 , 1)) = 0.1007121
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.1007121
		_Occlusion("Occlusion", 2D) = "black" {}
		_Diffuse("Diffuse", 2D) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _Diffuse;
		uniform float4 _Diffuse_ST;
		uniform float4 _DiffuseColor;
		uniform sampler2D _LightAtlas;
		uniform int _TextureColumns;
		uniform int _TextureRows;
		uniform float _Speed;
		uniform float4 _EmissionColor;
		uniform float _Metalic;
		uniform float _Smoothness;
		uniform sampler2D _Occlusion;
		uniform float4 _Occlusion_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			o.Albedo = ( tex2D( _Diffuse, uv_Diffuse ) * _DiffuseColor ).rgb;
			// *** BEGIN Flipbook UV Animation vars ***
			// Total tiles of Flipbook Texture
			float fbtotaltiles3 = (float)_TextureColumns * (float)_TextureRows;
			// Offsets for cols and rows of Flipbook Texture
			float fbcolsoffset3 = 1.0f / (float)_TextureColumns;
			float fbrowsoffset3 = 1.0f / (float)_TextureRows;
			// Speed of animation
			float fbspeed3 = _Time.w * _Speed;
			// UV Tiling (col and row offset)
			float2 fbtiling3 = float2(fbcolsoffset3, fbrowsoffset3);
			// UV Offset - calculate current tile linear index, and convert it to (X * coloffset, Y * rowoffset)
			// Calculate current tile linear index
			float fbcurrenttileindex3 = round( fmod( fbspeed3 + 0.0, fbtotaltiles3) );
			fbcurrenttileindex3 += ( fbcurrenttileindex3 < 0) ? fbtotaltiles3 : 0;
			// Obtain Offset X coordinate from current tile linear index
			float fblinearindextox3 = round ( fmod ( fbcurrenttileindex3, (float)_TextureColumns ) );
			// Multiply Offset X by coloffset
			float fboffsetx3 = fblinearindextox3 * fbcolsoffset3;
			// Obtain Offset Y coordinate from current tile linear index
			float fblinearindextoy3 = round( fmod( ( fbcurrenttileindex3 - fblinearindextox3 ) / (float)_TextureColumns, (float)_TextureRows ) );
			// Reverse Y to get tiles from Top to Bottom
			fblinearindextoy3 = (int)((float)_TextureRows-1) - fblinearindextoy3;
			// Multiply Offset Y by rowoffset
			float fboffsety3 = fblinearindextoy3 * fbrowsoffset3;
			// UV Offset
			float2 fboffset3 = float2(fboffsetx3, fboffsety3);
			// Flipbook UV
			half2 fbuv3 = i.uv_texcoord * fbtiling3 + fboffset3;
			// *** END Flipbook UV Animation vars ***
			o.Emission = ( tex2D( _LightAtlas, fbuv3 ) * _EmissionColor ).rgb;
			o.Metallic = _Metalic;
			o.Smoothness = _Smoothness;
			float2 uv_Occlusion = i.uv_texcoord * _Occlusion_ST.xy + _Occlusion_ST.zw;
			o.Occlusion = tex2D( _Occlusion, uv_Occlusion ).r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17400
-1661;-2106.857;1169;1004;1038.381;193.5884;1;True;False
Node;AmplifyShaderEditor.IntNode;6;-1150.1,431.1746;Inherit;False;Property;_TextureRows;TextureRows;2;0;Create;True;0;0;False;0;4;4;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;5;-1162.1,352.1746;Inherit;False;Property;_TextureColumns;TextureColumns;3;0;Create;True;0;0;False;0;1;4;0;1;INT;0
Node;AmplifyShaderEditor.TimeNode;10;-1180.1,612.1746;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;4;-1167.5,222;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;8;-1131.1,519.1746;Inherit;False;Property;_Speed;Speed;1;0;Create;True;0;0;False;0;4;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCFlipBookUVAnimation;3;-838.5,225;Inherit;False;0;0;6;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;18;-190.7501,40.16345;Inherit;False;Property;_DiffuseColor;DiffuseColor;4;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-530.5,175;Inherit;True;Property;_LightAtlas;LightAtlas;0;0;Create;True;0;0;False;0;-1;65ea21e01851d454cb09604d49fe9cc9;b43a2b9e1db6da94ab71e7bda5fdbf4c;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;16;-526.2346,-92.29219;Inherit;True;Property;_Diffuse;Diffuse;10;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-478.7359,379.4785;Inherit;False;Property;_EmissionColor;EmissionColor;5;0;Create;True;0;0;False;0;1,1,1,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;14;-110.7826,-254.0798;Inherit;False;Property;_Smoothness;Smoothness;8;0;Create;True;0;0;False;0;0.1007121;0.382;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-114.0995,-340.1321;Inherit;False;Property;_Metalic;Metalic;7;0;Create;True;0;0;False;0;0.1007121;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;19;38.24994,40.16345;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;17;-533.3585,-307.1853;Inherit;True;Property;_Occlusion;Occlusion;9;0;Create;True;0;0;False;0;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-219.8365,280.4788;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;13;-516.6772,602.387;Inherit;True;Property;_NormalMap;NormalMap;6;1;[Normal];Create;True;0;0;False;0;-1;None;98dc5a42cdf66384082f2ff832081fd6;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;291.2,80.60001;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;AnimatedStandard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;3;0;4;0
WireConnection;3;1;5;0
WireConnection;3;2;6;0
WireConnection;3;3;8;0
WireConnection;3;5;10;4
WireConnection;2;1;3;0
WireConnection;19;0;16;0
WireConnection;19;1;18;0
WireConnection;12;0;2;0
WireConnection;12;1;11;0
WireConnection;0;0;19;0
WireConnection;0;1;13;0
WireConnection;0;2;12;0
WireConnection;0;3;15;0
WireConnection;0;4;14;0
WireConnection;0;5;17;0
ASEEND*/
//CHKSM=7EB864B2F9393229471AC1217FF08F994DDF90D6