 #pragma header
    vec2 uv = openfl_TextureCoordv.xy;
    vec2 fragCoord = openfl_TextureCoordvopenfl_TextureSize;
    vec2 iResolution = openfl_TextureSize;
    uniform float iTime;
    #define iChannel0 bitmap
    #define iChannel1 bitmap
    #define texture flixel_texture2D
    #define fragColor gl_FragColor
    #define mainImage main
    
    float noise(vec2 p)
    {
        float s = texture(iChannel1,vec2(1.,2.cos(iTime))iTime8. + p1.).x;
        s = s;
        return s;
    }
    
    float onOff(float a, float b, float c)
    {
        return step(c, sin(iTime + acos(iTimeb)));
    }
    
    float ramp(float y, float start, float end)
    {
        float inside = step(start,y) - step(end,y);
        float fact = (y-start)(end-start)inside;
        return (1.-fact)  inside;
        
    }
    
    float stripes(vec2 uv)
    {
        
        float noi = noise(uvvec2(0.5,1.) + vec2(1.,3.));
        return ramp(mod(uv.y4. + iTime2.+sin(iTime + sin(iTime0.63)),1.),0.5,0.6)noi;
    }
    
    vec3 getVideo(vec2 uv)
    {
        vec2 look = uv;
        float window = 1.(1.+20.(look.y-mod(iTime4.,1.))(look.y-mod(iTime4.,1.)));
        look.x = look.x + sin(look.y10. + iTime)50.onOff(4.,4.,.3)(1.+cos(iTime80.))window;
        float vShift = 0.4onOff(2.,3.,.9)(sin(iTime)sin(iTime20.) + 
                                             (0.5 + 0.1sin(iTime200.)cos(iTime)));
        look.y = mod(look.y + vShift, 1.);
        vec3 video = vec3(texture2D(iChannel0,look));
        return video;
    }
    
    vec2 screenDistort(vec2 uv)
    {
        uv -= vec2(.5,.5);
        uv = uv1.2(1.1.2+2.uv.xuv.xuv.yuv.y);
        uv += vec2(.5,.5);
        return uv;
    }
    
    void main()
    {
    vec2 fragCoord = openfl_TextureCoordv  iResolution;
        vec2 uv = fragCoord.xy  iResolution.xy;
        uv = screenDistort(uv);
        vec3 video = getVideo(uv);
        float vigAmt = 3.+.3sin(iTime + 5.cos(iTime5.));
        float vignette = (1.-vigAmt(uv.y-.5)(uv.y-.5))(1.-vigAmt(uv.x-.5)(uv.x-.5));
        
        video += stripes(uv);
        video += noise(uv2.)2.;
        video = vignette;
        video = (12.+mod(uv.y30.+iTime,1.))13.;
        
        gl_FragColor = vec4(video,1.0);
    gl_FragColor.a = flixel_texture2D(bitmap, openfl_TextureCoordv).a;
    }