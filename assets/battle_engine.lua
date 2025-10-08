-- battle_engine.lua
local battle_engine = {}

local function load_current_enemy() -- thanks to Asuls!
    local enemy_module = ("assets.battle_assets.enemies." .. scene.ii .. "." .. scene.ii)
    package.loaded[enemy_module] = nil
    return require(enemy_module)
end

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

function battle_engine.load()
    for name, _ in pairs(action_ui) do
        local path = "assets/battle_assets/ui/"
        local idx = ({fight = "0.png", act = "1.png", item = "2.png", mercy = "3.png"})[name]
        action_ui[name].img = love.graphics.newImage(path .. idx)
        local w, h = action_ui[name].img:getDimensions()
        action_ui[name].quad1 = love.graphics.newQuad(0, 0, 110, 42, w, h)
        action_ui[name].quad2 = love.graphics.newQuad(110, 0, 110, 42, w, h)
        -- continue loading UI assets
    end

    load_current_enemy()

    table.insert(writers, typewriter.new(
        50, 274,
        "* hello /c[255,0,0]world/n/s[0.01]fast now/w slow down /s[0.1]again!",
        fonts["determination-mono"],
        nil 
    ))
end

function battle_engine.update(i)
    -- dt: delta time
    local skip = false
    if love and love.keyboard and love.keyboard.isDown then
        skip = love.keyboard.isDown("x")
    end

    if writers then
        for _, w in ipairs(writers) do
            if w and w.update then
                w:update(i, skip)
            end
        end
    end
end

local function draw_hp()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts["crypto'morrow"])
    love.graphics.print(player.name .. "  lv " .. player.lv, 30, 403)
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
        -- guard against missing assets (load may not have been called or file missing)
        if not btn or not btn.img or not btn.quad1 then
            -- skip drawing this button if assets are missing
        else
            local quad = btn.quad1
            if player and player.i and (player.i + 1 == i) and btn.quad2 then
                quad = btn.quad2
            end
            love.graphics.draw(btn.img, quad, ((i-1) * 157) + 29, 432)
        end
    end
end


function battle_engine.draw()
    draw_action_ui()
    draw_hp()
    draw_bullet_box()
    -- Draw writers (typewriter text)
    if writers then
        for _, w in ipairs(writers) do
            if w and w.draw then
                w:draw()
            end
        end
    end
end

return battle_engine