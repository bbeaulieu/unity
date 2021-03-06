Shader "PlanetaryTerrain/TexturedPlanetColorMap"
{
	Properties 
	{
_ColorMap("_ColorMap", 2D) = "black" {}
_ColorMapBlend("_ColorMapBlend", Range(0,1) ) = 0.5
_ColorMapDistance("_ColorMapDistance", Float) = 10
_CameraPos("_CameraPos", Vector) = (0,0,0,0)

_SlopeTexture("_SlopeTexture", 2D) = "white" {}
_SlopePower("_SlopePower", Float ) = 1

_Color1("_Color1", Color) = (1,1,1,1)
_Color2("_Color2", Color) = (1,1,1,1)
_Color3("_Color3", Color) = (1,1,1,1)
_Color4("_Color4", Color) = (1,1,1,1)
_Value1("_Value1", Range(0,1) ) = 0.33
_Value2("_Value2", Range(0,1) ) = 0.66
_Value3("_Value3", Range(0,1) ) = 1
_Polarity("_Polarity", Float) = 0
_PolarColor("_PolarColor", Color) = (1,1,1,1)
_Texture1("_Texture1", 2D) = "white" {}
_Texture2("_Texture2", 2D) = "white" {}
_Texture3("_Texture3", 2D) = "white" {}
_Texture4("_Texture4", 2D) = "white" {}
_UvScale("_UvScale", Vector) = (0,0,0,0)
_PolarStrenght("_PolarStrenght", Float) = 0
_Brightness("_Brightness", Float) = 1
_Equator("_Equator", Vector) = (0,0,0,0)
_EquatorColor("_EquatorColor", Color) = (1,1,1,1)

	}
	
	SubShader 
	{
		Tags
		{
"Queue"="Geometry"
"IgnoreProjector"="False"
"RenderType"="Opaque"

		}

		
Cull Back
ZWrite On
ZTest LEqual
ColorMask RGBA
Fog{
}


		CGPROGRAM
#pragma surface surf BlinnPhong vertex:vert
#pragma target 3.0
#pragma glsl

sampler2D _ColorMap;
float _ColorMapBlend;
float _ColorMapDistance;
float4 _CameraPos;

sampler2D _SlopeTexture;
float _SlopePower;

float4 _Color1;
float4 _Color2;
float4 _Color3;
float4 _Color4;
float _Value1;
float _Value2;
float _Value3;
float _Polarity;
float4 _PolarColor;
sampler2D _Texture1;
sampler2D _Texture2;
sampler2D _Texture3;
sampler2D _Texture4;
float4 _UvScale;
float _PolarStrenght;
float _Brightness;
float4 _Equator;
float4 _EquatorColor;

			struct Input {
				float2 uv_Texture1;
				float2 uv_Texture2;
				float4 color : COLOR;
				float2 uv_Texture3;
				float2 uv_Texture4;
				float2 uv2_ColorMap;
				float3 worldPos;
				float2 uv_SlopeTexture;
			};

			void vert (inout appdata_full v, out Input o) {
			}
			

			void surf (Input IN, inout SurfaceOutput o) {
				o.Normal = float3(0.0,0.0,1.0);
				o.Alpha = 1.0;
				o.Albedo = 0.0;
				o.Emission = 0.0;
				o.Gloss = 0.0;
				o.Specular = 0.0;
				
float4 Split1=_UvScale;
float4 Multiply6=(IN.uv_Texture1.xyxy) * float4( Split1.x, Split1.x, Split1.x, Split1.x);
float4 Tex2D0=tex2D(_Texture1,Multiply6.xy);
float4 Multiply2=Tex2D0 * _Color1;
float4 Multiply7=(IN.uv_Texture2.xyxy) * float4( Split1.y, Split1.y, Split1.y, Split1.y);
float4 Tex2D1=tex2D(_Texture2,Multiply7.xy);
float4 Multiply3=Tex2D1 * _Color2;
float4 Split0=IN.color;
float4 Divide0=float4( Split0.x, Split0.x, Split0.x, Split0.x) / _Value1.xxxx;
float4 Saturate0=saturate(Divide0);
float4 Lerp0=lerp(Multiply2,Multiply3,Saturate0);
float4 Multiply8=(IN.uv_Texture3.xyxy) * float4( Split1.z, Split1.z, Split1.z, Split1.z);
float4 Tex2D2=tex2D(_Texture3,Multiply8.xy);
float4 Multiply4=Tex2D2 * _Color3;
float4 Subtract0=float4( Split0.x, Split0.x, Split0.x, Split0.x) - _Value1.xxxx;
float4 Subtract1=_Value2.xxxx - _Value1.xxxx;
float4 Divide1=Subtract0 / Subtract1;
float4 Saturate1=saturate(Divide1);
float4 Lerp2=lerp(Lerp0,Multiply4,Saturate1);
float4 Multiply9=(IN.uv_Texture4.xyxy) * float4( Split1.w, Split1.w, Split1.w, Split1.w);
float4 Tex2D3=tex2D(_Texture4,Multiply9.xy);
float4 Multiply5=Tex2D3 * _Color4;
float4 Subtract2=float4( Split0.x, Split0.x, Split0.x, Split0.x) - _Value2.xxxx;
float4 Subtract3=_Value3.xxxx - _Value2.xxxx;
float4 Divide2=Subtract2 / Subtract3;
float4 Saturate2=saturate(Divide2);
float4 Lerp1=lerp(Lerp2,Multiply5,Saturate2);
float4 Multiply10=_Brightness.xxxx * Lerp1;
float4 Subtract4=float4( Split0.y, Split0.y, Split0.y, Split0.y) - _Polarity.xxxx;
float4 Max0=max(Subtract4,float4( 0.0, 0.0, 0.0, 0.0 ));
float4 Multiply1=_PolarColor * _PolarStrenght.xxxx;
float4 Multiply0=Max0 * Multiply1;
float4 Split2=_Equator;
float4 Subtract5=float4( Split2.x, Split2.x, Split2.x, Split2.x) - float4( Split0.y, Split0.y, Split0.y, Split0.y);
float4 Max1=max(Subtract5,float4( 0.0, 0.0, 0.0, 0.0 ));
float4 Multiply12=_EquatorColor * float4( Split2.y, Split2.y, Split2.y, Split2.y);
float4 Multiply11=Max1 * Multiply12;
float4 Subtract6=float4( Split0.x, Split0.x, Split0.x, Split0.x) - float4( Split2.z, Split2.z, Split2.z, Split2.z);
float4 Max2=max(Subtract6,float4( 0.0, 0.0, 0.0, 0.0 ));
float4 Multiply13=Multiply11 * Max2;
float4 Add1=Multiply0 + Multiply13;
float4 Add0=Multiply10 + Add1;
float4 Master0_1_NoInput = float4(0,0,1,1);
float4 Master0_2_NoInput = float4(0,0,0,0);
float4 Master0_3_NoInput = float4(0,0,0,0);
float4 Master0_4_NoInput = float4(0,0,0,0);
float4 Master0_5_NoInput = float4(1,1,1,1);
float4 Master0_7_NoInput = float4(0,0,0,0);
float4 Master0_6_NoInput = float4(1,1,1,1);

// slope texture
float4 SlopeTex = tex2D(_SlopeTexture, IN.uv_SlopeTexture.xy);
float slope = IN.color.z;
float slopePower = slope * _SlopePower;
Add0 = lerp(Add0, SlopeTex, slopePower);

// snow
//float snowHeight = 0.7;
//float snowRange = 1.0 - snowHeight;
//float snowStrenght = max(min(IN.color.x - snowHeight, snowRange), 0) / snowRange;
//snowStrenght = saturate(snowStrenght * slope);
//Add0 = Add0 * (1 - snowStrenght) + float4(.8, .8, .8, 1) * snowStrenght;

// colormap blend
float4 ColorMap = tex2D(_ColorMap, IN.uv2_ColorMap.xy);

float4 Distance0 = distance(_CameraPos, float4( IN.worldPos.x, IN.worldPos.y,IN.worldPos.z,1.0 ));
float distanceBlend = (saturate(length(Distance0) / _ColorMapDistance)) * (1.0 - _ColorMapBlend);
float colorMapStrength = _ColorMapBlend + distanceBlend;

o.Albedo = Add0 * (float4(1,1,1,1) * (1.0 - colorMapStrength) + ColorMap * colorMapStrength);

	

			}
		ENDCG
	}
	Fallback "BumpedSpecular"
}