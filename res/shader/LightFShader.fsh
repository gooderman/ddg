#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
//default no need redefine
//uniform mat4 CC_PMatrix;
//uniform mat4 CC_MVMatrix;
//uniform mat4 CC_MVPMatrix;
//uniform vec4 CC_Time;
//uniform vec4 CC_SinTime;
//uniform vec4 CC_CosTime;
//uniform vec4 CC_Random01;
void main()
{
    vec4 normalColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
//	normalColor *= vec4(0.8, 0.8, 0.8, 1);
//	normalColor.b += normalColor.a * 0.2;
//  gl_FragColor = normalColor;
    int tt = ceil(CC_Time.g * 1000);
    tt = mod(tt,2000);
    float sss = (float)tt;
    if(sss>=1800.0 || sss<=200)
	{
		sss = 0;
	}
    else if(sss<=1200.0 && sss>=800)
    {
    	sss = 1.0;
    }	
    else if(sss>=1000+200)
    {
    	sss = (2000-200-sss)/600;
    }
    else
    {
 		sss = (sss-200)/600;
	}	
	//sss = 0.8 + sss;
    sss = 0.5+CC_Random01.a;
    //sss = CC_SinTime.a;
	gl_FragColor = normalColor*vec4(sss,sss,sss,1.0);

}

