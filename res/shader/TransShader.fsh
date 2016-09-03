#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D u_texture;

void main()
{
    vec4 color1 = texture2D(u_texture, v_texCoord) * v_fragmentColor;
	//float brightness = (color1.r + color1.g + color1.b) * (1. / 3.);
	//float gray = (0.6) * brightness;
	//vec4 color2=vec4(gray, gray, gray, color1.a*0.3);
    //gl_FragColor =color2;
    gl_FragColor = color1*0.5;
}
