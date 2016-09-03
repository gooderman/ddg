#ifdef GL_ES
precision mediump float;
#endif 
varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0; 
void main()
{
 vec4 normalColor = v_fragmentColor * texture2D(CC_Texture0, v_texCoord);
 float gray = (normalColor.r + normalColor.g + normalColor.b) * (0.6);
 gl_FragColor = vec4(gray*0.28,gray*0.65,gray*1.0,normalColor.a*0.8);
}
