-- attacks.lua, i recommend not touching this script.
local attacks = {}
local bullseye = {}
local tough_glove = {}
local slash = {}
local enemy = nil
local damage = {}

local function make_quads(image, frame_width, frame_height)
    local image_width, image_height = image:getDimensions()
    local quads = {}

    for y = 0, image_height - frame_height, frame_height do
        for x = 0, image_width - frame_width, frame_width do
            quads[#quads + 1] = love.graphics.newQuad(x, y, frame_width, frame_height, image_width, image_height)
        end
    end

    return quads
end

local function get_hit_multiplier()
    local target_x = bullseye.x or 320
    local distance_from_center = math.abs(target_x - 320)
    local max_distance = 320
    return math.max(0, 1 - (distance_from_center / max_distance))
end

function attacks.load(i) -- i = enemy instance

    -- i don't know why you'd want to edit this... but if you truly wish to, please go ahead.

    enemy = i

    attacks.x = 0
    attacks.y = 0
    attacks.spawned = false
    attacks.phase = "target"

    bullseye.bullseye = love.graphics.newImage("assets/battle_assets/attacks/bullseye.png")
    bullseye.bar = love.graphics.newImage("assets/battle_assets/attacks/bar.png") -- should be quads of 14x128y
    bullseye.timer = 0
    bullseye.x = 0 
    bullseye.pressed = false 
    bullseye.open = false
    bullseye.bar_side = "left" -- or right blegh
    bullseye.stage = "closed"

    bullseye.quads = make_quads(bullseye.bar, 14, 128)

    tough_glove.press = love.graphics.newImage("assets/battle_assets/attacks/press.png")
    tough_glove.z = love.graphics.newImage("assets/battle_assets/attacks/Z.png")
    tough_glove.image = love.graphics.newImage("assets/battle_assets/attacks/tough_glove.png") -- should be quads of 50x110y
    tough_glove.timer = 0
    tough_glove.phase = "press_z"
    tough_glove.amount_pressed = 0
    tough_glove.offset = {0, 0}

    tough_glove.quads = make_quads(tough_glove.image, 50, 110)

    slash.image = love.graphics.newImage("assets/battle_assets/attacks/slash.png") -- should be quads of 31x110y
    slash.timer = 0

    slash.quads = make_quads(slash.image, 31, 110)
end

function attacks.update(i) -- i = dt

    --if love.keyboard.isDown(1) then -- just for testing
    --    attacks.spawned = true
    --end

    if player.ii == 0 then 
        attacks.x = enemy.one.x
        attacks.y = enemy.one.y
    elseif player.ii == 1 then
        attacks.x = enemy.two.x
        attacks.y = enemy.two.y
    elseif player.ii == 2 then
        attacks.x = enemy.three.x
        attacks.y = enemy.three.y
    end

    if player.iii == "aim" then
        if bullseye.open == false then
            bullseye.open = true
            bullseye.timer = 0
            bullseye.stage = "open"
        end

        if bullseye.stage == "open" then
            bullseye.timer = bullseye.timer + i
        elseif bullseye.stage == "closing" or bullseye.stage == "missed" then
            bullseye.timer = bullseye.timer - i
            if bullseye.timer <= 0 then
                bullseye.stage = "closed"
                bullseye.open = false
                bullseye.pressed = false
                bullseye.timer = 0
                player.iii = "enemy_dialogue"
            end
        end

        if key_state.z.just_pressed and bullseye.stage == "open" then
            bullseye.pressed = true
            if player.weapon then
                attacks.spawned = true
            end
            enemy:prepare_for_damage(player.ii)
        end

    else
        bullseye.open = false
        bullseye.pressed = false
    end

    if bullseye.open then
        if not bullseye.pressed and bullseye.stage == "open" then
            if bullseye.bar_side == "left" then
                bullseye.x = 38 + (562 * (bullseye.timer * 2) / 3)
                if bullseye.x > 640 then
                    bullseye.stage = "missed"
                end
            elseif bullseye.bar_side == "right" then
                bullseye.x = 628 - (38 + (562 * (bullseye.timer * 2) / 3))
                if bullseye.x < -14 then
                    bullseye.stage = "missed"
                end
            end
        end
    end

    if attacks.spawned then

        if player.weapon == "stick" or player.weapon == "toy_knife" or player.weapon == "real_knife" then
            if slash.timer < 5.9 then
                slash.timer = slash.timer + i * 12
                if slash.timer >= 5.9 then
                    slash.timer = 5.9
                end
            else
                attacks.spawned = false
                slash.timer = 0
                local target_enemy = ({ enemy.one, enemy.two, enemy.three })[player.ii + 1]
                hit_mult = get_hit_multiplier()
                local damage = player.calc_damage(target_enemy and target_enemy.df or 0, hit_mult)
                enemy:hurt_enemy(player.ii, damage)
                bullseye.stage = "closing"
            end
        end

        if player.weapon == "tough_glove" then
            if tough_glove.phase == "fist" then
                tough_glove.timer = tough_glove.timer + i * 8
                if tough_glove.timer >= 3.2 then 
                    tough_glove.phase = "flash"
                    tough_glove.timer = 0
                    if tough_glove.amount_pressed >= 3 then
                        sounds["punchstrong"]:play()
                    else
                        sounds["punchweak"]:play()
                    end
                    local target_enemy = ({ enemy.one, enemy.two, enemy.three })[player.ii + 1]
                    local hit_mult = get_hit_multiplier()
                    local damage = player.calc_damage(target_enemy and target_enemy.df or 0, hit_mult)
                    enemy:hurt_enemy(player.ii, damage)
                    bullseye.stage = "closing"
                end
            elseif tough_glove.phase == "flash" then
                tough_glove.timer = tough_glove.timer + i * 8
                if tough_glove.timer >= 3 then
                    tough_glove.phase = "press_z"
                    tough_glove.timer = 0
                    tough_glove.amount_pressed = 0
                    attacks.spawned = false
                    tough_glove.offset = {0, 0}
                end
            elseif tough_glove.phase == "press_z" then
                tough_glove.timer = tough_glove.timer + i
                if key_state.z.just_pressed then
                    tough_glove.offset = { math.random(-50, 50), math.random(-50, 50)}
                    tough_glove.amount_pressed = tough_glove.amount_pressed + 1
                    sounds["punchweak"]:clone():play()
                end
                if tough_glove.timer >= 1 or tough_glove.amount_pressed >= 5 then
                    if tough_glove.timer >= 1 and tough_glove.amount_pressed <= 3 then
                        tough_glove.phase = "press_z"
                        tough_glove.timer = 0
                        tough_glove.amount_pressed = 0
                        attacks.spawned = false
                        tough_glove.offset = {0, 0}
                        bullseye.stage = "missed"
                        enemy:hurt_enemy(player.ii, "missed")
                    else
                        tough_glove.phase = "fist"
                        tough_glove.timer = 0
                    end
                end
            end
        end
    end
end

function attacks.draw(i) -- i = dt  
    -- testing
    if bullseye.open then
            local iw = bullseye.bullseye:getDimensions()
            local t = math.min(bullseye.timer * 2, 1)
            local scale = t * t * (3 - 2 * t)
        if bullseye.stage == "open" then
            love.graphics.setColor(1, 1, 1, scale + 0.1)
            love.graphics.draw(bullseye.bullseye, 38 + (562 / 2), 256, 0, scale, 1, iw / 2)
            love.graphics.setColor(1, 1, 1)
            if bullseye.pressed then
                love.graphics.draw(bullseye.bar, bullseye.quads[math.floor(bullseye.timer * 8 % 2) + 1], bullseye.x, 256)
            else
                love.graphics.draw(bullseye.bar, bullseye.quads[1], bullseye.x, 256)
            end
        elseif bullseye.stage == "closing" or bullseye.stage == "missed" then
            love.graphics.setColor(1, 1, 1, scale + 0.1)
            love.graphics.draw(bullseye.bullseye, 38 + (562 / 2), 256, 0, scale, 1, iw / 2)
            if bullseye.pressed then
                love.graphics.draw(bullseye.bar, bullseye.quads[math.floor(bullseye.timer * 8 % 2) + 1], bullseye.x, 256)
            else
                love.graphics.draw(bullseye.bar, bullseye.quads[1], bullseye.x, 256)
            end
        end
    end

    if attacks.spawned then
        if player.weapon == "stick" or player.weapon == "toy_knife" or player.weapon == "real_knife" then
            love.graphics.draw(slash.image, slash.quads[math.floor(slash.timer % 6) + 1], attacks.x - 30, attacks.y - 110, 0, 2, 2)
        end
        if player.weapon == "tough_glove" then
            if tough_glove.phase == "fist" then
                love.graphics.draw(tough_glove.image, tough_glove.quads[math.floor(tough_glove.timer % 3) + 1], attacks.x, attacks.y, 0, 2 + math.abs(math.sin(tough_glove.timer)), 2 + math.abs(math.sin(tough_glove.timer)), select(3, tough_glove.quads[1]:getViewport()) / 2, select(4, tough_glove.quads[1]:getViewport()) / 2)
            elseif tough_glove.phase == "flash" then
                love.graphics.draw(tough_glove.image, tough_glove.quads[math.floor(tough_glove.timer % 3) + 4], attacks.x - 50, attacks.y - 110, 0, 2, 2)
            elseif tough_glove.phase == "press_z" then
                love.graphics.draw(tough_glove.press, attacks.x - 22 + tough_glove.offset[1], attacks.y - 22 + tough_glove.offset[2])
                love.graphics.draw(tough_glove.z, attacks.x- 22 + tough_glove.offset[1] + math.random(-2, 2), attacks.y - 22 + tough_glove.offset[2] + math.random(-2, 2))
            end
        end
    end
end

return attacks
 --They can't see.      hide my eyes