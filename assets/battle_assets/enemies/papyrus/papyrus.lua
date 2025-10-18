-- template.lua your enemy template! good luck figuring it out...

local enemy = {}
local player_atk_var = {}

enemy.one = {
    name = "Papyrus",
    hp = 2600,
    mhp = 2600,
    at = 80,
    df = 60,
    x = nil,
    y = nil,
    alive = true,
    dodge = true,
    mercy_percent = 0,
    mercy_max = 999,
    current_anim = "intense",
    default_anim = "idle"
}

enemy.two = {
    name = "Romance",
    hp = 200,
    mhp = 200,
    at = 5,
    df = 5,
    x = nil,
    y = nil,
    alive = true,
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
    alive = true,
    dodge = true,
    mercy_percent = 0,
    mercy_max = 99,
    current_anim = "static",
    default_anim = "static,"
}

local function load_images() -- load the sprites here!
    enemy.reference = love.graphics.newImage("assets/battle_assets/enemies/papyrus/images/reference.png")
    enemy.background = love.graphics.newImage("assets/battle_assets/enemies/papyrus/images/background.png")
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
    enemy.music = love.audio.newSource("assets/battle_assets/music/odd_water.mp3", "stream")
    enemy.music:setLooping(true)

    enemy.one.x = 320
    enemy.one.y = 130

    enemy.two.x = 320
    enemy.two.y = 150

    enemy.three.x = 540
    enemy.three.y = 150

    enemy.kr = 0 -- 1 or 0 (1 meaning yeah, 0 meaning nah)

    enemy.flee_chance = "random"
    enemy.flee_able = true

    enemy.amount = 1 -- your... enemy amount? yeah, dude. don't lie to the code.
    
    enemy.fight_to_progress = false -- you sans fight people will like this.

    -- okay. don't change anything under here.
    
end

function enemy.load()
    load_custom_variables()
    load_images()

    enemy.turn = 1 -- current turn, only use 0 if you want the enemy to have the first turn.
    enemy.flavour_font = fonts["sans2"]
    enemy.flavour_texts = {
    "* WHAT'S GOTTEN INTO HIM?!",
    }
end

function enemy.update(i) --i = dt
    if not enemy.music:isPlaying() then
            enemy.music:play()
    end

end

function enemy.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(enemy.background, 0, -20, 0, 2, 2)
    if enemy.one.alive then
        love.graphics.draw(enemy.reference, enemy.one.x - enemy.reference:getWidth(), enemy.one.y - enemy.reference:getHeight(), 0, 2, 2)
    end
end


return enemy