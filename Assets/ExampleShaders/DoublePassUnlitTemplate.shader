Shader /*ase_name*/ "Hidden/Legacy/Samples/DoublePassUnlit" /*end*/
{
	Properties
	{
		/*ase_props*/
	}
	
	SubShader
	{
		Tags { "RenderType" = "Opaque" }
		/*ase_pass*/
		Pass
		{
			Tags { }
			Name "First"
			/*ase_all_modules*/
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			/*ase_pragma*/

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				/*ase_vdata:p=p*/
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				/*ase_interp(0,):sp=sp.xyzw*/
			};

			/*ase_globals*/
			
			v2f vert ( appdata v /*ase_vert_input*/)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				/*ase_vert_code:v=appdata;o=v2f*/
				
				v.vertex.xyz += /*ase_vert_out:Local Vertex;Float3*/ float3(0,0,0) /*end*/;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i /*ase_frag_input*/) : SV_Target
			{
				fixed4 finalColor;
				/*ase_frag_code:i=v2f*/
				
				finalColor = /*ase_frag_out:Frag Color;Float4*/fixed4(1,1,1,1)/*end*/;
				return finalColor;
			}
			ENDCG
		}

		/*ase_pass*/
		Pass
		{
			Name "Second"
			Tags { }
			/*ase_all_modules*/
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			/*ase_pragma*/

			struct appdata
			{
				float4 vertex : POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				/*ase_vdata:p=p*/
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_OUTPUT_STEREO
				/*ase_interp(0,):sp=sp.xyzw*/
			};

			/*ase_globals*/
			
			v2f vert ( appdata v /*ase_vert_input*/)
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				/*ase_vert_code:v=appdata;o=v2f*/
				
				v.vertex.xyz += /*ase_vert_out:Local Vertex;Float3*/ float3(0,0,0) /*end*/;
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i /*ase_frag_input*/) : SV_Target
			{
				fixed4 finalColor;
				/*ase_frag_code:i=v2f*/
				
				finalColor = /*ase_frag_out:Frag Color;Float4*/fixed4(1,1,1,1)/*end*/;
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
}
