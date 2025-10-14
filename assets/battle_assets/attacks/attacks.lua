-- attacks.lua
local attacks = {}
local tough_glove = {}

local function tough_glove_quantise()
    local frame_width, frame_height = 50, 110
    local image_width, image_height = tough_glove.image:getDimensions()

    tough_glove.quads = {}
    for y = 0, image_height - frame_height, frame_height do
        for x = 0, image_width - frame_width, frame_width do
            local quad = love.graphics.newQuad(x, y, frame_width, frame_height, image_width, image_height)
            table.insert(tough_glove.quads, quad)
        end
    end
end

function attacks.load()
    attacks.x = 0
    attacks.y = 0

    tough_glove.press = love.graphics.newImage("assets/battle_assets/attacks/press.png")
    tough_glove.z = love.graphics.newImage("assets/battle_assets/attacks/Z.png")
    tough_glove.image = love.graphics.newImage("assets/battle_assets/attacks/tough_glove.png") -- should be quads of 50x110y
    tough_glove.timer = 0
    tough_glove.phase = "fist"

    tough_glove_quantise()
end

function attacks.update(i) -- i = dt
end

function attacks.draw(i) -- i = dt
    -- testing
    if tough_glove.quads then
        love.graphics.draw(tough_glove.image, tough_glove.quads[1], attacks.x, attacks.y, 0, 2, 2)
    end
end

return attacks
