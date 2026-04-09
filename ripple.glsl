// original by angelo1810 on discord / https://gamejolt.com/@Angelo18105
extern float frequency;
extern float amplitude;
extern float ripple_rate;
extern float time;
extern vec2 center;
extern float radius;
extern vec2 aspect;
extern float rgb_strength;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords)
{
    vec2 uv = texture_coords;

    float ratio = aspect.x / aspect.y;

    vec2 pos = uv;
    vec2 c = center;

    pos.x *= ratio;
    c.x *= ratio;

    float dist = length(pos - c);

    float radius_mask = 1.0 - smoothstep(radius * 0.85, radius, dist);
    float expand = smoothstep(0.0, 0.3, dist);

    float ripple_speed = 0.5;

    float eased_time = 1.0 - exp(-3.0 * time);

    float local_time = eased_time - dist / ripple_speed;

    float ripple_active = step(0.0, local_time);

    float wave_phase = dist * frequency - local_time * ripple_rate;

    float ripple = sin(wave_phase)
                 * amplitude
                 * radius_mask
                 * expand
                 * ripple_active;

    vec2 offset = vec2(0.0);

    if (dist > 0.0001)
    {
        offset = normalize(uv - center) * ripple * 0.02;
    }

    vec2 displaced = uv + offset;

    float ring =
        (1.0 - smoothstep(0.0, 0.3, abs(sin(wave_phase))))
        * radius_mask
        * expand
        * ripple_active;

    vec2 dir = normalize(uv - center + vec2(0.0001));
    vec2 rgb_offset = dir * rgb_strength * ring * 0.008;

    vec4 baseColor = Texel(texture, displaced);

    float r = Texel(texture, displaced + rgb_offset).r;
    float g = baseColor.g;
    float b = Texel(texture, displaced - rgb_offset).b;

    return vec4(r, g, b, baseColor.a);
}
