#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_fragmentColor;
varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
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
//===============================================
void lightband()
{
    vec4 normalColor = texture2D(CC_Texture0, v_texCoord);
    vec2 uv = v_texCoord;
    float gp = 0.2;
    float m1 = mod(CC_Time[1],1.0);
    if(m1<gp)
        gp=m1;
    m1=(m1);
    float m2 = m1+gp;
    float t = (uv.x+1.0-uv.y)/2.0;
    if(t>=m1 && t<=m2)
    {
        float v = 0.0;
        #if 1
        float mid = (m1+m2)/2.0;
        if(t<=mid)
        {
            v = (t-m1)/gp;
        }
        else
        {
            v = (m2-t)/gp;
        }
        v=v*2.0;
        #else
        v = (t-m1)/gp;
        #endif
        v=v*normalColor.a;
        gl_FragColor = v_fragmentColor*v+normalColor*(1.0-v);   
    }
    else
    {   
    
        gl_FragColor = normalColor;
    }

}
void lightband2()
{
    vec2 uv = v_texCoord;
    float gp = 0.2;
    float m1 = mod(CC_Time[1],1.0);
    if(m1<gp)
        gp=m1;
    m1=(m1);
    float m2 = m1+gp;
    float t = (uv.x+1.0-uv.y)/2.0;
    if(t>=m1 && t<=m2)
    {
        float v = 0.0;
        #if 1
        float mid = (m1+m2)/2.0;
        if(t<=mid)
        {
            v = (t-m1)/gp;
        }
        else
        {
            v = (m2-t)/gp;
        }
        v=v*2.0;
        vec4 normalColor = texture2D(CC_Texture0, v_texCoord+vec2(0,0.01)*v);
        #else
        v = (t-m1)/gp;
        vec4 normalColor = texture2D(CC_Texture0, v_texCoord+vec2(0,0.01)*v);
        #endif
        v=v*normalColor.a;
        
        gl_FragColor = v_fragmentColor*v+normalColor*(1.0-v);   
    }
    else
    {   
    
        gl_FragColor = texture2D(CC_Texture0, v_texCoord);
    }

}
//===============================================
void lightup()
{
    vec4 normalColor = texture2D(CC_Texture0, v_texCoord);
    vec2 uv = v_texCoord;
    //float cx = mod(CC_Time[1],1.0);
    //float cy = 0.5;
    float cx = CC_V4P1[0];
    float cy = CC_V4P1[1];
    float t = pow(uv.x-cx,2.0)+pow(uv.y-cy,2.0);

    float rr = abs(1.0-mod(CC_Time[1],2.0))/5.0;
    float r = pow(rr+0.2,2.0);
    if(t<=r)
    {
        float v = 1.0-t/r;
        v=v*normalColor.a;
        gl_FragColor = v_fragmentColor*v+normalColor*(1.0-v);   
    }
    else
    {   
    
        gl_FragColor = normalColor;
    }

}

void lightback()
{
    vec4 normalColor = texture2D(CC_Texture0, v_texCoord);
    vec2 uv = v_texCoord;
    //float cx = mod(CC_Time[1],1.0);
    //float cy = 0.5;
    float cx = CC_V4P1[0];
    float cy = CC_V4P1[1];
    float t = pow(uv.x-cx,2.0)+pow(uv.y-cy,2.0);

    float rr = abs(1.0-mod(CC_Time[1],2.0))/5.0;
    float r = pow(rr+0.2,2.0);
    if(t<=r)
    {
        float a = 1.0-t/r;
        float va = 1.0-pow(abs(0.5-uv.y),2.0)/0.25;
        float ha = 1.0-pow(abs(0.5-uv.x),2.0)/0.25;
        a = min(va,a);
        a = min(ha,a);
        float oa = normalColor.a;
        gl_FragColor = v_fragmentColor*a*(1.0-oa)+normalColor;
    }
    else
    {   
    
        gl_FragColor = normalColor;
    }

}
void lightoutline()
{
    vec4 vcolor = v_fragmentColor;
    vec4 color = texture2D(CC_Texture0, v_texCoord);
    vec2 uv = v_texCoord;
    float radius=3.0;
    float step_u=0.01;
    float step_v=0.01;
    vec4 acolor  = color;
    for(float i = 1.0; i <= radius; i += 1.0)
    {
        acolor += texture2D(CC_Texture0, vec2(uv.x - step_u * i, uv.y - step_v * i));
        acolor += texture2D(CC_Texture0, vec2(uv.x + step_u * i, uv.y - step_v * i));
        acolor += texture2D(CC_Texture0, vec2(uv.x + step_u * i, uv.y + step_v * i));
        acolor += texture2D(CC_Texture0, vec2(uv.x - step_u * i, uv.y + step_v * i));
    }
    acolor.a=acolor.a/(1.0+radius*4.0);
    float rate = abs(1.0-mod(CC_Time[1],2.0));
    if(color.a<1.0)
    {
        float na = acolor.a*rate*2.0;
        gl_FragColor = vcolor*(1.0-color.a)*na+color;
    }
    else
    {
        gl_FragColor = color;
    }
}

void lightcircle()
{
    vec4 normalColor = texture2D(CC_Texture0, v_texCoord);
    vec2 uv = v_texCoord;
    float cx = CC_V4P1[0];
    float cy = CC_V4P1[1];
    float m1 = mod(CC_Time[1],4.0)/4.0;
    float m2 = m1+0.1;
    float x = cx-uv.x;
    float y = cy-uv.y;
    y*=8.0/7.5;
    float r = sqrt(pow(x,2.0)+pow(y,2.0));
    if(r>=m1 && r<=m2)
    {
        float v = abs(r)/0.5;
        gl_FragColor = v_fragmentColor*v+texture2D(CC_Texture0, v_texCoord)*(1.0-v);   
    }
    else
    {   
    
        gl_FragColor = texture2D(CC_Texture0, v_texCoord-vec2(0.05,0.05));
    }
}

void main()
{
    //lightup();
    //lightback();
    //lightband();
    //lightoutline();
    lightband2();
    //lightcircle();
    //lightcut();
}

