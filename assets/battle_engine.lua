-- battle_engine.lua
local battle_engine = {}
local enemy = nil

local function load_enemy() -- thanks to Asuls!
    local enemy_module = ("assets.battle_assets.enemies." .. scene.ii .. "." .. scene.ii)
    package.loaded[enemy_module] = nil
    return require(enemy_module)
end

local attacks = require "assets.battle_assets.attacks.attacks" -- the animations for the attacks... might be used for both player and enemy attacks.

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

    attacks.load()

    enemy = load_enemy()
    if enemy and enemy.load then
        enemy.load()
    end

    table.insert(writers, typewriter.new(
        55, 268,
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
        soul.x = (player.i * 157) + 29 + 7
        soul.y = 432 + 13
        if key_state.z.just_pressed then
            sounds["select"]:play()
            writers[#writers]:clear(writers)
            player.iii = "button" .. player.i 
        end
    elseif player.iii == "button0" then
        soul.x = 62
        soul.y = 273 + (player.ii * 38)

        if key_state.down.just_pressed then
            player.ii = (player.ii + 1) % enemy.amount
            sounds["squeak"]:play()
        end
        if key_state.up.just_pressed then
            player.ii = (player.ii - 1) % enemy.amount
            sounds["squeak"]:play()
        end

        if key_state.x.just_pressed then
            player.ii = 0
            player.iii = 0
                table.insert(writers, typewriter.new(
                55, 268,
                enemy.flavour_texts[enemy.turn] or "* Dude, where's my text?",
                fonts["determination-mono"],
                sounds["speak1"] 
                ))
        end
    elseif player.iii == "button1" then
        soul.x = 62
        soul.y = 273 + (player.ii * 38)

        if key_state.down.just_pressed then
            player.ii = (player.ii + 1) % enemy.amount
            sounds["squeak"]:play()
        end
        if key_state.up.just_pressed then
            player.ii = (player.ii - 1) % enemy.amount
            sounds["squeak"]:play()
        end

        if key_state.x.just_pressed then
            player.ii = 0
            player.iii = 0
                table.insert(writers, typewriter.new(
                55, 268,
                enemy.flavour_texts[enemy.turn] or "* Dude, where's my text?",
                fonts["determination-mono"],
                sounds["speak1"] 
                ))
        end
    elseif player.iii == "button3" then
        soul.x = 62
        soul.y = 273 + (player.ii * 38)

        local flee_num = enemy.flee_able and 2 or 1

        if key_state.down.just_pressed then
            player.ii = (player.ii + 1) % flee_num
            if enemy.flee_able then
                sounds["squeak"]:play()
            end
        end
        if key_state.up.just_pressed then
            player.ii = (player.ii - 1) % flee_num
            if enemy.flee_able then
                sounds["squeak"]:play()
            end
        end

        if key_state.x.just_pressed then
            player.ii = 0
            player.iii = 0
                table.insert(writers, typewriter.new(
                55, 268,
                enemy.flavour_texts[enemy.turn] or "* Dude, where's my text?",
                fonts["determination-mono"],
                sounds["speak1"] 
                ))
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

    attacks.update(i)

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

    if enemy.kr == 1 then
        love.graphics.print("kr", 282 + player.mhp * 1.2, 406)
    end

    love.graphics.setFont(fonts["crypto'morrow"])
    love.graphics.print(player.hp .. " / " .. player.mhp, 342 + (player.mhp * 1.2) * enemy.kr, 403)

    love.graphics.setColor(255/255, 0/255 ,100/255, 1)
    love.graphics.rectangle("fill", 275, 400, player.mhp * 1.2, 21)
    love.graphics.setColor(255/255, 214/255, 0)
    love.graphics.rectangle("fill", 275, 400, player.hp * 1.2, 21)

end

local function draw_soul()
    love.graphics.setColor(255/255, 0/255 ,100/255, 1)
    love.graphics.draw(soul.image, soul.x, soul.y, soul.rotation, 2, 2)
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
    love.graphics.setColor(1, 1, 1)
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

local function draw_text()
    love.graphics.setColor(1, 1, 1)

    if player.iii == "button0" or player.iii == "button1" then
        love.graphics.setFont(fonts["determination-mono"])

        for i = 1, enemy.amount do
            local e = enemy[i == 1 and "one" or i == 2 and "two" or "three"]
            local y = 268 + (i - 1) * 38

            if e.alive then
                local color = {1, 1, 1}
                if e.mercy_percent >= e.mercy_max then
                    color = {255/255, 183/255, 197/255}
                end
                love.graphics.setColor(color)
                love.graphics.print("* " .. e.name, 100, y)
            else
                love.graphics.setColor(1, 1, 1, 0.5)
                love.graphics.print("* Deceased", 100, y)
            end

            love.graphics.setColor(1, 1, 1)
        end

        if player.iii == "button0" then
            for i = 1, enemy.amount do
                local e = enemy[i == 1 and "one" or i == 2 and "two" or "three"]
                local y = 272 + (i - 1) * 38
                local bar_width = e.hp / e.mhp

                love.graphics.setColor(255/255, 0/255, 100/255, 1)
                love.graphics.rectangle("fill", 410, y, 110, 19)

                love.graphics.setColor(60/255, 203/255, 128/255, 1)
                love.graphics.rectangle("fill", 410, y, bar_width * 110, 19)

                love.graphics.setColor(1, 1, 1)
                love.graphics.setFont(fonts["crypto'morrow"])
                love.graphics.print(math.floor(bar_width * 100) .. "%", 526, y + 1)
            end
        end
    end

    if player.iii == "button3" then 
        love.graphics.setFont(fonts["determination-mono"])

        love.graphics.setColor(1, 1, 1)
        if enemy.one.mercy_percent >= enemy.one.mercy_max or enemy.two.mercy_percent >= enemy.two.mercy_max or enemy.three.mercy_percent >= enemy.three.mercy_max then
            love.graphics.setColor(255/255, 183/255, 197/255)
        end
        love.graphics.print("* Spare", 100, 268)

        if enemy.flee_able then
            love.graphics.print("* Flee", 100, 268 + 38)
        end
    end

    if writers then
        for _, w in ipairs(writers) do
            if w and w.draw then w:draw() end
        end
    end
end

function battle_engine.draw(i) -- i = dt
    draw_action_ui()
    draw_hp()
    enemy.draw(i)
    draw_bullet_box()
    draw_text()

    attacks.draw(i)
    draw_soul()
end

return battle_engine