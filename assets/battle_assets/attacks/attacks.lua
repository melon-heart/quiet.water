-- attacks.lua, i recommend not touching this script.
local attacks = {}
local tough_glove = {}
local enemy = nil

local function load_enemy() -- thanks to Asuls!
    local enemy_module = ("assets.battle_assets.enemies." .. scene.ii .. "." .. scene.ii)
    package.loaded[enemy_module] = nil
    return require(enemy_module)
end

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

    enemy = load_enemy()
    if enemy and enemy.load then
        enemy.load()
    end

    attacks.x = 0
    attacks.y = 0
    attacks.spawned = false

    tough_glove.press = love.graphics.newImage("assets/battle_assets/attacks/press.png")
    tough_glove.z = love.graphics.newImage("assets/battle_assets/attacks/Z.png")
    tough_glove.image = love.graphics.newImage("assets/battle_assets/attacks/tough_glove.png") -- should be quads of 50x110y
    tough_glove.timer = 0
    tough_glove.phase = "press_z"
    tough_glove.amount_pressed = 0
    tough_glove.offset = {0, 0}

    tough_glove_quantise()
end

function attacks.update(i) -- i = dt

    if love.keyboard.isDown(1) then -- just for testing
        attacks.spawned = true
    end

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
    if attacks.spawned then
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
        end
    elseif tough_glove.phase == "flash" then
        tough_glove.timer = tough_glove.timer + i * 8
        if tough_glove.timer >= 3 then
            tough_glove.phase = "press_z"
            tough_glove.timer = 0
            tough_glove.amount_pressed = 0
            attacks.spawned = false
        end
    elseif tough_glove.phase == "press_z" then
        tough_glove.timer = tough_glove.timer + i
        if key_state.z.just_pressed then
            tough_glove.offset = { math.random(-50, 50), math.random(-50, 50)}
            tough_glove.amount_pressed = tough_glove.amount_pressed + 1
            sounds["punchweak"]:clone():play()
        end
        if tough_glove.timer >= 1 or tough_glove.amount_pressed >= 5 then
            tough_glove.phase = "fist"
            tough_glove.timer = 0
        end
    end
    end
end

function attacks.draw(i) -- i = dt  
    -- testing
    if attacks.spawned then
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
