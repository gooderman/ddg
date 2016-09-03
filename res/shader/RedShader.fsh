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
	float brightness = (normalColor.r + normalColor.g + normalColor.b) * (0.33);
	float gray = (1.0) * brightness;
	//gl_FragColor = vec4(gray*0.5,gray*0.5,gray*1.5,normalColor.a);
	//gl_FragColor = vec4(gray*0.5,gray*1.5,gray*0.5,normalColor.a);
	gl_FragColor = vec4(gray*1.5,gray*0.5,gray*0.5,normalColor.a);
}

