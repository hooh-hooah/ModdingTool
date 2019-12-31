// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SRP HD Omni Decal"
{
    Properties
    {
		_Size("Size", Range( 0 , 1)) = 1
		_Rampfalloff("Ramp falloff", Range( 0.01 , 5)) = 5
		_Ramp("Ramp", 2D) = "white" {}
    }

    SubShader
    {
		
        Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Transparent" "Queue"="Transparent" }

		Blend SrcAlpha OneMinusSrcAlpha
		Cull Front
		ZTest Always
		ZWrite Off
		Offset 0,0

		HLSLINCLUDE
		#pragma target 4.5
		#pragma only_renderers d3d11 ps4 xboxone vulkan metal switch
		#pragma multi_compile_instancing
		ENDHLSL

		
        Pass
        {
			
            Name "Forward Unlit"
            Tags { "LightMode"="ForwardOnly" }
        
            ColorMask RGBA
			

            HLSLPROGRAM
        
				#pragma vertex Vert
				#pragma fragment Frag

				#define ASE_SRP_VERSION 51601
				#define _SURFACE_TYPE_TRANSPARENT 1
				#define _BLENDMODE_ALPHA 1

        
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"

                #define SHADERPASS SHADERPASS_FORWARD_UNLIT
                
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
	        

				struct AttributesMesh 
				{
					float3 positionOS : POSITION;
					float4 normalOS : NORMAL;
					
					#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
					#endif
				};

				struct PackedVaryingsMeshToPS 
				{
					float4 positionCS : SV_Position;
					float4 ase_texcoord : TEXCOORD0;
					#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC; 
					#endif
					UNITY_VERTEX_OUTPUT_STEREO
				};

				sampler2D _Ramp;
				float4x4 unity_CameraProjection;
				float4x4 unity_CameraInvProjection;
				float4x4 unity_WorldToCamera;
				float4x4 unity_CameraToWorld;
				float _Size;
				float _Rampfalloff;
				
				float CallSampleCameraDepth( float2 UV )
				{
					return SampleCameraDepth( UV );
				}
				
                
		            
				struct SurfaceDescription
				{
					float3 Color;
					float Alpha;
					float AlphaClipThreshold;
				};
        
		
				void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, out SurfaceData surfaceData)
				{
					ZERO_INITIALIZE(SurfaceData, surfaceData);
					surfaceData.color = surfaceDescription.Color;
				}
        
				void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription , FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
				{
				#if _ALPHATEST_ON
					DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif
					BuildSurfaceData(fragInputs, surfaceDescription, V, surfaceData);
					
					ZERO_INITIALIZE(BuiltinData, builtinData); 
					builtinData.opacity = surfaceDescription.Alpha;
				}
        
         
				PackedVaryingsMeshToPS Vert(AttributesMesh inputMesh  )
				{
					PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
					UNITY_SETUP_INSTANCE_ID(inputMesh);
					UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);

					float4 ase_clipPos = TransformWorldToHClip( TransformObjectToWorld(inputMesh.positionOS));
					float4 screenPos = ComputeScreenPos( ase_clipPos , _ProjectionParams.x );
					outputPackedVaryingsMeshToPS.ase_texcoord = screenPos;
					
					float3 vertexValue =  float3( 0, 0, 0 ) ;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
					inputMesh.positionOS.xyz = vertexValue;
					#else
					inputMesh.positionOS.xyz += vertexValue;
					#endif

					inputMesh.normalOS =  inputMesh.normalOS ;

					float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
					outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
					UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );
					return outputPackedVaryingsMeshToPS;
				}

				float4 Frag(PackedVaryingsMeshToPS packedInput ) : SV_Target
				{
					UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
					FragInputs input;
					ZERO_INITIALIZE(FragInputs, input);
					input.worldToTangent = k_identity3x3;
					input.positionSS = packedInput.positionCS;
				
					PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

					float3 V = float3(1.0, 1.0, 1.0);

					SurfaceData surfaceData;
					BuiltinData builtinData;
					SurfaceDescription surfaceDescription = (SurfaceDescription)0;
					float4 transform114 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
					transform114.xyz = GetAbsolutePositionWS((transform114).xyz);
					float4 screenPos = packedInput.ase_texcoord;
					float4 ase_screenPosNorm = screenPos / screenPos.w;
					ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
					float2 UV60_g8 = ase_screenPosNorm.xy;
					float localCallSampleCameraDepth60_g8 = CallSampleCameraDepth( UV60_g8 );
					#ifdef UNITY_REVERSED_Z
					float4 staticSwitch38_g8 = ( 1.0 - localCallSampleCameraDepth60_g8 );
					#else
					float4 staticSwitch38_g8 = localCallSampleCameraDepth60_g8;
					#endif
					float3 appendResult39_g8 = (float3(ase_screenPosNorm.x , ase_screenPosNorm.y , staticSwitch38_g8.r));
					float4 appendResult42_g8 = (float4((appendResult39_g8*2.0 + -1.0) , 1.0));
					float4 temp_output_43_0_g8 = mul( unity_CameraInvProjection, appendResult42_g8 );
					float4 appendResult49_g8 = (float4(( ( (temp_output_43_0_g8).xyz / (temp_output_43_0_g8).w ) * float3( 1,1,-1 ) ) , 1.0));
					float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
					float temp_output_184_0 = ( 1.0 - saturate( pow( ( length( abs( (( transform114 - mul( unity_CameraToWorld, appendResult49_g8 ) )).xyz ) ) / ( max( max( ase_objectScale.x , ase_objectScale.y ) , ase_objectScale.z ) * 0.5 * _Size ) ) , _Rampfalloff ) ) );
					float2 temp_cast_2 = (temp_output_184_0).xx;
					
					surfaceDescription.Color =  tex2Dlod( _Ramp, float4( temp_cast_2, 0, 0.0) ).rgb;
					surfaceDescription.Alpha = temp_output_184_0;
					surfaceDescription.AlphaClipThreshold =  0;

					GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

					BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

					float4 outColor = ApplyBlendMode(bsdfData.color + builtinData.emissiveColor, builtinData.opacity);
					outColor = EvaluateAtmosphericScattering(posInput, V, outColor);

					return outColor;
				}

            ENDHLSL
        }

		
        Pass
        {
			
            Name "SceneSelectionPass"
            Tags { "LightMode"="SceneSelectionPass" }

            ColorMask 0
        
            HLSLPROGRAM
				#pragma vertex Vert
				#pragma fragment Frag
        
				#define ASE_SRP_VERSION 51601
				#define _SURFACE_TYPE_TRANSPARENT 1
				#define _BLENDMODE_ALPHA 1


				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
                #define SHADERPASS SHADERPASS_DEPTH_ONLY
                #define SCENESELECTIONPASS
        
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"

				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
				int _ObjectId;
				int _PassValue;
        
				struct AttributesMesh 
				{
					float3 positionOS : POSITION;
					float3 normalOS : NORMAL;
					
					#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
					#endif
				};
        
				struct PackedVaryingsMeshToPS 
				{
					float4 positionCS : SV_Position; 
					
					#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC; 
					#endif 
				};

				struct SurfaceDescription
				{
					float Alpha;
					float AlphaClipThreshold;
				};
        
						
				                
        
				void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
				{
					ZERO_INITIALIZE(SurfaceData, surfaceData);
				}
        
				void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
				{
				#if _ALPHATEST_ON
					DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

					BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
					ZERO_INITIALIZE (BuiltinData, builtinData); 
					builtinData.opacity = surfaceDescription.Alpha;
				}
        
       
				PackedVaryingsMeshToPS Vert(AttributesMesh inputMesh )
				{
					PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
					
					UNITY_SETUP_INSTANCE_ID(inputMesh);
					UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
					
					
					float3 vertexValue =  float3( 0, 0, 0 ) ;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
					inputMesh.positionOS.xyz = vertexValue;
					#else
					inputMesh.positionOS.xyz += vertexValue;
					#endif

					inputMesh.normalOS =  inputMesh.normalOS ;

					float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
					
					outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
					return outputPackedVaryingsMeshToPS;
				}

				void Frag(  PackedVaryingsMeshToPS packedInput
							#ifdef WRITE_NORMAL_BUFFER
							, out float4 outNormalBuffer : SV_Target0
								#ifdef WRITE_MSAA_DEPTH
								, out float1 depthColor : SV_Target1
								#endif
							#elif defined(WRITE_MSAA_DEPTH)
							, out float4 outNormalBuffer : SV_Target0
							, out float1 depthColor : SV_Target1
							#elif defined(SCENESELECTIONPASS)
							, out float4 outColor : SV_Target0
							#endif

							#ifdef _DEPTHOFFSET_ON
							, out float outputDepth : SV_Depth
							#endif
							
						)
				{
					FragInputs input;
					ZERO_INITIALIZE(FragInputs, input);
					input.worldToTangent = k_identity3x3;
					input.positionSS = packedInput.positionCS;
					

					// input.positionSS is SV_Position
					PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				
					float3 V = float3(1.0, 1.0, 1.0); // Avoid the division by 0
				
					SurfaceData surfaceData;
					BuiltinData builtinData;
					SurfaceDescription surfaceDescription = (SurfaceDescription) 0;
					
					surfaceDescription.Alpha = 1;
					surfaceDescription.AlphaClipThreshold = 0;
					GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
					outputDepth = posInput.deviceDepth;
				#endif

				#ifdef WRITE_NORMAL_BUFFER
					EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), posInput.positionSS, outNormalBuffer);
					#ifdef WRITE_MSAA_DEPTH
					depthColor = packedInput.positionCS.z;
					#endif
				#elif defined(WRITE_MSAA_DEPTH) 
					outNormalBuffer = float4(0.0, 0.0, 0.0, 1.0);
					depthColor = packedInput.vmesh.positionCS.z;
				#elif defined(SCENESELECTIONPASS)
					outColor = float4(_ObjectId, _PassValue, 1.0, 1.0);
				#endif
				}

            ENDHLSL
        }
		
        Pass
        {
			
            Name "Motion Vectors"
            Tags { "LightMode"="MotionVectors" }
        
			Stencil
			{
				Ref 160
				WriteMask 176
				Comp Always
				Pass Replace
				Fail Keep
				ZFail Keep
			}


			ColorMask 0

            HLSLPROGRAM
				//#define UNITY_MATERIAL_LIT
				#pragma vertex Vert
				#pragma fragment Frag
        
				#define ASE_SRP_VERSION 51601
				#define _SURFACE_TYPE_TRANSPARENT 1
				#define _BLENDMODE_ALPHA 1

        
				#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
        
				#define SHADERPASS SHADERPASS_MOTION_VECTORS
				#pragma multi_compile _ WRITE_NORMAL_BUFFER
                #pragma multi_compile _ WRITE_MSAA_DEPTH

                #define VARYINGS_NEED_POSITION_WS
        
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Unlit/Unlit.hlsl"

				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"
        
				struct SurfaceDescription
				{
					float Alpha;
					float AlphaClipThreshold;
				};

				struct AttributesMesh
				{
					float3 positionOS : POSITION;
					float3 normalOS : NORMAL;
					
					#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
					#endif
				};
        
				struct VaryingsMeshToPS 
				{
					float4 positionCS : SV_Position;
					float3 positionRWS;
					#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
					#endif
				};

				struct AttributesPass
				{
					float3 previousPositionOS : TEXCOORD4;
				};

				struct VaryingsPassToPS
				{
					float4 positionCS;
					float4 previousPositionCS;
				};

				#define VARYINGS_NEED_PASS

				struct VaryingsToPS
				{
					VaryingsMeshToPS vmesh;
					VaryingsPassToPS vpass;
				};

				struct PackedVaryingsToPS
				{
					float3 vmeshInterp00 : TEXCOORD0;
					float4 vmeshPositionCS : SV_Position;
					float3 vpassInterpolators0 : TEXCOORD1;
					float3 vpassInterpolators1 : TEXCOORD2;
					
					#if UNITY_ANY_INSTANCING_ENABLED
					uint vmeshInstanceID : INSTANCEID_SEMANTIC;
					#endif
				};

								
				            
				FragInputs BuildFragInputs(VaryingsMeshToPS input)
				{
					FragInputs output;
					ZERO_INITIALIZE(FragInputs, output);
					output.worldToTangent = k_identity3x3;
					output.positionSS = input.positionCS;
					output.positionRWS = input.positionRWS;
					return output;
				}
                
				void BuildSurfaceData(FragInputs fragInputs, SurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData)
				{
					ZERO_INITIALIZE(SurfaceData, surfaceData);
				}
        
				void GetSurfaceAndBuiltinData(SurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
				{
				#if _ALPHATEST_ON
					DoAlphaTest ( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif
					BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData);
					
					ZERO_INITIALIZE (BuiltinData, builtinData);
					builtinData.opacity = surfaceDescription.Alpha;
				}
        

				VaryingsMeshToPS UnpackVaryingsMeshToPS(PackedVaryingsToPS input)
				{
					VaryingsMeshToPS output;
					output.positionCS = input.vmeshPositionCS;
					output.positionRWS = input.vmeshInterp00.xyz;
					#if UNITY_ANY_INSTANCING_ENABLED
					output.instanceID = input.vmeshInstanceID;
					#endif
					return output;
				}

				VaryingsPassToPS UnpackVaryingsPassToPS(PackedVaryingsToPS input)
				{
					VaryingsPassToPS output;
					output.positionCS = float4(input.vpassInterpolators0.xy, 0.0, input.vpassInterpolators0.z);
					output.previousPositionCS = float4(input.vpassInterpolators1.xy, 0.0, input.vpassInterpolators1.z);

					return output;
				}

				PackedVaryingsToPS PackVaryingsToPS(VaryingsToPS varyingsType)
				{
					PackedVaryingsToPS outputPackedVaryingsToPS;
					
					outputPackedVaryingsToPS.vmeshPositionCS = varyingsType.vmesh.positionCS;
					outputPackedVaryingsToPS.vmeshInterp00.xyz = varyingsType.vmesh.positionRWS;
					#if UNITY_ANY_INSTANCING_ENABLED
					outputPackedVaryingsToPS.vmeshInstanceID = varyingsType.vmesh.instanceID;
					#endif
					outputPackedVaryingsToPS.vpassInterpolators0 = float3(varyingsType.vpass.positionCS.xyw);
					outputPackedVaryingsToPS.vpassInterpolators1 = float3(varyingsType.vpass.previousPositionCS.xyw);
					return outputPackedVaryingsToPS;
				}

				float3 TransformPreviousObjectToWorldNormal(float3 normalOS)
				{
				#ifdef UNITY_ASSUME_UNIFORM_SCALING
					return normalize(mul((float3x3)unity_MatrixPreviousM, normalOS));
				#else
					return normalize(mul(normalOS, (float3x3)unity_MatrixPreviousMI));
				#endif
				}

				float3 TransformPreviousObjectToWorld(float3 positionOS)
				{
					float4x4 previousModelMatrix = ApplyCameraTranslationToMatrix(unity_MatrixPreviousM);
					return mul(previousModelMatrix, float4(positionOS, 1.0)).xyz;
				}

				void VelocityPositionZBias(VaryingsToPS input)
				{
				#if defined(UNITY_REVERSED_Z)
					input.vmesh.positionCS.z -= unity_MotionVectorsParams.z * input.vmesh.positionCS.w;
				#else
					input.vmesh.positionCS.z += unity_MotionVectorsParams.z * input.vmesh.positionCS.w;
				#endif
				}

				PackedVaryingsToPS Vert(AttributesMesh inputMesh,
										AttributesPass inputPass
										
										)
				{
					PackedVaryingsToPS outputPackedVaryingsToPS;
					VaryingsToPS varyingsType;
					VaryingsMeshToPS outputVaryingsMeshToPS;

					UNITY_SETUP_INSTANCE_ID(inputMesh);
					UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputVaryingsMeshToPS);

					
					float3 vertexValue =  float3( 0, 0, 0 ) ;
					#ifdef ASE_ABSOLUTE_VERTEX_POS
					inputMesh.positionOS.xyz = vertexValue;
					#else
					inputMesh.positionOS.xyz += vertexValue;
					#endif

					inputMesh.normalOS =  inputMesh.normalOS ;

					float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
					outputVaryingsMeshToPS.positionRWS = positionRWS;
					outputVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
					

					varyingsType.vmesh = outputVaryingsMeshToPS;

					VelocityPositionZBias(varyingsType);
					varyingsType.vpass.positionCS = mul(_NonJitteredViewProjMatrix, float4(varyingsType.vmesh.positionRWS, 1.0));
					bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
					if (forceNoMotion)
					{
						varyingsType.vpass.previousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
					}
					else
					{
						bool hasDeformation = unity_MotionVectorsParams.x > 0.0; // Skin or morph target

						float3 previousPositionRWS = TransformPreviousObjectToWorld(hasDeformation ? inputPass.previousPositionOS : inputMesh.positionOS);

						float3 normalWS = float3(0.0, 0.0, 0.0);

						varyingsType.vpass.previousPositionCS = mul(_PrevViewProjMatrix, float4(previousPositionRWS, 1.0));
					}

					outputPackedVaryingsToPS.vmeshPositionCS = varyingsType.vmesh.positionCS;
					outputPackedVaryingsToPS.vmeshInterp00.xyz = varyingsType.vmesh.positionRWS;
					
					#if UNITY_ANY_INSTANCING_ENABLED
					outputPackedVaryingsToPS.vmeshInstanceID = varyingsType.vmesh.instanceID;
					#endif

					outputPackedVaryingsToPS.vpassInterpolators0 = float3(varyingsType.vpass.positionCS.xyw);
					outputPackedVaryingsToPS.vpassInterpolators1 = float3(varyingsType.vpass.previousPositionCS.xyw);
					return outputPackedVaryingsToPS;
				}

				void Frag(	PackedVaryingsToPS packedInput
							, out float4 outMotionVector : SV_Target0
					#ifdef WRITE_NORMAL_BUFFER
							, out float4 outNormalBuffer : SV_Target1
					#ifdef WRITE_MSAA_DEPTH
							, out float1 depthColor : SV_Target2
					#endif
					#elif defined(WRITE_MSAA_DEPTH) 
							, out float4 outNormalBuffer : SV_Target1
							, out float1 depthColor : SV_Target2
					#endif
					#ifdef _DEPTHOFFSET_ON
					, out float outputDepth : SV_Depth
					#endif
							
						)
				{
					
					VaryingsMeshToPS unpacked= UnpackVaryingsMeshToPS(packedInput);
					FragInputs input = BuildFragInputs(unpacked);
					

					PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

					float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

					SurfaceData surfaceData;
					BuiltinData builtinData;
					
					SurfaceDescription surfaceDescription = (SurfaceDescription)0;
                    
					surfaceDescription.Alpha = 1;
					surfaceDescription.AlphaClipThreshold = 0;
	
					GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

					VaryingsPassToPS inputPass = UnpackVaryingsPassToPS(packedInput);
				#ifdef _DEPTHOFFSET_ON
					inputPass.positionCS.w += builtinData.depthOffset;
					inputPass.previousPositionCS.w += builtinData.depthOffset;
				#endif

					float2 motionVector = CalculateMotionVector (inputPass.positionCS, inputPass.previousPositionCS);
					EncodeMotionVector (motionVector * 0.5, outMotionVector);

					bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
					if (forceNoMotion)
						outMotionVector = float4(2.0, 0.0, 0.0, 0.0);

				#ifdef WRITE_NORMAL_BUFFER
					EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), posInput.positionSS, outNormalBuffer);

					#ifdef WRITE_MSAA_DEPTH
					depthColor = packedInput.vmeshPositionCS.z;
					#endif
				#elif defined(WRITE_MSAA_DEPTH) 
					outNormalBuffer = float4(0.0, 0.0, 0.0, 1.0);
					depthColor = packedInput.vmeshPositionCS.z;
				#endif

				#ifdef _DEPTHOFFSET_ON
					outputDepth = posInput.deviceDepth;
				#endif
				}

            ENDHLSL
        }
		
    }
    FallBack "Hidden/InternalErrorShader"
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16705
311;73;1332;728;-832.9017;-333.2165;1.39227;True;False
Node;AmplifyShaderEditor.CommentaryNode;219;1378.052,401.4491;Float;False;328.9616;247.4789;Object pivot position in world space;1;114;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;220;1674.094,745.6295;Float;False;527.0399;229;Make the effect scale with the sphere;3;152;154;155;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;185;3348.951,288;Float;True;Property;_Ramp;Ramp;4;0;Create;True;0;0;False;0;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;MipLevel;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;233;3163.349,370.7596;Float;False;Constant;_Float0;Float 0;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;184;3120,496;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;187;2944,496;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;163;2736,496;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;164;2495.099,669.4001;Float;False;Property;_Rampfalloff;Ramp falloff;3;0;Create;True;0;0;False;0;5;5;0.01;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;148;2560,496;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;159;2400,496;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;156;2254.979,824.6212;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;155;2047.13,831.1067;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;158;2240,496;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;160;2016,496;Float;False;True;True;True;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;154;1923.721,798.6289;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;113;1830.928,475.2047;Float;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectScaleNode;152;1724.094,795.6295;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.FunctionNode;232;1256.361,701.5815;Float;False;Reconstruct World Position From Depth;1;;8;e7094bcbcc80eb140b2a3dbe6a861de8;0;0;1;FLOAT4;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;114;1428.052,451.4491;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;216;1922.201,1004.83;Float;False;Property;_Size;Size;0;0;Create;True;0;0;False;0;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;234;3685.973,508.2288;Float;False;False;2;Float;ASEMaterialInspector;0;1;Hidden/Templates/HDSRPUnlit;dfe2f27ac20b08c469b2f95c236be0c3;True;SceneSelectionPass;0;4;SceneSelectionPass;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;True;0;False;-1;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;0;;0;0;Standard;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;222;3685.973,468.2288;Float;False;True;2;Float;ASEMaterialInspector;0;4;SRP HD Omni Decal;dfe2f27ac20b08c469b2f95c236be0c3;True;Forward Unlit;0;1;Forward Unlit;5;True;2;5;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;False;True;1;False;-1;False;False;True;2;False;-1;True;7;False;-1;True;False;0;False;-1;0;False;-1;True;3;RenderPipeline=HDRenderPipeline;RenderType=Transparent=RenderType;Queue=Transparent=Queue=0;True;5;0;False;False;False;False;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;True;1;LightMode=ForwardOnly;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;6;False;True;False;False;True;True;False;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;223;3696.048,315.2336;Float;False;False;2;Float;ASEMaterialInspector;0;1;Hidden/Templates/HDSRPUnlit;dfe2f27ac20b08c469b2f95c236be0c3;True;ShadowCaster;0;2;ShadowCaster;1;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;True;0;False;-1;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;True;False;False;False;False;0;False;-1;False;False;False;False;True;1;LightMode=ShadowCaster;False;0;;0;0;Standard;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;221;3696.048,315.2336;Float;False;False;2;Float;ASEMaterialInspector;0;1;Hidden/Templates/HDSRPUnlit;dfe2f27ac20b08c469b2f95c236be0c3;True;Depth prepass;0;0;Depth prepass;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;True;0;False;-1;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;True;False;False;False;False;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;True;1;LightMode=DepthForwardOnly;False;0;;0;0;Standard;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;224;3696.048,315.2336;Float;False;False;2;Float;ASEMaterialInspector;0;1;Hidden/Templates/HDSRPUnlit;dfe2f27ac20b08c469b2f95c236be0c3;True;META;0;3;META;1;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;True;0;False;-1;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;True;2;False;-1;False;False;False;False;False;True;1;LightMode=Meta;False;0;;0;0;Standard;0;5;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;235;3685.973,508.2288;Float;False;False;2;Float;ASEMaterialInspector;0;1;Hidden/Templates/HDSRPUnlit;dfe2f27ac20b08c469b2f95c236be0c3;True;Motion Vectors;0;5;Motion Vectors;0;True;1;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;False;False;True;0;False;-1;False;False;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;0;False;False;False;False;True;False;False;False;False;0;False;-1;True;True;160;False;-1;255;False;-1;176;False;-1;7;False;-1;3;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;False;False;False;True;1;LightMode=MotionVectors;False;0;;0;0;Standard;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;0
WireConnection;185;1;184;0
WireConnection;185;2;233;0
WireConnection;184;0;187;0
WireConnection;187;0;163;0
WireConnection;163;0;148;0
WireConnection;163;1;164;0
WireConnection;148;0;159;0
WireConnection;148;1;156;0
WireConnection;159;0;158;0
WireConnection;156;0;155;0
WireConnection;156;2;216;0
WireConnection;155;0;154;0
WireConnection;155;1;152;3
WireConnection;158;0;160;0
WireConnection;160;0;113;0
WireConnection;154;0;152;1
WireConnection;154;1;152;2
WireConnection;113;0;114;0
WireConnection;113;1;232;0
WireConnection;222;0;185;0
WireConnection;222;1;184;0
ASEEND*/
//CHKSM=1237013DF1EFA80FAF1E9B694E4D8743AD2C1E77