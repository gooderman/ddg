#ifdef GL_ES
precision mediump float;
#endif
varying float isgrey;
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
void main()
{
    vec4 color1 = texture2D(CC_Texture0, v_texCoord);
    vec4 color2 = texture2D(CC_Texture1, v_texCoord);
    float aaa = color2.a; 	
    gl_FragColor = vec4(color1.r, color1.g, color1.b, color1.a*aaa);		
}
