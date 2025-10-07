-- engine.lua
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
    fight = {
        img = love.graphics.newImage("assets/battle_assets/ui/0.png"),
    },
    act = {
        img = love.graphics.newImage("assets/battle_assets/ui/1.png"),
    },
    item = {
        img = love.graphics.newImage("assets/battle_assets/ui/2.png"),
    },
    mercy = {
        img = love.graphics.newImage("assets/battle_assets/ui/3.png"),
    }
}

for _, v in pairs(action_ui) do
    v.quad1 = love.graphics.newQuad(0, 0, 110, 42, v.img:getDimensions())
    v.quad2 = love.graphics.newQuad(110, 0, 110, 42, v.img:getDimensions())
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

function battle_engine.draw()
    draw_bullet_box()
end

return battle_engine