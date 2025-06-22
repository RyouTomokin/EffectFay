// Made with Amplify Shader Editor v1.9.8.1
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SinCourse/PBR简化"
{
	Properties
	{
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Toggle(_ALBEDOOFF_ON)] _AlbedoOFF("AlbedoOFF", Float) = 0
		[Toggle(_EMISSIONSWITCH_ON)] _EmissionSwitch("EmissionSwitch", Float) = 0
		_AO("AO", Float) = 1
		_Gloss("Gloss", Float) = 1
		_Metallic("Metallic", Float) = 1
		[HDR]_AllColor("AllColor", Color) = (1,1,1,1)
		[HDR]_MainColor("MainColor", Color) = (1,1,1,1)
		_MainTex("MainTex", 2D) = "white" {}
		_MainTexU("MainTexU", Float) = 0
		_MainTexV("MainTexV", Float) = 0
		_NormalTex("NormalTex", 2D) = "bump" {}
		_NormalTexU("NormalTexU", Float) = 0
		_NormalTexV("NormalTexV", Float) = 0
		_NormalIntensity("NormalIntensity", Float) = 1
		_SecTex("SecTex", 2D) = "white" {}
		_SecTexU("SecTexU", Float) = 0
		_SecTexV("SecTexV", Float) = 0
		_CubeMapTex("CubeMapTex", CUBE) = "white" {}
		_CubeMapIntensity("CubeMapIntensity", Float) = 0
		_OffsetTex("OffsetTex", 2D) = "white" {}
		_OffsetTexU("OffsetTexU", Float) = 0
		_OffsetTexV("OffsetTexV", Float) = 0
		_VertexOffsetIntensity("VertexOffsetIntensity", Float) = 0
		_OffsetMaskTex("OffsetMaskTex", 2D) = "white" {}
		_OffsetMaskTexU("OffsetMaskTexU", Float) = 0
		_OffsetMaskTexV("OffsetMaskTexV", Float) = 0
		[Toggle]_OpacityMaskTexSwitch("OpacityMaskTexSwitch", Float) = 1
		_OpacityMaskTex("OpacityMaskTex", 2D) = "white" {}
		_OpacityMaskTexU("OpacityMaskTexU", Float) = 0
		_OpacityMaskTexV("OpacityMaskTexV", Float) = 0
		[Toggle]_OffsetMaskTexFrequencyToOpacityMaskTex("OffsetMaskTexFrequencyToOpacityMaskTex", Float) = 0
		[Toggle]_DitherSwitch("DitherSwitch", Float) = 0
		_DitherBias("DitherBias", Float) = 0
		_MaskAddBias("MaskAddBias", Float) = -0.5
		_AlphaTex1("AlphaTex1", 2D) = "white" {}
		_AlphaTex1U("AlphaTex1U", Float) = 0
		_AlphaTex1V("AlphaTex1V", Float) = 0
		_DistortionTex("DistortionTex", 2D) = "white" {}
		_DistortionU("DistortionU", Float) = 0
		_DistortionV("DistortionV", Float) = 0
		_DistortionIntensity("DistortionIntensity", Float) = 0
		[Toggle]_Distortion2UV("Distortion2UV", Float) = 0
		[Toggle]_NormalTexDistortionUV("NormalTexDistortionUV", Float) = 0
		[Toggle]_SecTexDistortionUV("SecTexDistortionUV", Float) = 0
		[Toggle]_OffsetTexDistortionUV("OffsetTexDistortionUV", Float) = 0


		//_TransmissionShadow( "Transmission Shadow", Range( 0, 1 ) ) = 0.5
		//_TransStrength( "Trans Strength", Range( 0, 50 ) ) = 1
		//_TransNormal( "Trans Normal Distortion", Range( 0, 1 ) ) = 0.5
		//_TransScattering( "Trans Scattering", Range( 1, 50 ) ) = 2
		//_TransDirect( "Trans Direct", Range( 0, 1 ) ) = 0.9
		//_TransAmbient( "Trans Ambient", Range( 0, 1 ) ) = 0.1
		//_TransShadow( "Trans Shadow", Range( 0, 1 ) ) = 0.5
		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1
		[HideInInspector][ToggleOff] _EnvironmentReflections("Environment Reflections", Float) = 1
		[HideInInspector][ToggleOff] _ReceiveShadows("Receive Shadows", Float) = 1.0

		[HideInInspector] _QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector] _QueueControl("_QueueControl", Float) = -1

        [HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" "UniversalMaterialType"="Lit" }

		Cull Back
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		AlphaToMask Off

		

		HLSLINCLUDE
		#pragma target 4.5
		#pragma prefer_hlslcc gles
		// ensure rendering platforms toggle list is visible

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlane (float3 pos, float4 plane)
		{
			float d = dot (float4(pos,1.0f), plane);
			return d;
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlane(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlane(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlane(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlane(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
							(( DistanceFromPlane(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="UniversalForward" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			

			HLSLPROGRAM

			

			#pragma multi_compile_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS

			
            #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
		

			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION

			

			
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile _ _LIGHT_LAYERS
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ _FORWARD_PLUS

			

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_FORWARD

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#pragma shader_feature _ALBEDOOFF_ON
			#pragma shader_feature _EMISSIONSWITCH_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			samplerCUBE _CubeMapTex;
			sampler2D _NormalTex;
			sampler2D _MainTex;
			sampler2D _SecTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				output.ase_texcoord8.xyz = input.texcoord.xyz;
				output.ase_texcoord9.xy = input.texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord8.w = 0;
				output.ase_texcoord9.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif
				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				output.tSpace0 = float4( normalInput.normalWS, vertexInput.positionWS.x );
				output.tSpace1 = float4( normalInput.tangentWS, vertexInput.positionWS.y );
				output.tSpace2 = float4( normalInput.bitangentWS, vertexInput.positionWS.z );

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(input.texcoord1, unity_LightmapST, output.lightmapUVOrVertexSH.xy);
				#else
					OUTPUT_SH(normalInput.normalWS.xyz, output.lightmapUVOrVertexSH.xyz);
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
					output.dynamicLightmapUV.xy = input.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					output.lightmapUVOrVertexSH.zw = input.texcoord.xy;
					output.lightmapUVOrVertexSH.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					output.fogFactorAndVertexLight = 0;
					#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
						output.fogFactorAndVertexLight.x = ComputeFogFactor(vertexInput.positionCS.z);
					#endif
					#ifdef _ADDITIONAL_LIGHTS_VERTEX
						half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );
						output.fogFactorAndVertexLight.yzw = vertexLight;
					#endif
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				output.positionCS = vertexInput.positionCS;
				output.clipPosV = vertexInput.positionCS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				output.texcoord1 = input.texcoord1;
				output.texcoord2 = input.texcoord2;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag ( PackedVaryings input
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (input.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( input.tSpace0.xyz );
					float3 WorldTangent = input.tSpace1.xyz;
					float3 WorldBiTangent = input.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(input.tSpace0.w,input.tSpace1.w,input.tSpace2.w);
				float3 WorldViewDirection = GetWorldSpaceNormalizeViewDir( WorldPosition );
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = input.clipPosV;
				float4 ScreenPos = ComputeScreenPos( input.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = input.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#endif

				float2 uv_NormalTex = input.ase_texcoord8.xyz.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
				float2 appendResult66 = (float2(( _NormalTexU * _TimeParameters.x ) , ( _TimeParameters.x * _NormalTexV )));
				float2 temp_output_68_0 = ( uv_NormalTex + appendResult66 );
				float2 uv_DistortionTex = input.ase_texcoord8.xyz.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord9.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult71 = lerp( float3( temp_output_68_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float3 unpack74 = UnpackNormalScale( tex2D( _NormalTex, (( _NormalTexDistortionUV )?( lerpResult71 ):( half3( temp_output_68_0 ,  0.0 ) )).xy ), _NormalIntensity );
				unpack74.z = lerp( 1, unpack74.z, saturate(_NormalIntensity) );
				float3 tex2DNode74 = unpack74;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 worldRefl37 = normalize( reflect( -WorldViewDirection, float3( dot( tanToWorld0, tex2DNode74 ), dot( tanToWorld1, tex2DNode74 ), dot( tanToWorld2, tex2DNode74 ) ) ) );
				float2 uv_MainTex = input.ase_texcoord8.xyz.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 appendResult55 = (float2(( _MainTexU * _TimeParameters.x ) , ( _TimeParameters.x * _MainTexV )));
				float4 temp_output_48_0 = ( ( ( _CubeMapIntensity * texCUBE( _CubeMapTex, worldRefl37 ) ) + ( _MainColor * tex2D( _MainTex, ( uv_MainTex + appendResult55 ) ) ) ) * _AllColor );
				#ifdef _ALBEDOOFF_ON
				float4 staticSwitch59 = float4( 0,0,0,0 );
				#else
				float4 staticSwitch59 = temp_output_48_0;
				#endif
				
				#ifdef _EMISSIONSWITCH_ON
				float4 staticSwitch58 = temp_output_48_0;
				#else
				float4 staticSwitch58 = float4( 0,0,0,0 );
				#endif
				
				float2 uv_SecTex = input.ase_texcoord8.xyz.xy * _SecTex_ST.xy + _SecTex_ST.zw;
				float2 appendResult18 = (float2(( _SecTexU * _TimeParameters.x ) , ( _TimeParameters.x * _SecTexV )));
				float2 temp_output_19_0 = ( uv_SecTex + appendResult18 );
				float3 lerpResult143 = lerp( float3( temp_output_19_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float4 tex2DNode4 = tex2D( _SecTex, (( _SecTexDistortionUV )?( lerpResult143 ):( half3( temp_output_19_0 ,  0.0 ) )).xy );
				
				float2 uv_OffsetTex = input.ase_texcoord8.xyz.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord8.xyz.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord8.xyz.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord8.xyz.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 ase_positionSSNorm = ScreenPos / ScreenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float3 BaseColor = staticSwitch59.rgb;
				float3 Normal = tex2DNode74;
				float3 Emission = staticSwitch58.rgb;
				float3 Specular = 0.5;
				float Metallic = ( tex2DNode4.b * _Metallic );
				float Smoothness = ( tex2DNode4.g * _Gloss );
				float Occlusion = ( tex2DNode4.r * _AO );
				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = input.positionCS.z;
				#endif

				#ifdef _CLEARCOAT
					float CoatMask = 0;
					float CoatSmoothness = 0;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.positionCS = input.positionCS;
				inputData.viewDirectionWS = WorldViewDirection;

				#ifdef _NORMALMAP
						#if _NORMAL_DROPOFF_TS
							inputData.normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent, WorldBiTangent, WorldNormal));
						#elif _NORMAL_DROPOFF_OS
							inputData.normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							inputData.normalWS = Normal;
						#endif
					inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				#else
					inputData.normalWS = WorldNormal;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					inputData.shadowCoord = ShadowCoords;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					inputData.shadowCoord = TransformWorldToShadowCoord(inputData.positionWS);
				#else
					inputData.shadowCoord = float4(0, 0, 0, 0);
				#endif

				#ifdef ASE_FOG
					inputData.fogCoord = InitializeInputDataFog(float4(inputData.positionWS, 1.0), input.fogFactorAndVertexLight.x);
				#endif
				#ifdef _ADDITIONAL_LIGHTS_VERTEX
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = input.lightmapUVOrVertexSH.xyz;
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, input.dynamicLightmapUV.xy, SH, inputData.normalWS);
				#else
					inputData.bakedGI = SAMPLE_GI(input.lightmapUVOrVertexSH.xy, SH, inputData.normalWS);
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.dynamicLightmapUV.xy;
					#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				SurfaceData surfaceData;
				surfaceData.albedo              = BaseColor;
				surfaceData.metallic            = saturate(Metallic);
				surfaceData.specular            = Specular;
				surfaceData.smoothness          = saturate(Smoothness),
				surfaceData.occlusion           = Occlusion,
				surfaceData.emission            = Emission,
				surfaceData.alpha               = saturate(Alpha);
				surfaceData.normalTS            = Normal;
				surfaceData.clearCoatMask       = 0;
				surfaceData.clearCoatSmoothness = 1;

				#ifdef _CLEARCOAT
					surfaceData.clearCoatMask       = saturate(CoatMask);
					surfaceData.clearCoatSmoothness = saturate(CoatSmoothness);
				#endif

				#ifdef _DBUFFER
					ApplyDecalToSurfaceData(input.positionCS, surfaceData, inputData);
				#endif

				#ifdef _ASE_LIGHTING_SIMPLE
					half4 color = UniversalFragmentBlinnPhong( inputData, surfaceData);
				#else
					half4 color = UniversalFragmentPBR( inputData, surfaceData);
				#endif

				#ifdef ASE_TRANSMISSION
				{
					float shadow = _TransmissionShadow;

					#define SUM_LIGHT_TRANSMISSION(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 transmission = max( 0, -dot( inputData.normalWS, Light.direction ) ) * atten * Transmission;\
						color.rgb += BaseColor * transmission;

					SUM_LIGHT_TRANSMISSION( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSMISSION( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSMISSION( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_TRANSLUCENCY
				{
					float shadow = _TransShadow;
					float normal = _TransNormal;
					float scattering = _TransScattering;
					float direct = _TransDirect;
					float ambient = _TransAmbient;
					float strength = _TransStrength;

					#define SUM_LIGHT_TRANSLUCENCY(Light)\
						float3 atten = Light.color * Light.distanceAttenuation;\
						atten = lerp( atten, atten * Light.shadowAttenuation, shadow );\
						half3 lightDir = Light.direction + inputData.normalWS * normal;\
						half VdotL = pow( saturate( dot( inputData.viewDirectionWS, -lightDir ) ), scattering );\
						half3 translucency = atten * ( VdotL * direct + inputData.bakedGI * ambient ) * Translucency;\
						color.rgb += BaseColor * translucency * strength;

					SUM_LIGHT_TRANSLUCENCY( GetMainLight( inputData.shadowCoord ) );

					#if defined(_ADDITIONAL_LIGHTS)
						uint meshRenderingLayers = GetMeshRenderingLayer();
						uint pixelLightCount = GetAdditionalLightsCount();
						#if USE_FORWARD_PLUS
							for (uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
							{
								FORWARD_PLUS_SUBTRACTIVE_LIGHT_CHECK

								Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
								#ifdef _LIGHT_LAYERS
								if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
								#endif
								{
									SUM_LIGHT_TRANSLUCENCY( light );
								}
							}
						#endif
						LIGHT_LOOP_BEGIN( pixelLightCount )
							Light light = GetAdditionalLight(lightIndex, inputData.positionWS, inputData.shadowMask);
							#ifdef _LIGHT_LAYERS
							if (IsMatchingLightLayer(light.layerMask, meshRenderingLayers))
							#endif
							{
								SUM_LIGHT_TRANSLUCENCY( light );
							}
						LIGHT_LOOP_END
					#endif
				}
				#endif

				#ifdef ASE_REFRACTION
					float4 projScreenPos = ScreenPos / ScreenPos.w;
					float3 refractionOffset = ( RefractionIndex - 1.0 ) * mul( UNITY_MATRIX_V, float4( WorldNormal,0 ) ).xyz * ( 1.0 - dot( WorldNormal, WorldViewDirection ) );
					projScreenPos.xy += refractionOffset.xy;
					float3 refraction = SHADERGRAPH_SAMPLE_SCENE_COLOR( projScreenPos.xy ) * RefractionColor;
					color.rgb = lerp( refraction, color.rgb, color.a );
					color.a = 1;
				#endif

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_FOG
					#ifdef TERRAIN_SPLAT_ADDPASS
						color.rgb = MixFogColor(color.rgb, half3(0,0,0), inputData.fogCoord);
					#else
						color.rgb = MixFog(color.rgb, inputData.fogCoord);
					#endif
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4( EncodeMeshRenderingLayer( renderingLayers ), 0, 0, 0 );
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			ZWrite On
			ZTest LEqual
			AlphaToMask Off
			ColorMask 0

			HLSLPROGRAM

			

			#pragma multi_compile _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			#pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_SHADOWCASTER

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 positionWS : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			float3 _LightDirection;
			float3 _LightPosition;

			PackedVaryings VertexFunction( Attributes input )
			{
				PackedVaryings output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				output.ase_texcoord3.xy = input.ase_texcoord.xy;
				output.ase_texcoord3.zw = input.ase_texcoord1.xy;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				float3 positionWS = TransformObjectToWorld( input.positionOS.xyz );
				float3 normalWS = TransformObjectToWorldDir(input.normalOS);

				#if _CASTING_PUNCTUAL_LIGHT_SHADOW
					float3 lightDirectionWS = normalize(_LightPosition - positionWS);
				#else
					float3 lightDirectionWS = _LightDirection;
				#endif

				float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));

				#if UNITY_REVERSED_Z
					positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#else
					positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = positionCS;
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				output.positionCS = positionCS;
				output.clipPosV = positionCS;
				output.positionWS = positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(	PackedVaryings input
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				float3 WorldPosition = input.positionWS;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = input.clipPosV;
				float4 ScreenPos = ComputeScreenPos( input.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = input.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_OffsetTex = input.ase_texcoord3.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord3.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord3.zw * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord3.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord3.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord3.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 ase_positionSSNorm = ScreenPos / ScreenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));
				float AlphaClipThresholdShadow = 0.5;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					#ifdef _ALPHATEST_SHADOW_ON
						clip(Alpha - AlphaClipThresholdShadow);
					#else
						clip(Alpha - AlphaClipThreshold);
					#endif
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			ZWrite On
			ColorMask R
			AlphaToMask Off

			HLSLPROGRAM

			

			#pragma multi_compile _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_DEPTHONLY

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 positionWS : TEXCOORD1;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD2;
				#endif
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				output.ase_texcoord3.xy = input.ase_texcoord.xy;
				output.ase_texcoord3.zw = input.ase_texcoord1.xy;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				output.positionCS = vertexInput.positionCS;
				output.clipPosV = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(	PackedVaryings input
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						 ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				float3 WorldPosition = input.positionWS;
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = input.clipPosV;
				float4 ScreenPos = ComputeScreenPos( input.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = input.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_OffsetTex = input.ase_texcoord3.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord3.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord3.zw * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord3.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord3.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord3.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 ase_positionSSNorm = ScreenPos / ScreenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return 0;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#pragma multi_compile_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011

			#pragma shader_feature EDITOR_VISUALIZATION

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_META

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature _ALBEDOOFF_ON
			#pragma shader_feature _EMISSIONSWITCH_ON


			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				#ifdef EDITOR_VISUALIZATION
					float4 VizUV : TEXCOORD2;
					float4 LightCoord : TEXCOORD3;
				#endif
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			samplerCUBE _CubeMapTex;
			sampler2D _NormalTex;
			sampler2D _MainTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.texcoord0.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.texcoord0.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.texcoord0.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				float3 ase_tangentWS = TransformObjectToWorldDir( input.ase_tangent.xyz );
				output.ase_texcoord6.xyz = ase_tangentWS;
				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord7.xyz = ase_normalWS;
				float ase_tangentSign = input.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				output.ase_texcoord8.xyz = ase_bitangentWS;
				
				float4 ase_positionCS = TransformObjectToHClip( ( input.positionOS ).xyz );
				float4 screenPos = ComputeScreenPos( ase_positionCS );
				output.ase_texcoord9 = screenPos;
				
				output.ase_texcoord4.xyz = input.texcoord0.xyz;
				output.ase_texcoord5.xy = input.texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord4.w = 0;
				output.ase_texcoord5.zw = 0;
				output.ase_texcoord6.w = 0;
				output.ase_texcoord7.w = 0;
				output.ase_texcoord8.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				float3 positionWS = TransformObjectToWorld( input.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					output.positionWS = positionWS;
				#endif

				output.positionCS = MetaVertexPosition( input.positionOS, input.texcoord1.xy, input.texcoord1.xy, unity_LightmapST, unity_DynamicLightmapST );

				#ifdef EDITOR_VISUALIZATION
					float2 VizUV = 0;
					float4 LightCoord = 0;
					UnityEditorVizData(input.positionOS.xyz, input.texcoord0.xy, input.texcoord1.xy, input.texcoord2.xy, VizUV, LightCoord);
					output.VizUV = float4(VizUV, 0, 0);
					output.LightCoord = LightCoord;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					VertexPositionInputs vertexInput = (VertexPositionInputs)0;
					vertexInput.positionWS = positionWS;
					vertexInput.positionCS = output.positionCS;
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 texcoord0 : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.texcoord0 = input.texcoord0;
				output.texcoord1 = input.texcoord1;
				output.texcoord2 = input.texcoord2;
				output.ase_tangent = input.ase_tangent;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.texcoord0 = patch[0].texcoord0 * bary.x + patch[1].texcoord0 * bary.y + patch[2].texcoord0 * bary.z;
				output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				output.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = input.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = input.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_NormalTex = input.ase_texcoord4.xyz.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
				float2 appendResult66 = (float2(( _NormalTexU * _TimeParameters.x ) , ( _TimeParameters.x * _NormalTexV )));
				float2 temp_output_68_0 = ( uv_NormalTex + appendResult66 );
				float2 uv_DistortionTex = input.ase_texcoord4.xyz.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord5.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult71 = lerp( float3( temp_output_68_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float3 unpack74 = UnpackNormalScale( tex2D( _NormalTex, (( _NormalTexDistortionUV )?( lerpResult71 ):( half3( temp_output_68_0 ,  0.0 ) )).xy ), _NormalIntensity );
				unpack74.z = lerp( 1, unpack74.z, saturate(_NormalIntensity) );
				float3 tex2DNode74 = unpack74;
				float3 ase_tangentWS = input.ase_texcoord6.xyz;
				float3 ase_normalWS = input.ase_texcoord7.xyz;
				float3 ase_bitangentWS = input.ase_texcoord8.xyz;
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 worldRefl37 = normalize( reflect( -ase_viewDirWS, float3( dot( tanToWorld0, tex2DNode74 ), dot( tanToWorld1, tex2DNode74 ), dot( tanToWorld2, tex2DNode74 ) ) ) );
				float2 uv_MainTex = input.ase_texcoord4.xyz.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 appendResult55 = (float2(( _MainTexU * _TimeParameters.x ) , ( _TimeParameters.x * _MainTexV )));
				float4 temp_output_48_0 = ( ( ( _CubeMapIntensity * texCUBE( _CubeMapTex, worldRefl37 ) ) + ( _MainColor * tex2D( _MainTex, ( uv_MainTex + appendResult55 ) ) ) ) * _AllColor );
				#ifdef _ALBEDOOFF_ON
				float4 staticSwitch59 = float4( 0,0,0,0 );
				#else
				float4 staticSwitch59 = temp_output_48_0;
				#endif
				
				#ifdef _EMISSIONSWITCH_ON
				float4 staticSwitch58 = temp_output_48_0;
				#else
				float4 staticSwitch58 = float4( 0,0,0,0 );
				#endif
				
				float2 uv_OffsetTex = input.ase_texcoord4.xyz.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord4.xyz.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord4.xyz.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord4.xyz.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 screenPos = input.ase_texcoord9;
				float4 ase_positionSSNorm = screenPos / screenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float3 BaseColor = staticSwitch59.rgb;
				float3 Emission = staticSwitch58.rgb;
				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				MetaInput metaInput = (MetaInput)0;
				metaInput.Albedo = BaseColor;
				metaInput.Emission = Emission;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = input.VizUV.xy;
					metaInput.LightCoord = input.LightCoord;
				#endif

				return UnityMetaFragment(metaInput);
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Universal2D"
			Tags { "LightMode"="Universal2D" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA

			HLSLPROGRAM

			#pragma multi_compile_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_2D

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#pragma shader_feature _ALBEDOOFF_ON


			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 positionWS : TEXCOORD0;
				#endif
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			samplerCUBE _CubeMapTex;
			sampler2D _NormalTex;
			sampler2D _MainTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_TRANSFER_INSTANCE_ID( input, output );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( output );

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				float3 ase_tangentWS = TransformObjectToWorldDir( input.ase_tangent.xyz );
				output.ase_texcoord4.xyz = ase_tangentWS;
				float3 ase_normalWS = TransformObjectToWorldNormal( input.normalOS );
				output.ase_texcoord5.xyz = ase_normalWS;
				float ase_tangentSign = input.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				output.ase_texcoord6.xyz = ase_bitangentWS;
				
				float4 ase_positionCS = TransformObjectToHClip( ( input.positionOS ).xyz );
				float4 screenPos = ComputeScreenPos( ase_positionCS );
				output.ase_texcoord7 = screenPos;
				
				output.ase_texcoord2.xyz = input.ase_texcoord.xyz;
				output.ase_texcoord3.xy = input.ase_texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord2.w = 0;
				output.ase_texcoord3.zw = 0;
				output.ase_texcoord4.w = 0;
				output.ase_texcoord5.w = 0;
				output.ase_texcoord6.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					output.positionWS = vertexInput.positionWS;
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				output.positionCS = vertexInput.positionCS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_tangent : TANGENT;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				output.ase_tangent = input.ase_tangent;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				output.ase_tangent = patch[0].ase_tangent * bary.x + patch[1].ase_tangent * bary.y + patch[2].ase_tangent * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( input );
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				#if defined(ASE_NEEDS_FRAG_WORLD_POSITION)
					float3 WorldPosition = input.positionWS;
				#endif

				float4 ShadowCoords = float4( 0, 0, 0, 0 );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = input.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_NormalTex = input.ase_texcoord2.xyz.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
				float2 appendResult66 = (float2(( _NormalTexU * _TimeParameters.x ) , ( _TimeParameters.x * _NormalTexV )));
				float2 temp_output_68_0 = ( uv_NormalTex + appendResult66 );
				float2 uv_DistortionTex = input.ase_texcoord2.xyz.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord3.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult71 = lerp( float3( temp_output_68_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float3 unpack74 = UnpackNormalScale( tex2D( _NormalTex, (( _NormalTexDistortionUV )?( lerpResult71 ):( half3( temp_output_68_0 ,  0.0 ) )).xy ), _NormalIntensity );
				unpack74.z = lerp( 1, unpack74.z, saturate(_NormalIntensity) );
				float3 tex2DNode74 = unpack74;
				float3 ase_tangentWS = input.ase_texcoord4.xyz;
				float3 ase_normalWS = input.ase_texcoord5.xyz;
				float3 ase_bitangentWS = input.ase_texcoord6.xyz;
				float3 tanToWorld0 = float3( ase_tangentWS.x, ase_bitangentWS.x, ase_normalWS.x );
				float3 tanToWorld1 = float3( ase_tangentWS.y, ase_bitangentWS.y, ase_normalWS.y );
				float3 tanToWorld2 = float3( ase_tangentWS.z, ase_bitangentWS.z, ase_normalWS.z );
				float3 ase_viewVectorWS = ( _WorldSpaceCameraPos.xyz - WorldPosition );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 worldRefl37 = normalize( reflect( -ase_viewDirWS, float3( dot( tanToWorld0, tex2DNode74 ), dot( tanToWorld1, tex2DNode74 ), dot( tanToWorld2, tex2DNode74 ) ) ) );
				float2 uv_MainTex = input.ase_texcoord2.xyz.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 appendResult55 = (float2(( _MainTexU * _TimeParameters.x ) , ( _TimeParameters.x * _MainTexV )));
				float4 temp_output_48_0 = ( ( ( _CubeMapIntensity * texCUBE( _CubeMapTex, worldRefl37 ) ) + ( _MainColor * tex2D( _MainTex, ( uv_MainTex + appendResult55 ) ) ) ) * _AllColor );
				#ifdef _ALBEDOOFF_ON
				float4 staticSwitch59 = float4( 0,0,0,0 );
				#else
				float4 staticSwitch59 = temp_output_48_0;
				#endif
				
				float2 uv_OffsetTex = input.ase_texcoord2.xyz.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord2.xyz.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord2.xyz.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord2.xyz.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 screenPos = input.ase_texcoord7;
				float4 ase_positionSSNorm = screenPos / screenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float3 BaseColor = staticSwitch59.rgb;
				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));

				half4 color = half4(BaseColor, Alpha );

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				return color;
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "LightMode"="DepthNormals" }

			ZWrite On
			Blend One Zero
			ZTest LEqual
			ZWrite On

			HLSLPROGRAM

			

			

			#pragma multi_compile _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma multi_compile_instancing
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_DEPTHNORMALSONLY
			//#define SHADERPASS SHADERPASS_DEPTHNORMALS

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_SCREEN_POSITION


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float3 positionWS : TEXCOORD1;
				float3 normalWS : TEXCOORD2;
				float4 tangentWS : TEXCOORD3;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					float4 shadowCoord : TEXCOORD4;
				#endif
				float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			sampler2D _NormalTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				output.ase_texcoord5.xy = input.ase_texcoord.xy;
				output.ase_texcoord5.zw = input.ase_texcoord1.xy;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );

				float3 normalWS = TransformObjectToWorldNormal( input.normalOS );
				float4 tangentWS = float4( TransformObjectToWorldDir( input.tangentOS.xyz ), input.tangentOS.w );

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR) && defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				output.positionCS = vertexInput.positionCS;
				output.clipPosV = vertexInput.positionCS;
				output.positionWS = vertexInput.positionWS;
				output.normalWS = normalWS;
				output.tangentWS = tangentWS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			void frag(	PackedVaryings input
						, out half4 outNormalWS : SV_Target0
						#ifdef ASE_DEPTH_WRITE_ON
						,out float outputDepth : ASE_SV_DEPTH
						#endif
						#ifdef _WRITE_RENDERING_LAYERS
						, out float4 outRenderingLayers : SV_Target1
						#endif
						 )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( input );

				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float3 WorldNormal = input.normalWS;
				float4 WorldTangent = input.tangentWS;
				float3 WorldPosition = input.positionWS;
				float4 ClipPos = input.clipPosV;
				float4 ScreenPos = ComputeScreenPos( input.clipPosV );

				#if defined(ASE_NEEDS_FRAG_SHADOWCOORDS)
					#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
						ShadowCoords = input.shadowCoord;
					#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
						ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
					#endif
				#endif

				float2 uv_NormalTex = input.ase_texcoord5.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
				float2 appendResult66 = (float2(( _NormalTexU * _TimeParameters.x ) , ( _TimeParameters.x * _NormalTexV )));
				float2 temp_output_68_0 = ( uv_NormalTex + appendResult66 );
				float2 uv_DistortionTex = input.ase_texcoord5.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord5.zw * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult71 = lerp( float3( temp_output_68_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float3 unpack74 = UnpackNormalScale( tex2D( _NormalTex, (( _NormalTexDistortionUV )?( lerpResult71 ):( half3( temp_output_68_0 ,  0.0 ) )).xy ), _NormalIntensity );
				unpack74.z = lerp( 1, unpack74.z, saturate(_NormalIntensity) );
				float3 tex2DNode74 = unpack74;
				
				float2 uv_OffsetTex = input.ase_texcoord5.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord5.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord5.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord5.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 ase_positionSSNorm = ScreenPos / ScreenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float3 Normal = tex2DNode74;
				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				#if defined(_GBUFFER_NORMALS_OCT)
					float2 octNormalWS = PackNormalOctQuadEncode(WorldNormal);
					float2 remappedOctNormalWS = saturate(octNormalWS * 0.5 + 0.5);
					half3 packedNormalWS = PackFloat2To888(remappedOctNormalWS);
					outNormalWS = half4(packedNormalWS, 0.0);
				#else
					#if defined(_NORMALMAP)
						#if _NORMAL_DROPOFF_TS
							float crossSign = (WorldTangent.w > 0.0 ? 1.0 : -1.0) * GetOddNegativeScale();
							float3 bitangent = crossSign * cross(WorldNormal.xyz, WorldTangent.xyz);
							float3 normalWS = TransformTangentToWorld(Normal, half3x3(WorldTangent.xyz, bitangent, WorldNormal.xyz));
						#elif _NORMAL_DROPOFF_OS
							float3 normalWS = TransformObjectToWorldNormal(Normal);
						#elif _NORMAL_DROPOFF_WS
							float3 normalWS = Normal;
						#endif
					#else
						float3 normalWS = WorldNormal;
					#endif
					outNormalWS = half4(NormalizeNormalPerPixel(normalWS), 0.0);
				#endif

				#ifdef _WRITE_RENDERING_LAYERS
					uint renderingLayers = GetMeshRenderingLayer();
					outRenderingLayers = float4(EncodeMeshRenderingLayer(renderingLayers), 0, 0, 0);
				#endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="UniversalGBuffer" }

			Blend One Zero, One Zero
			ZWrite On
			ZTest LEqual
			Offset 0 , 0
			ColorMask RGBA
			

			HLSLPROGRAM

			

			#pragma multi_compile_fragment _ALPHATEST_ON
			#define _NORMAL_DROPOFF_TS 1
			#pragma shader_feature_local _RECEIVE_SHADOWS_OFF
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#pragma multi_compile_fragment _ LOD_FADE_CROSSFADE
			#pragma multi_compile_fog
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			#pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
			#pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION

			

			
			#pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
           

			#pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
			#pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
			#pragma multi_compile_fragment _ _RENDER_PASS_ENABLED

			

			#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			#pragma multi_compile _ DIRLIGHTMAP_COMBINED
			#pragma multi_compile _ LIGHTMAP_ON
			#pragma multi_compile _ DYNAMICLIGHTMAP_ON

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SHADERPASS SHADERPASS_GBUFFER

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			
			#if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#if defined(LOD_FADE_CROSSFADE)
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
            #endif

			#if defined(UNITY_INSTANCING_ENABLED) && defined(_TERRAIN_INSTANCED_PERPIXEL_NORMAL)
				#define ENABLE_TERRAIN_PERPIXEL_NORMAL
			#endif

			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_TANGENT
			#define ASE_NEEDS_FRAG_WORLD_NORMAL
			#define ASE_NEEDS_FRAG_WORLD_BITANGENT
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_SCREEN_POSITION
			#pragma shader_feature _ALBEDOOFF_ON
			#pragma shader_feature _EMISSIONSWITCH_ON


			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE) && (SHADER_TARGET >= 45)
				#define ASE_SV_DEPTH SV_DepthLessEqual
				#define ASE_SV_POSITION_QUALIFIERS linear noperspective centroid
			#else
				#define ASE_SV_DEPTH SV_Depth
				#define ASE_SV_POSITION_QUALIFIERS
			#endif

			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				ASE_SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				float4 clipPosV : TEXCOORD0;
				float4 lightmapUVOrVertexSH : TEXCOORD1;
				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					half4 fogFactorAndVertexLight : TEXCOORD2;
				#endif
				float4 tSpace0 : TEXCOORD3;
				float4 tSpace1 : TEXCOORD4;
				float4 tSpace2 : TEXCOORD5;
				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
				float4 shadowCoord : TEXCOORD6;
				#endif
				#if defined(DYNAMICLIGHTMAP_ON)
				float2 dynamicLightmapUV : TEXCOORD7;
				#endif
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			samplerCUBE _CubeMapTex;
			sampler2D _NormalTex;
			sampler2D _MainTex;
			sampler2D _SecTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"

			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			PackedVaryings VertexFunction( Attributes input  )
			{
				PackedVaryings output = (PackedVaryings)0;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				output.ase_texcoord8.xyz = input.texcoord.xyz;
				output.ase_texcoord9.xy = input.texcoord1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				output.ase_texcoord8.w = 0;
				output.ase_texcoord9.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;
				input.tangentOS = input.tangentOS;

				VertexPositionInputs vertexInput = GetVertexPositionInputs( input.positionOS.xyz );
				VertexNormalInputs normalInput = GetVertexNormalInputs( input.normalOS, input.tangentOS );

				output.tSpace0 = float4( normalInput.normalWS, vertexInput.positionWS.x);
				output.tSpace1 = float4( normalInput.tangentWS, vertexInput.positionWS.y);
				output.tSpace2 = float4( normalInput.bitangentWS, vertexInput.positionWS.z);

				#if defined(LIGHTMAP_ON)
					OUTPUT_LIGHTMAP_UV(input.texcoord1, unity_LightmapST, output.lightmapUVOrVertexSH.xy);
				#endif

				#if defined(DYNAMICLIGHTMAP_ON)
					output.dynamicLightmapUV.xy = input.texcoord2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
				#endif

				#if !defined(LIGHTMAP_ON)
					OUTPUT_SH(normalInput.normalWS.xyz, output.lightmapUVOrVertexSH.xyz);
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					output.lightmapUVOrVertexSH.zw = input.texcoord.xy;
					output.lightmapUVOrVertexSH.xy = input.texcoord.xy * unity_LightmapST.xy + unity_LightmapST.zw;
				#endif

				#if defined(ASE_FOG) || defined(_ADDITIONAL_LIGHTS_VERTEX)
					output.fogFactorAndVertexLight = 0;
					#if defined(ASE_FOG) && !defined(_FOG_FRAGMENT)
						// @diogo: no fog applied in GBuffer
					#endif
					#ifdef _ADDITIONAL_LIGHTS_VERTEX
						half3 vertexLight = VertexLighting( vertexInput.positionWS, normalInput.normalWS );
						output.fogFactorAndVertexLight.yzw = vertexLight;
					#endif
				#endif

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					output.shadowCoord = GetShadowCoord( vertexInput );
				#endif

				output.positionCS = vertexInput.positionCS;
				output.clipPosV = vertexInput.positionCS;
				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 texcoord : TEXCOORD0;
				float4 texcoord1 : TEXCOORD1;
				float4 texcoord2 : TEXCOORD2;
				
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.tangentOS = input.tangentOS;
				output.texcoord = input.texcoord;
				output.texcoord1 = input.texcoord1;
				output.texcoord2 = input.texcoord2;
				
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				output.texcoord = patch[0].texcoord * bary.x + patch[1].texcoord * bary.y + patch[2].texcoord * bary.z;
				output.texcoord1 = patch[0].texcoord1 * bary.x + patch[1].texcoord1 * bary.y + patch[2].texcoord1 * bary.z;
				output.texcoord2 = patch[0].texcoord2 * bary.x + patch[1].texcoord2 * bary.y + patch[2].texcoord2 * bary.z;
				
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			FragmentOutput frag ( PackedVaryings input
								#ifdef ASE_DEPTH_WRITE_ON
								,out float outputDepth : ASE_SV_DEPTH
								#endif
								 )
			{
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(input);

				#if defined(LOD_FADE_CROSSFADE)
					LODFadeCrossFade( input.positionCS );
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float2 sampleCoords = (input.lightmapUVOrVertexSH.zw / _TerrainHeightmapRecipSize.zw + 0.5f) * _TerrainHeightmapRecipSize.xy;
					float3 WorldNormal = TransformObjectToWorldNormal(normalize(SAMPLE_TEXTURE2D(_TerrainNormalmapTexture, sampler_TerrainNormalmapTexture, sampleCoords).rgb * 2 - 1));
					float3 WorldTangent = -cross(GetObjectToWorldMatrix()._13_23_33, WorldNormal);
					float3 WorldBiTangent = cross(WorldNormal, -WorldTangent);
				#else
					float3 WorldNormal = normalize( input.tSpace0.xyz );
					float3 WorldTangent = input.tSpace1.xyz;
					float3 WorldBiTangent = input.tSpace2.xyz;
				#endif

				float3 WorldPosition = float3(input.tSpace0.w,input.tSpace1.w,input.tSpace2.w);
				float3 WorldViewDirection = GetWorldSpaceNormalizeViewDir( WorldPosition );
				float4 ShadowCoords = float4( 0, 0, 0, 0 );
				float4 ClipPos = input.clipPosV;
				float4 ScreenPos = ComputeScreenPos( input.clipPosV );

				float2 NormalizedScreenSpaceUV = GetNormalizedScreenSpaceUV(input.positionCS);

				#if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
					ShadowCoords = input.shadowCoord;
				#elif defined(MAIN_LIGHT_CALCULATE_SHADOWS)
					ShadowCoords = TransformWorldToShadowCoord( WorldPosition );
				#else
					ShadowCoords = float4(0, 0, 0, 0);
				#endif

				float2 uv_NormalTex = input.ase_texcoord8.xyz.xy * _NormalTex_ST.xy + _NormalTex_ST.zw;
				float2 appendResult66 = (float2(( _NormalTexU * _TimeParameters.x ) , ( _TimeParameters.x * _NormalTexV )));
				float2 temp_output_68_0 = ( uv_NormalTex + appendResult66 );
				float2 uv_DistortionTex = input.ase_texcoord8.xyz.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord9.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult71 = lerp( float3( temp_output_68_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float3 unpack74 = UnpackNormalScale( tex2D( _NormalTex, (( _NormalTexDistortionUV )?( lerpResult71 ):( half3( temp_output_68_0 ,  0.0 ) )).xy ), _NormalIntensity );
				unpack74.z = lerp( 1, unpack74.z, saturate(_NormalIntensity) );
				float3 tex2DNode74 = unpack74;
				float3 tanToWorld0 = float3( WorldTangent.x, WorldBiTangent.x, WorldNormal.x );
				float3 tanToWorld1 = float3( WorldTangent.y, WorldBiTangent.y, WorldNormal.y );
				float3 tanToWorld2 = float3( WorldTangent.z, WorldBiTangent.z, WorldNormal.z );
				float3 worldRefl37 = normalize( reflect( -WorldViewDirection, float3( dot( tanToWorld0, tex2DNode74 ), dot( tanToWorld1, tex2DNode74 ), dot( tanToWorld2, tex2DNode74 ) ) ) );
				float2 uv_MainTex = input.ase_texcoord8.xyz.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float2 appendResult55 = (float2(( _MainTexU * _TimeParameters.x ) , ( _TimeParameters.x * _MainTexV )));
				float4 temp_output_48_0 = ( ( ( _CubeMapIntensity * texCUBE( _CubeMapTex, worldRefl37 ) ) + ( _MainColor * tex2D( _MainTex, ( uv_MainTex + appendResult55 ) ) ) ) * _AllColor );
				#ifdef _ALBEDOOFF_ON
				float4 staticSwitch59 = float4( 0,0,0,0 );
				#else
				float4 staticSwitch59 = temp_output_48_0;
				#endif
				
				#ifdef _EMISSIONSWITCH_ON
				float4 staticSwitch58 = temp_output_48_0;
				#else
				float4 staticSwitch58 = float4( 0,0,0,0 );
				#endif
				
				float2 uv_SecTex = input.ase_texcoord8.xyz.xy * _SecTex_ST.xy + _SecTex_ST.zw;
				float2 appendResult18 = (float2(( _SecTexU * _TimeParameters.x ) , ( _TimeParameters.x * _SecTexV )));
				float2 temp_output_19_0 = ( uv_SecTex + appendResult18 );
				float3 lerpResult143 = lerp( float3( temp_output_19_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float4 tex2DNode4 = tex2D( _SecTex, (( _SecTexDistortionUV )?( lerpResult143 ):( half3( temp_output_19_0 ,  0.0 ) )).xy );
				
				float2 uv_OffsetTex = input.ase_texcoord8.xyz.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord8.xyz.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord8.xyz.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord8.xyz.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 ase_positionSSNorm = ScreenPos / ScreenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				float3 BaseColor = staticSwitch59.rgb;
				float3 Normal = tex2DNode74;
				float3 Emission = staticSwitch58.rgb;
				float3 Specular = 0.5;
				float Metallic = ( tex2DNode4.b * _Metallic );
				float Smoothness = ( tex2DNode4.g * _Gloss );
				float Occlusion = ( tex2DNode4.r * _AO );
				float Alpha = 1;
				float AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));
				float AlphaClipThresholdShadow = 0.5;
				float3 BakedGI = 0;
				float3 RefractionColor = 1;
				float RefractionIndex = 1;
				float3 Transmission = 1;
				float3 Translucency = 1;

				#ifdef ASE_DEPTH_WRITE_ON
					float DepthValue = input.positionCS.z;
				#endif

				#ifdef _ALPHATEST_ON
					clip(Alpha - AlphaClipThreshold);
				#endif

				InputData inputData = (InputData)0;
				inputData.positionWS = WorldPosition;
				inputData.positionCS = input.positionCS;
				inputData.shadowCoord = ShadowCoords;

				#ifdef _NORMALMAP
					#if _NORMAL_DROPOFF_TS
						inputData.normalWS = TransformTangentToWorld(Normal, half3x3( WorldTangent, WorldBiTangent, WorldNormal ));
					#elif _NORMAL_DROPOFF_OS
						inputData.normalWS = TransformObjectToWorldNormal(Normal);
					#elif _NORMAL_DROPOFF_WS
						inputData.normalWS = Normal;
					#endif
				#else
					inputData.normalWS = WorldNormal;
				#endif

				inputData.normalWS = NormalizeNormalPerPixel(inputData.normalWS);
				inputData.viewDirectionWS = SafeNormalize( WorldViewDirection );

				#ifdef ASE_FOG
					// @diogo: no fog applied in GBuffer
				#endif
				#ifdef _ADDITIONAL_LIGHTS_VERTEX
					inputData.vertexLighting = input.fogFactorAndVertexLight.yzw;
				#endif

				#if defined(ENABLE_TERRAIN_PERPIXEL_NORMAL)
					float3 SH = SampleSH(inputData.normalWS.xyz);
				#else
					float3 SH = input.lightmapUVOrVertexSH.xyz;
				#endif

				#ifdef ASE_BAKEDGI
					inputData.bakedGI = BakedGI;
				#else
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.bakedGI = SAMPLE_GI( input.lightmapUVOrVertexSH.xy, input.dynamicLightmapUV.xy, SH, inputData.normalWS);
					#else
						inputData.bakedGI = SAMPLE_GI( input.lightmapUVOrVertexSH.xy, SH, inputData.normalWS );
					#endif
				#endif

				inputData.normalizedScreenSpaceUV = NormalizedScreenSpaceUV;
				inputData.shadowMask = SAMPLE_SHADOWMASK(input.lightmapUVOrVertexSH.xy);

				#if defined(DEBUG_DISPLAY)
					#if defined(DYNAMICLIGHTMAP_ON)
						inputData.dynamicLightmapUV = input.dynamicLightmapUV.xy;
						#endif
					#if defined(LIGHTMAP_ON)
						inputData.staticLightmapUV = input.lightmapUVOrVertexSH.xy;
					#else
						inputData.vertexSH = SH;
					#endif
				#endif

				#ifdef _DBUFFER
					ApplyDecal(input.positionCS,
						BaseColor,
						Specular,
						inputData.normalWS,
						Metallic,
						Occlusion,
						Smoothness);
				#endif

				BRDFData brdfData;
				InitializeBRDFData
				(BaseColor, Metallic, Specular, Smoothness, Alpha, brdfData);

				Light mainLight = GetMainLight(inputData.shadowCoord, inputData.positionWS, inputData.shadowMask);
				half4 color;
				MixRealtimeAndBakedGI(mainLight, inputData.normalWS, inputData.bakedGI, inputData.shadowMask);
				color.rgb = GlobalIllumination(brdfData, inputData.bakedGI, Occlusion, inputData.positionWS, inputData.normalWS, inputData.viewDirectionWS);
				color.a = Alpha;

				#ifdef ASE_FINAL_COLOR_ALPHA_MULTIPLY
					color.rgb *= color.a;
				#endif

				#ifdef ASE_DEPTH_WRITE_ON
					outputDepth = DepthValue;
				#endif

				return BRDFDataToGbuffer(brdfData, inputData, Smoothness, Emission + color.rgb, Occlusion);
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off
			AlphaToMask Off

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

			#define SCENESELECTIONPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction(Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				float4 ase_positionCS = TransformObjectToHClip( ( input.positionOS ).xyz );
				float4 screenPos = ComputeScreenPos( ase_positionCS );
				output.ase_texcoord1 = screenPos;
				
				output.ase_texcoord.xy = input.ase_texcoord.xy;
				output.ase_texcoord.zw = input.ase_texcoord1.xy;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				float3 positionWS = TransformObjectToWorld( input.positionOS.xyz );

				output.positionCS = TransformWorldToHClip(positionWS);

				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord.zw * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 screenPos = input.ase_texcoord1;
				float4 ase_positionSSNorm = screenPos / screenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				surfaceDescription.Alpha = 1;
				surfaceDescription.AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
					clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;

				#ifdef SCENESELECTIONPASS
					outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
					outColor = _SelectionID;
				#endif

				return outColor;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ScenePickingPass"
			Tags { "LightMode"="Picking" }

			AlphaToMask Off

			HLSLPROGRAM

			

			#define _NORMAL_DROPOFF_TS 1
			#define ASE_FOG 1
			#define _EMISSION
			#define _NORMALMAP 1
			#define ASE_VERSION 19801
			#define ASE_SRP_VERSION 140011


			

			#pragma vertex vert
			#pragma fragment frag

			#if defined(_SPECULAR_SETUP) && defined(_ASE_LIGHTING_SIMPLE)
				#define _SPECULAR_COLOR 1
			#endif

		    #define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"

			
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
           

			
            #if ASE_SRP_VERSION >=140009
			#include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"

			
            #if ASE_SRP_VERSION >=140007
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
			#endif
		

			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#define ASE_NEEDS_VERT_NORMAL


			struct Attributes
			{
				float4 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryings
			{
				float4 positionCS : SV_POSITION;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			CBUFFER_START(UnityPerMaterial)
			float4 _MainTex_ST;
			float4 _SecTex_ST;
			float4 _MainColor;
			float4 _NormalTex_ST;
			float4 _OffsetMaskTex_ST;
			float4 _OpacityMaskTex_ST;
			float4 _AllColor;
			float4 _DistortionTex_ST;
			float4 _AlphaTex1_ST;
			float4 _OffsetTex_ST;
			half _OffsetMaskTexFrequencyToOpacityMaskTex;
			float _OpacityMaskTexV;
			half _OpacityMaskTexSwitch;
			half _SecTexDistortionUV;
			half _DitherSwitch;
			float _AO;
			float _Gloss;
			float _Metallic;
			float _SecTexV;
			float _SecTexU;
			float _AlphaTex1U;
			float _OpacityMaskTexU;
			float _MaskAddBias;
			half _OffsetTexDistortionUV;
			float _MainTexU;
			float _OffsetTexU;
			float _OffsetTexV;
			half _Distortion2UV;
			float _DistortionU;
			float _DistortionV;
			float _DistortionIntensity;
			float _OffsetMaskTexU;
			float _OffsetMaskTexV;
			float _VertexOffsetIntensity;
			float _CubeMapIntensity;
			half _NormalTexDistortionUV;
			float _NormalTexU;
			float _NormalTexV;
			float _NormalIntensity;
			float _AlphaTex1V;
			float _MainTexV;
			float _DitherBias;
			#ifdef ASE_TRANSMISSION
				float _TransmissionShadow;
			#endif
			#ifdef ASE_TRANSLUCENCY
				float _TransStrength;
				float _TransNormal;
				float _TransScattering;
				float _TransDirect;
				float _TransAmbient;
				float _TransShadow;
			#endif
			#ifdef ASE_TESSELLATION
				float _TessPhongStrength;
				float _TessValue;
				float _TessMin;
				float _TessMax;
				float _TessEdgeLength;
				float _TessMaxDisp;
			#endif
			CBUFFER_END

			#ifdef SCENEPICKINGPASS
				float4 _SelectionID;
			#endif

			#ifdef SCENESELECTIONPASS
				int _ObjectId;
				int _PassValue;
			#endif

			sampler2D _OffsetTex;
			sampler2D _DistortionTex;
			sampler2D _OffsetMaskTex;
			sampler2D _OpacityMaskTex;
			sampler2D _AlphaTex1;


			float4 ASEScreenPositionNormalizedToPixel( float4 screenPosNorm )
			{
				float4 screenPosPixel = screenPosNorm * float4( _ScreenParams.xy, 1, 1 );
				#if UNITY_UV_STARTS_AT_TOP
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x < 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#else
					screenPosPixel.xy = float2( screenPosPixel.x, ( _ProjectionParams.x > 0 ) ? _ScreenParams.y - screenPosPixel.y : screenPosPixel.y );
				#endif
				return screenPosPixel;
			}
			
			inline float Dither4x4Bayer( int x, int y )
			{
				const float dither[ 16 ] = {
				     1,  9,  3, 11,
				    13,  5, 15,  7,
				     4, 12,  2, 10,
				    16,  8, 14,  6 };
				int r = y * 4 + x;
				return dither[ r ] / 16; // same # of instructions as pre-dividing due to compiler magic
			}
			

			struct SurfaceDescription
			{
				float Alpha;
				float AlphaClipThreshold;
			};

			PackedVaryings VertexFunction(Attributes input  )
			{
				PackedVaryings output;
				ZERO_INITIALIZE(PackedVaryings, output);

				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(output);

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord1.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2Dlod( _DistortionTex, float4( ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ), 0, 0.0) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2Dlod( _OffsetTex, float4( (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy, 0, 0.0) ) * tex2Dlod( _OffsetMaskTex, float4( ( uv_OffsetMaskTex + appendResult99 ), 0, 0.0) ) );
				
				float4 ase_positionCS = TransformObjectToHClip( ( input.positionOS ).xyz );
				float4 screenPos = ComputeScreenPos( ase_positionCS );
				output.ase_texcoord1 = screenPos;
				
				output.ase_texcoord.xy = input.ase_texcoord.xy;
				output.ase_texcoord.zw = input.ase_texcoord1.xy;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif

				float3 vertexValue = ( temp_output_116_0 * float4( input.normalOS , 0.0 ) * _VertexOffsetIntensity ).rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif

				input.normalOS = input.normalOS;

				float3 positionWS = TransformObjectToWorld( input.positionOS.xyz );
				output.positionCS = TransformWorldToHClip(positionWS);

				return output;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float4 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl vert ( Attributes input )
			{
				VertexControl output;
				UNITY_SETUP_INSTANCE_ID(input);
				UNITY_TRANSFER_INSTANCE_ID(input, output);
				output.positionOS = input.positionOS;
				output.normalOS = input.normalOS;
				output.ase_texcoord = input.ase_texcoord;
				output.ase_texcoord1 = input.ase_texcoord1;
				return output;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> input)
			{
				TessellationFactors output;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), _WorldSpaceCameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(input[0].positionOS, input[1].positionOS, input[2].positionOS, edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), _WorldSpaceCameraPos, _ScreenParams, unity_CameraWorldClipPlanes );
				#endif
				output.edge[0] = tf.x; output.edge[1] = tf.y; output.edge[2] = tf.z; output.inside = tf.w;
				return output;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
				return patch[id];
			}

			[domain("tri")]
			PackedVaryings DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				Attributes output = (Attributes) 0;
				output.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				output.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				output.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				output.ase_texcoord1 = patch[0].ase_texcoord1 * bary.x + patch[1].ase_texcoord1 * bary.y + patch[2].ase_texcoord1 * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = output.positionOS.xyz - patch[i].normalOS * (dot(output.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				output.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * output.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], output);
				return VertexFunction(output);
			}
			#else
			PackedVaryings vert ( Attributes input )
			{
				return VertexFunction( input );
			}
			#endif

			half4 frag(PackedVaryings input ) : SV_Target
			{
				SurfaceDescription surfaceDescription = (SurfaceDescription)0;

				float2 uv_OffsetTex = input.ase_texcoord.xy * _OffsetTex_ST.xy + _OffsetTex_ST.zw;
				float2 appendResult88 = (float2(( _OffsetTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetTexV )));
				float2 temp_output_96_0 = ( uv_OffsetTex + appendResult88 );
				float2 uv_DistortionTex = input.ase_texcoord.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 uv2_DistortionTex = input.ase_texcoord.zw * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
				float2 appendResult25 = (float2(_DistortionU , _DistortionV));
				float3 desaturateInitialColor32 = tex2D( _DistortionTex, ( (( _Distortion2UV )?( uv2_DistortionTex ):( uv_DistortionTex )) + ( appendResult25 * _TimeParameters.x ) ) ).rgb;
				float desaturateDot32 = dot( desaturateInitialColor32, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar32 = lerp( desaturateInitialColor32, desaturateDot32.xxx, 1.0 );
				half3 DistortionUV34 = desaturateVar32;
				half DistortionIndeisty35 = _DistortionIntensity;
				float3 lerpResult103 = lerp( float3( temp_output_96_0 ,  0.0 ) , DistortionUV34 , DistortionIndeisty35);
				float2 uv_OffsetMaskTex = input.ase_texcoord.xy * _OffsetMaskTex_ST.xy + _OffsetMaskTex_ST.zw;
				float2 appendResult99 = (float2(( _OffsetMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OffsetMaskTexV )));
				float4 temp_output_116_0 = ( tex2D( _OffsetTex, (( _OffsetTexDistortionUV )?( lerpResult103 ):( half3( temp_output_96_0 ,  0.0 ) )).xy ) * tex2D( _OffsetMaskTex, ( uv_OffsetMaskTex + appendResult99 ) ) );
				float3 desaturateInitialColor136 = temp_output_116_0.rgb;
				float desaturateDot136 = dot( desaturateInitialColor136, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar136 = lerp( desaturateInitialColor136, desaturateDot136.xxx, 1.0 );
				float2 uv_OpacityMaskTex = input.ase_texcoord.xy * _OpacityMaskTex_ST.xy + _OpacityMaskTex_ST.zw;
				float2 appendResult100 = (float2(( _OpacityMaskTexU * _TimeParameters.x ) , ( _TimeParameters.x * _OpacityMaskTexV )));
				float3 desaturateInitialColor118 = tex2D( _OpacityMaskTex, (( _OffsetMaskTexFrequencyToOpacityMaskTex )?( ( appendResult99 + uv_OpacityMaskTex ) ):( ( uv_OpacityMaskTex + appendResult100 ) )) ).rgb;
				float desaturateDot118 = dot( desaturateInitialColor118, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar118 = lerp( desaturateInitialColor118, desaturateDot118.xxx, 1.0 );
				float2 uv_AlphaTex1 = input.ase_texcoord.xy * _AlphaTex1_ST.xy + _AlphaTex1_ST.zw;
				float2 appendResult113 = (float2(( _AlphaTex1U * _TimeParameters.x ) , ( _TimeParameters.x * _AlphaTex1V )));
				float3 desaturateInitialColor120 = tex2D( _AlphaTex1, ( uv_AlphaTex1 + appendResult113 ) ).rgb;
				float desaturateDot120 = dot( desaturateInitialColor120, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar120 = lerp( desaturateInitialColor120, desaturateDot120.xxx, 1.0 );
				float clampResult141 = clamp( ( _MaskAddBias + ( (( _OpacityMaskTexSwitch )?( (desaturateVar118).x ):( (desaturateVar136).x )) * (desaturateVar120).x ) ) , 0.0 , 1.0 );
				float temp_output_128_0 = (0.0 + (clampResult141 - 0.0) * (2.0 - 0.0) / (1.0 - 0.0));
				float4 screenPos = input.ase_texcoord1;
				float4 ase_positionSSNorm = screenPos / screenPos.w;
				ase_positionSSNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_positionSSNorm.z : ase_positionSSNorm.z * 0.5 + 0.5;
				float4 ase_positionSS_Pixel = ASEScreenPositionNormalizedToPixel( ase_positionSSNorm );
				float dither131 = Dither4x4Bayer( fmod( ase_positionSS_Pixel.x, 4 ), fmod( ase_positionSS_Pixel.y, 4 ) );
				dither131 = step( dither131, saturate( ( temp_output_128_0 + _DitherBias ) * 1.00001 ) );
				

				surfaceDescription.Alpha = 1;
				surfaceDescription.AlphaClipThreshold = (( _DitherSwitch )?( dither131 ):( temp_output_128_0 ));

				#if _ALPHATEST_ON
					float alphaClipThreshold = 0.01f;
					#if ALPHA_CLIP_THRESHOLD
						alphaClipThreshold = surfaceDescription.AlphaClipThreshold;
					#endif
						clip(surfaceDescription.Alpha - alphaClipThreshold);
				#endif

				half4 outColor = 0;

				#ifdef SCENESELECTIONPASS
					outColor = half4(_ObjectId, _PassValue, 1.0, 1.0);
				#elif defined(SCENEPICKINGPASS)
					outColor = _SelectionID;
				#endif

				return outColor;
			}

			ENDHLSL
		}
		
	}
	
	CustomEditor "UnityEditor.ShaderGraphLitGUI"
	FallBack "Hidden/Shader Graph/FallbackError"
	
	Fallback Off
}
/*ASEBEGIN
Version=19801
Node;AmplifyShaderEditor.CommentaryNode;20;-5817.467,-1463.062;Inherit;False;1207;533.7722;UV扭曲贴图;11;32;31;30;29;27;26;25;24;23;22;159;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-5746.467,-1166.062;Float;False;Property;_DistortionU;DistortionU;38;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-5746.467,-1086.062;Float;False;Property;_DistortionV;DistortionV;39;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-5764.631,-1295.391;Inherit;False;0;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;24;-5767.467,-1413.062;Inherit;False;1;31;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;26;-5596.001,-1039.957;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;25;-5570.467,-1150.062;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ToggleSwitchNode;159;-5506.039,-1352.018;Half;False;Property;_Distortion2UV;Distortion2UV;41;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-5410.467,-1150.062;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;75;-3416.452,-438.9502;Inherit;False;695.9;444.1667;贴图流动;8;96;88;85;82;79;78;77;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;30;-5258.467,-1207.062;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;31;-5106.468,-1246.062;Inherit;True;Property;_DistortionTex;DistortionTex;37;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.CommentaryNode;21;-4923.149,-1641.517;Inherit;False;312.6667;165.6667;UV扭曲强度;1;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-3338.454,-110.4501;Float;False;Property;_OffsetTexV;OffsetTexV;21;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;77;-3341.454,-262.4501;Float;False;Property;_OffsetTexU;OffsetTexU;20;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;76;-3366.454,-178.4501;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;82;-3177.452,-259.4501;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;79;-3176.452,-161.4501;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;80;-3450.488,16.89719;Inherit;False;730.9009;442.1664;贴图流动;8;110;102;99;92;91;89;87;86;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-4873.149,-1592.574;Float;False;Property;_DistortionIntensity;DistortionIntensity;40;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;81;-3453.267,475.143;Inherit;False;730.9009;442.1664;贴图流动;8;109;101;100;98;94;90;84;83;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DesaturateOpNode;32;-4818.466,-1239.062;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;86;-3365.488,277.396;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-3397.488,343.3958;Float;False;Property;_OffsetMaskTexV;OffsetMaskTexV;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;84;-3403.267,649.6441;Float;False;Property;_OpacityMaskTexU;OpacityMaskTexU;28;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;83;-3400.267,801.6432;Float;False;Property;_OpacityMaskTexV;OpacityMaskTexV;29;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;85;-3269.352,-388.9502;Inherit;False;0;112;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;88;-3016.153,-227.5502;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;87;-3400.488,191.397;Float;False;Property;_OffsetMaskTexU;OffsetMaskTexU;24;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;35;-4587.308,-1589.817;Half;False;DistortionIndeisty;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;34;-4568.35,-1245.851;Half;False;DistortionUV;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleTimeNode;90;-3368.267,735.6431;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;96;-2876.553,-275.2502;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;93;-2703.314,-19.29763;Inherit;False;35;DistortionIndeisty;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-3179.267,654.6441;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-3178.267,752.6431;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-3175.488,294.396;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;97;-3447.309,932.4252;Inherit;False;730.9009;442.1664;贴图流动;8;115;114;113;111;107;106;105;104;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;95;-2677.76,-91.45352;Inherit;False;34;DistortionUV;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;92;-3176.488,196.397;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;101;-3271.168,525.143;Inherit;False;0;138;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;103;-2487.326,-142.3384;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-3394.309,1258.928;Float;False;Property;_AlphaTex1V;AlphaTex1V;36;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-3397.309,1106.925;Float;False;Property;_AlphaTex1U;AlphaTex1U;35;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;99;-3015.187,228.296;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;102;-3268.387,66.89719;Inherit;False;0;133;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;104;-3362.309,1192.928;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;100;-3017.968,686.5432;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;134;-2602.688,453.096;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;107;-3173.309,1111.926;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;111;-3172.309,1209.928;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;153;-2337.742,-198.9007;Half;False;Property;_OffsetTexDistortionUV;OffsetTexDistortionUV;44;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;-2878.367,638.8441;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;110;-2875.588,180.5972;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;114;-3265.21,982.4254;Inherit;False;0;117;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;112;-2102.668,-228.976;Inherit;True;Property;_OffsetTex;OffsetTex;19;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;133;-2646.929,157.9551;Inherit;True;Property;_OffsetMaskTex;OffsetMaskTex;23;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ToggleSwitchNode;147;-2452.781,481.9211;Half;False;Property;_OffsetMaskTexFrequencyToOpacityMaskTex;OffsetMaskTexFrequencyToOpacityMaskTex;30;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;113;-3012.01,1143.826;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;116;-1796.689,-101.6032;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;115;-2877.61,992.1243;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;138;-2150.536,458.7066;Inherit;True;Property;_OpacityMaskTex;OpacityMaskTex;27;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.DesaturateOpNode;118;-1837.224,463.7951;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DesaturateOpNode;136;-1587.279,2.204672;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;117;-2656.558,959.2703;Inherit;True;Property;_AlphaTex1;AlphaTex1;34;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ComponentMaskNode;119;-1663.35,462.3652;Inherit;True;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DesaturateOpNode;120;-2365.469,962.8633;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;135;-1389.267,31.81093;Inherit;True;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;122;-2194.594,957.4332;Inherit;True;True;False;False;True;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;152;-1132.488,273.386;Half;False;Property;_OpacityMaskTexSwitch;OpacityMaskTexSwitch;26;0;Create;True;0;0;0;False;0;False;1;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;121;-703.012,201.6739;Inherit;False;718.0901;261.9537;Mask阈值加强;4;141;140;139;128;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-852.4344,280.8999;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;139;-653.0117,251.6738;Float;False;Property;_MaskAddBias;MaskAddBias;33;0;Create;True;0;0;0;False;0;False;-0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;140;-463.5852,256.8763;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;141;-346.4585,257.6785;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;125;67.79946,348.8331;Inherit;False;579.7141;189.3333;抖动控制;3;131;130;129;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;129;80.09978,423.9059;Float;False;Property;_DitherBias;DitherBias;32;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;128;-200.9225,258.2939;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;130;267.6003,402.4529;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;155;-1705.542,-1087.37;Inherit;False;514.3335;694.1713;Comment;3;3;2;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;60;-3623.824,-1978.076;Inherit;False;695.9;444.1667;贴图流动;8;68;67;66;65;64;63;62;61;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;49;-2449.72,-1428.517;Inherit;False;695.9;444.1667;贴图流动;8;57;56;55;54;53;52;51;50;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;11;-3515.446,-912.4743;Inherit;False;695.9;444.1667;贴图流动;8;19;18;17;16;15;14;13;12;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;36;-1977.835,-1918.262;Inherit;False;692.9723;355.0887;CubeMap;4;43;42;41;37;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;38;-1735.056,-1560.01;Inherit;False;455.9125;260.3333;贴图颜色叠加;2;44;40;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;154;-2788.969,-909.1312;Inherit;False;1048.899;490.2294;Comment;5;143;148;144;145;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DitheringNode;131;404.1789,385.5333;Inherit;False;0;False;4;0;FLOAT;0;False;1;SAMPLER2D;;False;2;FLOAT4;0,0,0,0;False;3;SAMPLERSTATE;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;45;-1087.871,-1700.57;Inherit;False;474.3093;260.3334;总颜色叠加;2;48;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1;-1655.542,-804.1986;Inherit;False;414.3335;210.6666;粗糙度;2;8;6;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;2;-1653.9,-1037.37;Inherit;False;409.3331;225.6667;AO;2;9;5;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;3;-1654.542,-586.1987;Inherit;False;413.3335;192.6667;金属度;2;10;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.NormalVertexDataNode;142;-1564.578,-226.7854;Inherit;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;126;-1598.951,-88.06525;Float;False;Property;_VertexOffsetIntensity;VertexOffsetIntensity;22;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-3548.824,-1801.576;Float;False;Property;_NormalTexU;NormalTexU;11;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;61;-3545.824,-1649.576;Float;False;Property;_NormalTexV;NormalTexV;12;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;62;-3573.824,-1717.575;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;64;-3383.824,-1700.576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-3384.824,-1798.576;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;67;-3476.724,-1928.076;Inherit;False;0;74;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;66;-3223.525,-1766.676;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-3124.368,-1453.094;Inherit;False;35;DistortionIndeisty;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-3083.924,-1814.376;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;70;-3097.819,-1525.082;Inherit;False;34;DistortionUV;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.LerpOp;71;-2862.031,-1605.153;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;51;-2376.048,-1253.346;Float;False;Property;_MainTexU;MainTexU;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;52;-2399.72,-1168.016;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-2371.72,-1100.016;Float;False;Property;_MainTexV;MainTexV;9;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;-3437.446,-583.9744;Float;False;Property;_SecTexV;SecTexV;16;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;14;-3465.446,-651.9742;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;54;-2210.719,-1249.017;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;149;-2684.168,-1695.298;Half;False;Property;_NormalTexDistortionUV;NormalTexDistortionUV;42;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-3440.446,-735.9744;Float;False;Property;_SecTexU;SecTexU;15;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-2599.608,-1570.444;Float;False;Property;_NormalIntensity;NormalIntensity;13;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;53;-2209.719,-1151.016;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;74;-2401.038,-1699.411;Inherit;True;Property;_NormalTex;NormalTex;10;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-3276.446,-732.9744;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-3275.446,-634.9744;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;56;-2302.62,-1378.517;Inherit;False;0;39;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;55;-2049.419,-1217.117;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldReflectionVector;37;-1939.018,-1759.825;Inherit;False;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleAddOpNode;57;-1909.818,-1264.817;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;-3115.146,-701.0745;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;17;-3368.345,-862.4743;Inherit;False;0;4;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;145;-2738.969,-534.9019;Inherit;False;35;DistortionIndeisty;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;19;-2975.547,-748.7744;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;-2705.139,-604.0247;Inherit;False;34;DistortionUV;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;40;-1685.056,-1510.01;Float;False;Property;_MainColor;MainColor;6;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;42;-1738.777,-1793.174;Inherit;True;Property;_CubeMapTex;CubeMapTex;17;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Cube;8;0;SAMPLERCUBE;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode;41;-1670.531,-1869.262;Float;False;Property;_CubeMapIntensity;CubeMapIntensity;18;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;39;-1741.342,-1290.156;Inherit;True;Property;_MainTex;MainTex;7;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;44;-1454.477,-1503.712;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1453.863,-1859.14;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;143;-2514.705,-638.9096;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ToggleSwitchNode;151;670.4992,235.1905;Half;False;Property;_DitherSwitch;DitherSwitch;31;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;148;-2311.582,-836.7287;Half;False;Property;_SecTexDistortionUV;SecTexDistortionUV;43;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;47;-1232.519,-1661.256;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;46;-1037.871,-1650.57;Float;False;Property;_AllColor;AllColor;5;1;[HDR];Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode;5;-1603.9,-927.3701;Float;False;Property;_AO;AO;2;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1605.542,-709.1987;Float;False;Property;_Gloss;Gloss;3;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-1604.542,-509.1987;Float;False;Property;_Metallic;Metallic;4;0;Create;True;0;0;0;False;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;48;-788.8943,-1644.485;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-2060.071,-859.1312;Inherit;True;Property;_SecTex;SecTex;14;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;-1357.056,-275.9584;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-1416.542,-754.1987;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;58;-575.2932,-1561.087;Float;False;Property;_EmissionSwitch;EmissionSwitch;1;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;59;-577.5464,-1654.643;Float;False;Property;_AlbedoOFF;AlbedoOFF;0;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1419.901,-987.3699;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-1416.542,-536.1987;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;160;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ExtraPrePass;0;0;ExtraPrePass;5;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;0;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;161;-163.5847,-1443.218;Float;False;True;-1;3;UnityEditor.ShaderGraphLitGUI;0;12;SinCourse/PBR简化;94348b07e5e8bab40bd6c8a1e3df54cd;True;Forward;0;1;Forward;21;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalForward;False;False;0;;0;0;Standard;43;Lighting Model;0;0;Workflow;1;0;Surface;0;0;  Refraction Model;0;0;  Blend;0;0;Two Sided;1;0;Alpha Clipping;1;0;  Use Shadow Threshold;0;0;Fragment Normal Space,InvertActionOnDeselection;0;0;Forward Only;0;0;Transmission;0;0;  Transmission Shadow;0.5,False,;0;Translucency;0;0;  Translucency Strength;1,False,;0;  Normal Distortion;0.5,False,;0;  Scattering;2,False,;0;  Direct;0.9,False,;0;  Ambient;0.1,False,;0;  Shadow;0.5,False,;0;Cast Shadows;1;0;Receive Shadows;1;0;Receive SSAO;1;0;GPU Instancing;1;0;LOD CrossFade;1;0;Built-in Fog;1;0;_FinalColorxAlpha;0;0;Meta Pass;1;0;Override Baked GI;0;0;Extra Pre Pass;0;0;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Write Depth;0;0;  Early Z;0;0;Vertex Position,InvertActionOnDeselection;1;0;Debug Display;0;0;Clear Coat;0;0;0;10;False;True;True;True;True;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;162;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;163;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthOnly;0;3;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;True;True;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;164;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Meta;0;4;Meta;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;165;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;Universal2D;0;5;Universal2D;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=Universal2D;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;166;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;DepthNormals;0;6;DepthNormals;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=DepthNormals;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;167;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;GBuffer;0;7;GBuffer;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;True;1;1;False;;0;False;;1;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;1;LightMode=UniversalGBuffer;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;168;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;SceneSelectionPass;0;8;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;169;-163.5847,-1443.218;Float;False;False;-1;3;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;94348b07e5e8bab40bd6c8a1e3df54cd;True;ScenePickingPass;0;9;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;0;False;;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;4;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;UniversalMaterialType=Lit;True;5;True;12;all;0;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;25;0;22;0
WireConnection;25;1;23;0
WireConnection;159;0;27;0
WireConnection;159;1;24;0
WireConnection;29;0;25;0
WireConnection;29;1;26;0
WireConnection;30;0;159;0
WireConnection;30;1;29;0
WireConnection;31;1;30;0
WireConnection;82;0;77;0
WireConnection;82;1;76;0
WireConnection;79;0;76;0
WireConnection;79;1;78;0
WireConnection;32;0;31;0
WireConnection;88;0;82;0
WireConnection;88;1;79;0
WireConnection;35;0;33;0
WireConnection;34;0;32;0
WireConnection;96;0;85;0
WireConnection;96;1;88;0
WireConnection;98;0;84;0
WireConnection;98;1;90;0
WireConnection;94;0;90;0
WireConnection;94;1;83;0
WireConnection;91;0;86;0
WireConnection;91;1;89;0
WireConnection;92;0;87;0
WireConnection;92;1;86;0
WireConnection;103;0;96;0
WireConnection;103;1;95;0
WireConnection;103;2;93;0
WireConnection;99;0;92;0
WireConnection;99;1;91;0
WireConnection;100;0;98;0
WireConnection;100;1;94;0
WireConnection;134;0;99;0
WireConnection;134;1;101;0
WireConnection;107;0;105;0
WireConnection;107;1;104;0
WireConnection;111;0;104;0
WireConnection;111;1;106;0
WireConnection;153;0;96;0
WireConnection;153;1;103;0
WireConnection;109;0;101;0
WireConnection;109;1;100;0
WireConnection;110;0;102;0
WireConnection;110;1;99;0
WireConnection;112;1;153;0
WireConnection;133;1;110;0
WireConnection;147;0;109;0
WireConnection;147;1;134;0
WireConnection;113;0;107;0
WireConnection;113;1;111;0
WireConnection;116;0;112;0
WireConnection;116;1;133;0
WireConnection;115;0;114;0
WireConnection;115;1;113;0
WireConnection;138;1;147;0
WireConnection;118;0;138;0
WireConnection;136;0;116;0
WireConnection;117;1;115;0
WireConnection;119;0;118;0
WireConnection;120;0;117;0
WireConnection;135;0;136;0
WireConnection;122;0;120;0
WireConnection;152;0;135;0
WireConnection;152;1;119;0
WireConnection;124;0;152;0
WireConnection;124;1;122;0
WireConnection;140;0;139;0
WireConnection;140;1;124;0
WireConnection;141;0;140;0
WireConnection;128;0;141;0
WireConnection;130;0;128;0
WireConnection;130;1;129;0
WireConnection;131;0;130;0
WireConnection;64;0;62;0
WireConnection;64;1;61;0
WireConnection;65;0;63;0
WireConnection;65;1;62;0
WireConnection;66;0;65;0
WireConnection;66;1;64;0
WireConnection;68;0;67;0
WireConnection;68;1;66;0
WireConnection;71;0;68;0
WireConnection;71;1;70;0
WireConnection;71;2;69;0
WireConnection;54;0;51;0
WireConnection;54;1;52;0
WireConnection;149;0;68;0
WireConnection;149;1;71;0
WireConnection;53;0;52;0
WireConnection;53;1;50;0
WireConnection;74;1;149;0
WireConnection;74;5;73;0
WireConnection;15;0;12;0
WireConnection;15;1;14;0
WireConnection;16;0;14;0
WireConnection;16;1;13;0
WireConnection;55;0;54;0
WireConnection;55;1;53;0
WireConnection;37;0;74;0
WireConnection;57;0;56;0
WireConnection;57;1;55;0
WireConnection;18;0;15;0
WireConnection;18;1;16;0
WireConnection;19;0;17;0
WireConnection;19;1;18;0
WireConnection;42;1;37;0
WireConnection;39;1;57;0
WireConnection;44;0;40;0
WireConnection;44;1;39;0
WireConnection;43;0;41;0
WireConnection;43;1;42;0
WireConnection;143;0;19;0
WireConnection;143;1;144;0
WireConnection;143;2;145;0
WireConnection;151;0;128;0
WireConnection;151;1;131;0
WireConnection;148;0;19;0
WireConnection;148;1;143;0
WireConnection;47;0;43;0
WireConnection;47;1;44;0
WireConnection;48;0;47;0
WireConnection;48;1;46;0
WireConnection;4;1;148;0
WireConnection;127;0;116;0
WireConnection;127;1;142;0
WireConnection;127;2;126;0
WireConnection;8;0;4;2
WireConnection;8;1;6;0
WireConnection;58;0;48;0
WireConnection;59;1;48;0
WireConnection;9;0;4;1
WireConnection;9;1;5;0
WireConnection;10;0;4;3
WireConnection;10;1;7;0
WireConnection;161;0;59;0
WireConnection;161;1;74;0
WireConnection;161;2;58;0
WireConnection;161;3;10;0
WireConnection;161;4;8;0
WireConnection;161;5;9;0
WireConnection;161;7;151;0
WireConnection;161;8;127;0
ASEEND*/
//CHKSM=38B8F17709FBF31295C6D0607CDE0A73AA5E4B01