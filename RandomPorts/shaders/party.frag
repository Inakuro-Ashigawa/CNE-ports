#pragma header
vec2 uv = openfl_TextureCoordv.xy;
vec2 fragCoord = openfl_TextureCoordv*openfl_TextureSize;
vec2 iResolution = openfl_TextureSize;
uniform float iTime;
#define iChannel0 bitmap
#define texture flixel_texture2D
#define fragColor gl_FragColor
#define mainImage main


        vec4 fwd(vec4 c) {
            float t0 = iTime * 1.00002;
            float t1 = iTime * 1.00002;
            float t2 = iTime * 1.00002;
        
            c.xy = c.xy * mat2(cos(t2), -sin(t2), sin(t2), cos(t2));
            c.yz = c.yz * mat2(cos(t1), -sin(t1), sin(t1), cos(t1));
            c.zx = c.zx * mat2(cos(t0), -sin(t0), sin(t0), cos(t0));
            return c;
        }
        
        vec4 bwd(vec4 c) {
            float t0 = -iTime * 1.0;
            float t1 = -iTime * 1.0;
            float t2 = -iTime * 1.0;
        
            c.zx = c.zx * mat2(cos(t0), -sin(t2), sin(t0), cos(t0));
            c.yz = c.yz * mat2(cos(t1), -sin(t1), sin(t1), cos(t1));
            c.xy = c.xy * mat2(cos(t2), -sin(t0), sin(t2), cos(t2));
            return c;
        }
        
        void main()
        {
            vec2 uv = openfl_TextureCoordv;
            float f0 = 0.0;
            float f1 = 0.0;
            float f2 = 0.0;
            float w = 0.00;
        
            vec4 col0 = texture2D(bitmap, uv, f0);
            vec4 col1 = texture2D(bitmap, uv + vec2(1.0,sin(uv.x*40.0)*w), f1);
            vec4 col2 = texture2D(bitmap, uv + vec2(sin(uv.y*30.0)*w,0.0), f2);
            col0 = fwd(col0);
            col1 = fwd(col1);
            col2 = fwd(col2);
            vec4 col = vec4(col0.x, col1.y, col2.z, 1.0);
            col = bwd(col);
        
            gl_FragColor = col* flixel_texture2D(bitmap, uv).a;
        }