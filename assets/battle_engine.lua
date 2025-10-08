-- battle_engine.lua
local battle_engine = {}

-- these are default box positionings
local bullet_box = {
    x = 320,    -- X
    y = 320,    -- Y
    width = 570,  -- width
    height = 135,  -- height
    rotation = 0,    -- rotation
}

local action_ui = {
    fight = {},
    act = {},
    item = {},
    mercy = {},
}

-- create graphics objects in load, not at require-time
function battle_engine.load()
    for name, _ in pairs(action_ui) do
        local path = "assets/battle_assets/ui/"
        local idx = ({fight = "0.png", act = "1.png", item = "2.png", mercy = "3.png"})[name]
        action_ui[name].img = love.graphics.newImage(path .. idx)
        local w, h = action_ui[name].img:getDimensions()
        action_ui[name].quad1 = love.graphics.newQuad(0, 0, 110, 42, w, h)
        action_ui[name].quad2 = love.graphics.newQuad(110, 0, 110, 42, w, h)
    end
end

function battle_engine.update(i)
    -- pretend there's stuff here
end

local function draw_bullet_box()
    love.graphics.push()
    love.graphics.translate(bullet_box.x, bullet_box.y)
    love.graphics.rotate(bullet_box.rotation)
    local vertices = {
        -bullet_box.width / 2, -bullet_box.height / 2,
        bullet_box.width / 2, -bullet_box.height / 2,
        bullet_box.width / 2, bullet_box.height / 2,
        -bullet_box.width / 2, bullet_box.height / 2
    }
    
    love.graphics.setLineStyle("rough")
    love.graphics.setColor(0, 0, 0, 0.7)
    love.graphics.polygon('fill', vertices)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setLineWidth(5)
    love.graphics.polygon('line', vertices)
    love.graphics.pop()
end

local function draw_action_ui()
    local actions = { "fight", "act", "item", "mercy" }
    for i, name in ipairs(actions) do
        local btn = action_ui[name]
        local quad = btn.quad1
        if player.i + 1 == i then
            quad = btn.quad2
        end
        love.graphics.draw(btn.img, quad, ((i-1) * 157) + 29, 432)
    end
end


function battle_engine.draw()
    draw_action_ui()
    draw_bullet_box()
end

return battle_engine