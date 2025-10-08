-- undyne.lua (will be the base for any enemy... heh) still very much a WIP

local enemy = {}
local reference = nil

local function load_images() -- load the sprites here!
    enemy.head = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/head.png")
    enemy.torso = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/torso.png")
    enemy.arms = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/arms.png")
    enemy.hands_and_spear = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/hands_and_spear.png")      
    enemy.legs = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/legs.png")
    enemy.skirt = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/skirt.png")
    enemy.ponytail = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/pony_tail_quads.png")

    enemy.ponytail_quads = {}
    local quad_w, quad_h = 39, 26
    local img_w, img_h = enemy.ponytail:getWidth(), enemy.ponytail:getHeight()
    local cols = math.floor(img_w / quad_w)
    local rows = math.floor(img_h / quad_h)
    for row = 0, rows - 1 do
        for col = 0, cols - 1 do
            local x = col * quad_w
            local y = row * quad_h
            table.insert(enemy.ponytail_quads, love.graphics.newQuad(x, y, quad_w, quad_h, img_w, img_h))
        end
    end
end

local function load_custom_variables() -- this is for what you'll animate or something...
    enemy.ponytail_frame = 1
    enemy.ponytail_timer = 0
    enemy.ponytail_interval = 0.2
    enemy.animation_timer = 0
end

function enemy.load()
    reference = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/reference.png") -- this is your reference when you uhh start animating enemy
    load_custom_variables()
    load_images()

    enemy.turn = 1 -- current turn, only use 0 if you want the enemy to have the first turn.
    enemy.flavour_texts = {
    "* For the /c[255,0,0]world/n/s[0.1]  or something.",
    "* Undyne is here!\n* She looks very determined.",
    "* Undyne is here!\n* She looks even more determined.",
    "* Undyne is here!\n* She looks extremely determined.",
    "* Undyne is here!\n* She looks super ultra mega determined.",
    }
end

function enemy.update(i) --i = dt
    enemy.animation_timer = enemy.animation_timer + i
    enemy.ponytail_timer = enemy.ponytail_timer + i
    if enemy.ponytail_timer >= enemy.ponytail_interval then
        enemy.ponytail_timer = enemy.ponytail_timer - enemy.ponytail_interval
        enemy.ponytail_frame = enemy.ponytail_frame + 1
        if enemy.ponytail_frame > #enemy.ponytail_quads then
            enemy.ponytail_frame = 1
        end
    end
end

function enemy.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(enemy.legs, 335 - enemy.legs:getWidth(), 207 - enemy.legs:getHeight(), 0, 2, 2)
    love.graphics.draw(enemy.skirt, 340 - math.sin(enemy.animation_timer) * 1 - enemy.skirt:getWidth(), 155 + math.sin(enemy.animation_timer) * 1 - enemy.skirt:getHeight(), 0 + math.sin(enemy.animation_timer) * 0.02, 2, 2)
    love.graphics.draw(enemy.torso, 338 - enemy.torso:getWidth(), 105 + math.sin(enemy.animation_timer) * 3 - enemy.torso:getHeight(), 0 + math.cos(enemy.animation_timer) * 0.02, 2, 2)
    love.graphics.draw(enemy.ponytail, enemy.ponytail_quads[enemy.ponytail_frame], 342 + math.cos(enemy.animation_timer) * 2 - enemy.ponytail:getWidth(), 51 - enemy.ponytail:getHeight(), 0, 2, 2)
    love.graphics.draw(enemy.head, 320 + math.cos(enemy.animation_timer) * 2 - enemy.head:getWidth(), 61 + math.sin(enemy.animation_timer) * 3 - enemy.head:getHeight(), 0 + math.cos(enemy.animation_timer) * 0.02, 2, 2)
    love.graphics.draw(enemy.arms, 342 + math.sin(enemy.animation_timer) * 3  - enemy.arms:getWidth(), 127 + math.sin(enemy.animation_timer) * 3 - enemy.arms:getHeight(), 0 + math.cos(enemy.animation_timer) * 0.02, 2, 2)
    love.graphics.draw(enemy.hands_and_spear, 323 + math.sin(enemy.animation_timer) * 3  - enemy.hands_and_spear:getWidth(), 134 + math.sin(enemy.animation_timer) * 2 - enemy.hands_and_spear:getHeight(), 0 + math.cos(enemy.animation_timer) * 0.02, 2, 2)
end


return enemy