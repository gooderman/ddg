#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
//default
//uniform mat4 CC_PMatrix
//uniform mat4 CC_MVMatrix
//uniform mat4 CC_MVPMatrix
//uniform vec4 CC_Time
//uniform vec4 CC_SinTime
//uniform vec4 CC_CosTime
//uniform vec4 CC_Random01
void main()
{
    vec4 normalColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
//	normalColor *= vec4(0.8, 0.8, 0.8, 1);
//	normalColor.b += normalColor.a * 0.2;
//  gl_FragColor = normalColor;

//    int tt = (int)(CC_Time.g*1000);
//	tt = tt%2000;
//	float sss = tt;
//	if(sss>1000)
//	{
//		sss =(2000-sss)/1000;
//	}	
//	else
//	{
//		sss = sss/1000;
//	}	
	gl_FragColor = normalColor*vec4(1.5,1.5,1.5,1.0);

}

