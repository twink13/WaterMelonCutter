﻿Shader "Twink/Cutter/CutterBack"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_CutSetting ("Cut Setting", Range(0, 1)) = 0.5

	}
	SubShader
	{
		Tags { "RenderType"="Transparent" "Queue"="Transparent" }
		LOD 100
		Blend SrcAlpha OneminusSrcAlpha
		Cull Front

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
				fixed cut : TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			fixed _CutSetting;
			uniform float4x4 _World2SpliterMatrix;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				o.cut = v.vertex.y;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv);
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				col.a = i.cut;
				col.a = step(i.cut, _CutSetting);
				return col;
			}
			ENDCG
		}
	}
}
