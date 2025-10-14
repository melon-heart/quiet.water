-- battle_engine.lua
local battle_engine = {}
local enemy = nil

local function load_enemy() -- thanks to Asuls!
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

    -- reset selections
    player.i = 0
    player.ii = 0
    player.iii = 0 -- 0 = menu, 1 = fight, 2 = act, 3 = item, 4 = mercy, 5 = enemy turn

    for name, _ in pairs(action_ui) do
        local path = "assets/battle_assets/ui/"
        local idx = ({fight = "0.png", act = "1.png", item = "2.png", mercy = "3.png"})[name]
        action_ui[name].img = love.graphics.newImage(path .. idx)
        local w, h = action_ui[name].img:getDimensions()
        action_ui[name].quad1 = love.graphics.newQuad(0, 0, 110, 42, w, h)
        action_ui[name].quad2 = love.graphics.newQuad(110, 0, 110, 42, w, h)
        -- continue loading UI assets
    end

    load_enemy()

    enemy = load_enemy()
    if enemy and enemy.load then
        enemy.load()
    end

    table.insert(writers, typewriter.new(
        50, 274,
        enemy.flavour_texts[enemy.turn] or "* Dude, where's my text?",
        fonts["determination-mono"],
        sounds["speak1"] 
    ))
end

local function move_around(i)
    if player.iii == 0 then
        if key_state.right.just_pressed then
            player.i = (player.i + 1) % 4
            sounds["squeak"]:play()
        end
        if key_state.left.just_pressed then
            player.i = (player.i - 1) % 4
            sounds["squeak"]:play()
        end
    end
end

function battle_engine.update(i) -- i = dt
    local skip = key_state.x.just_pressed

    if writers then
        for _, w in ipairs(writers) do
            if w and w.update then
                w:update(i, skip)
            end
        end
    end

    if enemy and enemy.update then
        enemy.update(i)
    end

    move_around(i)
end

local function draw_hp()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(fonts["crypto'morrow"])
    love.graphics.print(player.name .. "  lv " .. player.lv, 30, 403)

    love.graphics.setFont(fonts["hp"])
    love.graphics.print("hp", 244, 406)
    
    if enemy.kr then
        love.graphics.print("kr", 244, 406)
    end

    love.graphics.setColor(191, 0, 0)
    love.graphics.rectangle("fill", 275, 400, player.mhp * 1.2, 21)
    love.graphics.setColor(255, 245, 0)
    love.graphics.rectangle("fill", 275, 400, player.hp * 1.2, 21)

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

        if not btn or not btn.img or not btn.quad1 then
        else
            local quad = btn.quad1
            if player and player.i and (player.i + 1 == i) and btn.quad2 then
                quad = btn.quad2
            end
            love.graphics.draw(btn.img, quad, ((i-1) * 157) + 29, 432)
        end
    end
end


function battle_engine.draw(i) -- i = dt
    draw_action_ui()
    draw_hp()
    enemy.draw(i)
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