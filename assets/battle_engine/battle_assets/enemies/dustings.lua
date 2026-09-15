-- dustings.lua
-- credit to Isla for creating this

local dustings  = {}
dustings.active = {}
dustings.cache  = {}

function dustings.load_cached(path)
    if not dustings.cache[path] then
        local data = love.image.newImageData(path)
        dustings.cache[path] = data
    end
    return dustings.cache[path]
end

function dustings.sprite_to_points(data)
    local output = {}

    local width = data:getWidth()
    local height = data:getHeight()

    for y = 1, height do
        output[y] = {}
        for x = 1, width do
            local r, g, b, a = data:getPixel(x - 1, y - 1)
            output[y][x] = { r = r, g = g, b = b, a = a }
        end
    end

    return output
end

function dustings.make_particles(points, offset_x, offset_y, spread, speed)
    local output = {}

    for y = 1, #points do
        for x = 1, #points[y] do
            local sx = x*2 + offset_x
            local sy = y*2 + offset_y

            output[#output + 1] = {
                color = points[y][x],
                start = y / #points * speed,
                sx = sx,
                sy = sy,
                svx = love.math.random(-spread, spread),
                svy = love.math.random(-spread, spread / 2),
                ax = 0,
                ay = -100,
                x = sx,
                y = sy
            }
        end
    end

    return output
end

function dustings.draw_particles(particles, time, decay)
    local points = {}

    for pi = 1, #particles do
        local particle = particles[pi]

        local p_time = math.max(0, time - particle.start)

        local x = particle.x
        local y = particle.y
        local r = particle.color.r
        local g = particle.color.g
        local b = particle.color.b
        local a = particle.color.a * (1.0 - p_time / decay)

        points[#points + 1] = {
            x, y, r, g, b, a
        }
    end

    love.graphics.setPointSize(2.0)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.points(points)
end

function dustings.spawn(path, x, y, spread, length, speed, decay)
    local image = dustings.load_cached(path)
    local points = dustings.sprite_to_points(image)
    local particles = dustings.make_particles(points, x, y, spread, speed)
    dustings.active[#dustings.active + 1] = {
        particles = particles,
        length = length,
        decay = decay,
        time = 0
    }
end

function dustings.update(dt) --  i = dt
    for i = 1, #dustings.active do
        local dusting = dustings.active[i]

        if not dusting then
            goto continue
        end

        for pi = 1, #dusting.particles do
            local particle = dusting.particles[pi]
            if dusting.time > particle.start then
                local time = dusting.time - particle.start
                particle.x = particle.ax * time * time * 0.5 + time * particle.svx + particle.sx
                particle.y = particle.ay * time * time * 0.5 + time * particle.svy + particle.sy
            end
        end

        dusting.time = dusting.time + dt

        if dusting.time > dusting.length then
            table.remove(dustings.active, i)
        end

        ::continue::
    end
end

function dustings.draw(i, ii) -- i unused, ii = scale
    for i = 1, #dustings.active do
        local dusting = dustings.active[i]

        if not dusting then
            goto continue
        end

        dustings.draw_particles(dusting.particles, dusting.time, dusting.decay)

        ::continue::
    end
end

return dustings
