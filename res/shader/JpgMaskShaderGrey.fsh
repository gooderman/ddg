#ifdef GL_ES
precision mediump float;
#endif
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
uniform sampler2D CC_Texture1;

void main()
{
    vec4 color1 = texture2D(CC_Texture0, v_texCoord);
    vec4 color2 = texture2D(CC_Texture1, v_texCoord);
    float aaa = color2.a;
    float gray = dot(color1.rgb, vec3(0.299, 0.587, 0.114));
    gl_FragColor = vec4(gray, gray, gray, color1.a*aaa);
}
