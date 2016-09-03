#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D u_texture;

void main()
{
    vec4 color1 = texture2D(u_texture, v_texCoord) * v_fragmentColor;
	//vec4 color2 = vec4(color1.r*0.1, color1.g*0.1, color1.b*1.0, color1.a*0.5);
	float brightness = (color1.r + color1.g + color1.b) * (1. / 3.);
	float gray = (0.4) * brightness;
	vec4 color2 = vec4(gray, gray, gray, color1.a*0.2);
    gl_FragColor =color2;
}
