-- dustings.lua
-- i really need to work on this... 

local dustings = {}
dustings.active  = {}
dustings.cache   = {}

function dustings.listparticles(path, opts)
    if not dustings.cache[path] then
        local data = love.image.newImageData(path)
        dustings.cache[path] = dustings.sprite_to_points(data, opts)
    end
    return dustings.cache[path]
end

function dustings.spawn(path, x, y, opts)

end

function dustings.update(i) --  i = dt 

end

function dustings.draw(i, ii) -- i unused, ii = scale

end

return dustings