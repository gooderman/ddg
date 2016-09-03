#ifdef GL_ES
precision mediump float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;

void main()
{
	vec4 color1 = texture2D(CC_Texture0, v_texCoord);
	float aaa = 0.0;
	float dir = CC_V4P1[0];
	float pos = CC_V4P1[1];
	float sk = CC_V4P1[2];
	int uv = 1;
	if(dir>=3.0)
	{
		uv = 0;
	}
	float uvf = v_texCoord[uv];
	if(dir==1.0 || dir==3.0)
	{
		if(uvf <= pos)
		{
			aaa=1.0;
		}
		else if(uvf < pos+sk)
		{
			float a = (uvf - pos)/sk;
			aaa = 1.0 - a*a;
		}
	}
	else
	{
		pos = 1.0 - pos;
		if(uvf >= pos)
		{
			aaa=1.0;
		}
		else if(uvf>=pos-sk)
		{
		    float b=(uvf-pos)/sk;
            aaa = 1.0-b*b;
		}
	}
	gl_FragColor = vec4(color1.r, color1.g, color1.b, color1.a*aaa*CC_V4P1[3]);
}
