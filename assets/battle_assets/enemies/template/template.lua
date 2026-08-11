-- template.lua your enemy template! good luck figuring it out...

local enemy = {}

enemy.one = {
    name = "Drama",
    hp = 100,
    mhp = 200,
    at = 1,
    df = 1,
    x = nil,
    shake = 0,
    shake_value = 0,
    y = nil,
    alive = true,
    dodge = false,
    mercy_percent = 0,
    mercy_max = 10,
    current_anim = "static",
    default_anim = "static",
}

enemy.two = {
    name = "Romance",
    hp = 200,
    mhp = 200,
    at = 5,
    df = 5,
    x = nil,
    shake = 0,
    shake_value = 0,
    y = nil,
    alive = true,
    dodge = false, 
    mercy_percent = 10,
    mercy_max = 10,
    current_anim = "static",
    default_anim = "static",
}

enemy.three = {
    name = "Bloodshed",
    hp = 1,
    mhp = 1,
    at = 5,
    df = 5,
    x = nil,
    shake = 0,
    shake_value = 0,
    y = nil,
    alive = true,
    dodge = true,
    mercy_percent = 0,
    mercy_max = 99,
    current_anim = "static",
    default_anim = "static",
}

local function load_images() -- load the sprites here!
    enemy.dummy0 = love.graphics.newImage("assets/battle_assets/enemies/template/images/dummy0.png")
        enemy.dummy1 = love.graphics.newImage("assets/battle_assets/enemies/template/images/dummy1.png")
            enemy.dummy2 = love.graphics.newImage("assets/battle_assets/enemies/template/images/dummy2.png")
end

local function resolve_target(self, target_or_index)
    if type(target_or_index) == "number" then
        local names = {"one", "two", "three"}
        local name = names[target_or_index + 1]
        if name and self[name] then
            return self[name]
        end
        return nil
    end

    return target_or_index
end

function enemy.prepare_for_damage(self, target_or_index)
    local target = resolve_target(self, target_or_index)
    if not target then
        return
    end

    if target.dodge then
        target.current_anim = target.current_anim
    else
        target.current_anim = "shake"
        target.shake_value = 1
    end
end

function enemy.hurt_enemy(self, target_or_index, ii) -- ii = player damage
    local target = resolve_target(self, target_or_index)
    if not target then
        return
    end
    
    if ii ~= "missed" then
        if target.dodge then
            target.current_anim = "dodge"
            target.shake_value = 100 * (math.random(0, 1) == 0 and -1 or 1)
        else
            target.current_anim = "hurt"
            target.shake_value = 50
            target.hp = target.hp - ii
        end
    else
        target.current_anim = target.default_anim
        target.shake_value = 0
    end
end

local function load_custom_variables() -- load everything you need here
    enemy.music = love.audio.newSource("assets/battle_assets/music/odd_water.mp3", "stream")
    enemy.music:setLooping(true)

    enemy.one.x = 100
    enemy.one.y = 150

    enemy.two.x = 320
    enemy.two.y = 150

    enemy.three.x = 540
    enemy.three.y = 150

    enemy.kr = 0 -- 1 or 0 (1 meaning yeah, 0 meaning nah)

    enemy.flee_chance = "random"
    enemy.flee_able = true

    enemy.amount = 3 -- your... enemy amount? yeah, dude. don't lie to the code.
    
    enemy.fight_to_progress = false -- you sans fight people will like this.

    -- okay. don't change anything under here.

    enemy.dodge_timer = 0 
    
end

function enemy.load()
    load_custom_variables()
    load_images()

    enemy.turn = 1 -- current turn, only use 0 if you want the enemy to have the first turn.
    enemy.flavour_font = fonts["determination-mono"]
    enemy.flavour_texts = "turn" -- random or turn
    enemy.flavour_texts = {
    "* Template dummies./w/w/n* Turn 1", -- /w means wait a little, and /n means new line
    "* They like... hate you?/w/w/n* Maybe not Romance./w/w/n* Turn 2",
    "* Woah./w/w/n* Turn 3",
    "* Here for your liver./w/w/n* Turn 4"
    }
end

function enemy.update(i) --i = dt
    if not enemy.music:isPlaying() then
        if enemy.music then
            enemy.music:play()
        end
    end

    -- this handles damage animations!
    for _, target in ipairs({enemy.one, enemy.two, enemy.three}) do
        if target.current_anim == "shake" then
            target.shake = math.sin(love.timer.getTime() * 50) * target.shake_value
        end
        if target.current_anim == "hurt" then   
            target.shake = math.sin(love.timer.getTime() * 50) * target.shake_value
            target.shake_value = target.shake_value + (0 - target.shake_value) * i * 5
        end
        if target.current_anim == "dodge" then
            enemy.dodge_timer = enemy.dodge_timer + i

            local duration = 0.7 -- how long you want the dodge to take
            local t = math.min(enemy.dodge_timer / duration, 1)

            target.shake = math.sin(t * math.pi) * target.shake_value

            if t >= 1 then
                target.shake = 0
                target.current_anim = target.default_anim
                enemy.dodge_timer = 0
            end
        end
    end
end

function enemy.draw()
    love.graphics.setColor(1, 1, 1, 1)
    if enemy.one.alive then
        love.graphics.draw(enemy.dummy0, enemy.one.x - enemy.dummy0:getWidth() + enemy.one.shake, enemy.one.y - enemy.dummy0:getHeight(), 0, 2, 2)
    end

    if enemy.two.alive then
        love.graphics.draw(enemy.dummy1, enemy.two.x - enemy.dummy1:getWidth() + enemy.two.shake, enemy.two.y - enemy.dummy1:getHeight(), 0, 2, 2)
    end

    if enemy.three.alive then
        love.graphics.draw(enemy.dummy2, enemy.three.x - enemy.dummy2:getWidth() + enemy.three.shake, enemy.three.y - enemy.dummy2:getHeight(), 0, 2, 2)
    end
end

return enemy