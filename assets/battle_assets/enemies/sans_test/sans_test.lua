-- template.lua your enemy template! good luck figuring it out...

local enemy = {}
local player_atk_var = {}

enemy.one = {
    name = "Sans",
    hp = 25,
    mhp = 25,
    at = 5,
    df = 3,
    x = nil,
    y = nil,
    alive = true,
    dodge = true,
    mercy_percent = 0,
    mercy_max = 10,
    current_anim = "idle",
    default_anim = "static,"
}

enemy.two = {
    name = "Romance",
    hp = 200,
    mhp = 200,
    at = 5,
    df = 5,
    x = nil,
    y = nil,
    alive = false,
    dodge = false, 
    mercy_percent = 0,
    mercy_max = 10,
    current_anim = "static",
    default_anim = "static,"
}


enemy.three = {
    name = "Bloodshed",
    hp = 1,
    mhp = 1,
    at = 5,
    df = 5,
    x = nil,
    y = nil,
    alive = false,
    dodge = true,
    mercy_percent = 0,
    mercy_max = 99,
    current_anim = "static",
    default_anim = "static,"
}

local function load_images() -- load the sprites here!
    enemy.ref = love.graphics.newImage("assets/battle_assets/enemies/sans_test/images/ref.png")
    enemy.head_1 = love.graphics.newImage("assets/battle_assets/enemies/sans_test/images/head_1.png")
    enemy.torso_1 = love.graphics.newImage("assets/battle_assets/enemies/sans_test/images/torso_1.png")
    enemy.legs = love.graphics.newImage("assets/battle_assets/enemies/sans_test/images/legs.png")
end

local function hurt_enemy(i, ii) -- i = target
    if i.dodge then
        i.current_anim = "dodge"
    else
        i.current_anim = "hurt"
        i.hp = i.hp - ii
    end
end

function enemy.spawn_player_attack(i, ii) -- this handles the player attack, and its consequences.
    -- pretend there's stuff here
    hurt_enemy(i, ii)
end

local function load_custom_variables() -- load everything you need here
    enemy.music = love.audio.newSource("assets/battle_assets/music/aebftcgat.ogg", "stream")
    enemy.music:setLooping(true)

    enemy.timer = 0

    enemy.one.x = 320
    enemy.one.y = 160

    enemy.two.x = 320
    enemy.two.y = 150

    enemy.three.x = 540
    enemy.three.y = 150

    enemy.kr = 0 -- 1 or 0 (1 meaning yeah, 0 meaning nah)

    enemy.flee_chance = "random"
    enemy.flee_able = false

    enemy.amount = 1 -- your... enemy amount? yeah, dude. don't lie to the code.
    
    enemy.fight_to_progress = false -- you sans fight people will like this.

    -- okay. don't change anything under here.
    
end

function enemy.load()
    load_custom_variables()
    load_images()

    enemy.turn = 1 -- current turn, only use 0 if you want the enemy to have the first turn.
    enemy.flavour_font = fonts["determination-mono"]
    enemy.flavour_texts = "set" -- or random
    enemy.flavour_texts = {
    "* Sans prepares an attack!",
    "* They like... hate you?/w/w/n* Turn 2",
    "* Woah./w/w/n* Turn 3",
    "* Here for your liver./w/w/n* Turn 4"
    }
end

function enemy.update(i) --i = dt
    if not enemy.music:isPlaying() then
            enemy.music:play()
    end

    enemy.timer = (enemy.timer or 0) + i
end

function enemy.draw()
    love.graphics.setColor(1, 1, 1, 0.3)
    if enemy.one.alive then
        love.graphics.setColor(1, 1, 1, 1)
        if enemy.one.current_anim == "static" then

            love.graphics.draw(enemy.legs, enemy.one.x - enemy.legs:getWidth() - 7, enemy.one.y - enemy.legs:getHeight() + 44, 0, 2, 2)

            love.graphics.draw(enemy.head_1, enemy.one.x - enemy.head_1:getWidth() - 1, enemy.one.y - enemy.head_1:getHeight() - 44, 0, 2, 2)

            love.graphics.draw(enemy.torso_1, enemy.one.x - enemy.torso_1:getWidth() + 5, enemy.one.y - enemy.torso_1:getHeight() - 2, 0, 2, 2)
        end

        if enemy.one.current_anim == "idle" then

            love.graphics.draw(enemy.legs, enemy.one.x - enemy.legs:getWidth() - 7, enemy.one.y - enemy.legs:getHeight() + 44, 0, 2, 2)

            love.graphics.draw(enemy.head_1, enemy.one.x - enemy.head_1:getWidth() - 1  + math.cos(enemy.timer * 1.5) * 3, enemy.one.y - enemy.head_1:getHeight() - 44 + math.cos(enemy.timer * 3) * 1 , 0, 2, 2)

            love.graphics.draw(enemy.torso_1, enemy.one.x - enemy.torso_1:getWidth() + 5  + math.cos(enemy.timer * 1.5) * 2, enemy.one.y - enemy.torso_1:getHeight() - 2, 0 + math.sin(enemy.timer * 1.5) * 0.02, 2, 2 + math.sin(enemy.timer * 1.5) * 0.02)
        end

    end
end


return enemy