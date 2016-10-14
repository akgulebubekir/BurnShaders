Shader "Custom/BurnShader" {
	Properties {
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_Glossiness("Smoothness", Range(0,1)) = 0.5
		_Metallic("Metallic", Range(0,1)) = 0.0

		_BurnTex("Burn texture", 2D) = "white" {}
		_BurnAmount("Burn", Range(0,1)) = 0.5

		_BurnColor("Burn Color", Color) = (1,0,0,1)
		_BurnLength("Burn Length", Range(0,1)) = 0.01
	}
	SubShader {
			Tags{ "Queue" = "Transparent" "RenderType" = "Transparent" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alpha:fade

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BurnTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		fixed4 _BurnColor;

		half _BurnAmount;
		half _BurnLength;

		void surf (Input IN, inout SurfaceOutputStandard o) {

			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			fixed burn = tex2D(_BurnTex, IN.uv_MainTex).r;
			if (burn < _BurnAmount) {
				o.Albedo = fixed4(0, 0, 0, 0);
				o.Alpha = 0;
			}
			else if (burn < _BurnAmount + _BurnLength) {
				o.Albedo = _BurnColor;
				o.Alpha = c.a;
			}
			else {
				o.Albedo = c.rgb;
				o.Alpha = c.a;

			}

			// Metallic and smoothness come from slider variables
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;

		}
		ENDCG
	}
	FallBack "Diffuse"
}
