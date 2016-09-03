#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;

void main()
{
    vec4 color = texture2D(CC_Texture0, v_texCoord) * v_fragmentColor;
    gl_FragColor = vec4(color.a, color.g, color.b, 1.0-color1.a);

}
