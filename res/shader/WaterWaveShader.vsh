attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec4 a_color;

#ifdef GL_ES
varying lowp vec4 v_fragmentColor;
varying mediump vec2 v_texCoord;
varying mediump vec2 v_texCoord2;
#else
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
varying vec2 v_texCoord2;
#endif

void main()
{
	gl_Position = CC_MVPMatrix * a_position;
	v_fragmentColor = a_color;
	v_texCoord = a_texCoord;
	//vec2 disScroll = vec2(CC_Time[1], 0.0);
	//vec2 screen01 = (0.5*gl_Position.xy/1.0 + 0.5);
	//v_texCoord2 = screen01*512.0/256.0 + disScroll;
	v_texCoord2 = gl_Position.xy;
}
