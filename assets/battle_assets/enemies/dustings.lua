-- dustings.lua

local dustings = {}
dustings.active  = {}
dustings.cache   = {}

local DEFAULTS = {
    stride                  = 1,
    alpha_threshold         = 10,
    lifetime                = 2.03,
    lifetime_randomness     = 1.0,
    initial_velocity_random = 1.0,

    angular_velocity        = 720,
    gravity_x               = -15, -- 15 if want it to go left
    gravity_y               = -60,
    linear_accel            = 14.68,
    radial_accel            = -100.0,
    tangential_accel        = -400.0,


    fade_start = 0.0,
    fade_end   = 0.432749,
}

local ANIMATION_HIT = {
    progress = {
        times  = { 0, 1.35, 1.75 },
        values = { 10.0, 5.0, 0.0 }
    },
    negative = {
        times  = { 0, 0.25, 0.5, 0.75, 0.95, 1.15, 1.35, 1.5, 1.6, 1.7 },
        values = { true, false, true, false, true, false, true, false, true, false }
    }
}

local function get_anim_value(track, current_time)
    local active_val = track.values[1]
    for i = #track.times, 1, -1 do
        if current_time >= track.times[i] then
            active_val = track.values[i]
            break
        end
    end
    return active_val
end

function dustings.sprite_to_points(image_data, opts)
    opts = opts or {}
    local stride = opts.stride or DEFAULTS.stride
    local a_thresh = (opts.alpha_threshold or DEFAULTS.alpha_threshold) / 255

    assert(image_data.getPixel,
        "sprite_to_points needs a love.image.ImageData (use love.image.newImageData(path))")

    local points = {}
    local w, h = image_data:getWidth(), image_data:getHeight()

    for y = 0, h - 1, stride do
        for x = 0, w - 1, stride do
            local r, g, b, a = image_data:getPixel(x, y)
            if a > a_thresh then
                points[#points + 1] = { x = x, y = y, r = r, g = g, b = b, a = a }
            end
        end
    end

    return points, w, h
end

function dustings.get_points_for(path, opts)
    if not dustings.cache[path] then
        local data = love.image.newImageData(path)
        dustings.cache[path] = dustings.sprite_to_points(data, opts)
    end
    return dustings.cache[path]
end

function dustings.spawn(path_or_points, origin_x, origin_y, opts)
    opts = opts or {}
    local points = (type(path_or_points) == "string")
        and dustings.get_points_for(path_or_points, opts)
        or path_or_points

    local burst = {
        x = origin_x, y = origin_y,
        time = 0,
        lifetime = DEFAULTS.lifetime,
        current_negative = false,
        current_progress = 10.0,
        particles = {},
    }

    for _, p in ipairs(points) do
        local life = DEFAULTS.lifetime * (1 - math.random() * DEFAULTS.lifetime_randomness)
        life = math.max(life, 0.05)

        burst.particles[#burst.particles + 1] = {
            x = p.x, y = p.y,
            vx = 0, vy = 0,
            life = life,
            r = p.r, g = p.g, b = p.b, a = p.a,
            rot = 0,
            rot_speed = math.rad(DEFAULTS.angular_velocity) * (math.random() < 0.5 and -1 or 1),
        }
    end

    dustings.active[#dustings.active + 1] = burst
    return burst
end

function dustings.update(dt)
    for i = #dustings.active, 1, -1 do
        local burst = dustings.active[i]
        burst.time = burst.time + dt

        burst.current_negative = get_anim_value(ANIMATION_HIT.negative, burst.time)
        burst.current_progress = get_anim_value(ANIMATION_HIT.progress, burst.time)

        local all_dead = true

        for _, p in ipairs(burst.particles) do
            if burst.time < p.life then
                all_dead = false

                local dist = math.sqrt(p.x * p.x + p.y * p.y)
                local rx, ry = 0, 0
                local tx, ty = 0, 0

                if dist > 0 then
                    rx, ry = p.x / dist, p.y / dist
                    tx, ty = -ry, rx
                end

                local ax = DEFAULTS.gravity_x + (rx * DEFAULTS.radial_accel) + (tx * DEFAULTS.tangential_accel)
                local ay = DEFAULTS.gravity_y + (ry * DEFAULTS.radial_accel) + (ty * DEFAULTS.tangential_accel)

                local v_mag = math.sqrt(p.vx * p.vx + p.vy * p.vy)
                if v_mag > 0 then
                    ax = ax + (p.vx / v_mag) * DEFAULTS.linear_accel
                    ay = ay + (p.vy / v_mag) * DEFAULTS.linear_accel
                end

                p.vx = p.vx + ax * dt
                p.vy = p.vy + ay * dt
                p.x = p.x + p.vx * dt
                p.y = p.y + p.vy * dt
                p.rot = p.rot + p.rot_speed * dt
            end
        end

        if all_dead or burst.time >= burst.lifetime then
            table.remove(dustings.active, i)
        end
    end
end

function dustings.draw(i, ii) -- i unused, ii = scale
    ii = ii or 1
    for _, burst in ipairs(dustings.active) do
        for _, p in ipairs(burst.particles) do
            if burst.time < p.life then
                local t = burst.time / p.life
                local fade = 1
                if t > DEFAULTS.fade_start then
                    fade = 1 - (t - DEFAULTS.fade_start) / (DEFAULTS.fade_end - DEFAULTS.fade_start)
                    fade = math.max(fade, 0)
                end

                if burst.current_negative then
                    love.graphics.setColor(1, 1, 1, p.a * fade)
                else
                    love.graphics.setColor(p.r, p.g, p.b, p.a * fade)
                end

                love.graphics.push()
                love.graphics.translate(burst.x + p.x * ii, burst.y + p.y * ii)
                love.graphics.rotate(p.rot)
                love.graphics.rectangle("fill", 0, 0, 1 * ii, 1 * ii)
                love.graphics.pop()
            end
        end
    end
    love.graphics.setColor(1, 1, 1, 1)
end

return dustings