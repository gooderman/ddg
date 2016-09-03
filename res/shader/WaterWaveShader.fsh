#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;

varying vec2 v_texCoord2;
//============default no need redefine==========
/*
uniform mat4 CC_PMatrix;
uniform mat4 CC_MVMatrix;
uniform mat4 CC_MVPMatrix;
uniform vec4 CC_Time;
uniform vec4 CC_SinTime;
uniform vec4 CC_CosTime;
uniform vec4 CC_Random01;
uniform sampler2D CC_Texture1;
uniform sampler2D CC_Texture2;
uniform sampler2D CC_Texture3;
uniform vec4 CC_V4P1;
uniform vec4 CC_V4P2;
uniform vec4 CC_V4P3;
*/
//(CC_Time, time/10.0, time, time*2, time*4);
//(CC_SinTime, time/8.0, time/4.0, time/2.0, sinf(time));
//(CC_CosTime, time/8.0, time/4.0, time/2.0, cosf(time));

void wave(){
    float t = CC_Time[1];
    vec2 uv = v_texCoord;
    float wave = 0.01;
    
    // Sample the same texture several times at different locations.
    vec4 r = texture2D(CC_Texture0, uv + vec2(wave*sin(1.0*t + uv.y*5.0), 0.0));
    vec4 g = texture2D(CC_Texture0, uv + vec2(wave*sin(1.3*t + uv.y*5.0), 0.0));
    vec4 b = texture2D(CC_Texture0, uv + vec2(wave*sin(1.8*t + uv.y*5.0), 0.0));
    
    // Combine the channels, average the alpha values.
    gl_FragColor = vec4(r.r, g.g, b.b, (r.a + b.a + g.a)/3.0);
}
void distort(){
    vec2 texCoord = v_texCoord;
    
    float time = CC_Time[3];
    //texCoord.x += 0.1*sin(10.0*texCoord.y + time);
    
    //texCoord.x += 0.02*sin(5.0*texCoord.y + time);
    //texCoord.y += 0.02*sin(5.0*texCoord.y + time);
    
    texCoord.x += 0.02*sin(4.0*texCoord.y+time);
    texCoord.y += 0.02*cos(4.0*texCoord.y+2.0*time);
    

    gl_FragColor = texture2D(CC_Texture0, texCoord);
}
void water(){
    //CC_Texture0;orgin
    //CC_Texture1;water
    //CC_Texture2;noise
    vec2 waterScroll = vec2(CC_V4P1[0], 0.0);
    vec2 disScroll = vec2(CC_V4P1[1], 0.0);
    vec2 screen01 = (0.5*v_texCoord2/1.0 + 0.5);
    vec2 v_texCoordNs = screen01*512.0/256.0 + disScroll;
	vec2 distortion = 2.0*texture2D(CC_Texture2, v_texCoordNs).xy - 1.0;
	distortion = distortion*0.05;
	gl_FragColor = texture2D(CC_Texture0, v_texCoord + distortion);
	gl_FragColor += 0.5*texture2D(CC_Texture1, v_texCoord+waterScroll - distortion);
}

void main()
{
   water();
   //wave();
   //distort();
}

