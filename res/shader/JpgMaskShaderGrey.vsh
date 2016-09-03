attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec4 a_color;

#ifdef GL_ES
varying lowp vec4 v_fragmentColor;
varying mediump vec2 v_texCoord;
varying float isgrey;
#else
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
varying float isgrey;
#endif

void main()
{
	gl_Position = CC_MVPMatrix * a_position;
	isgrey = 1.0;
	v_fragmentColor = a_color;
	v_texCoord = a_texCoord;
}