-- undyne.lua (will be the base for any enemy... heh) still very much a WIP

local enemy = {}
local reference = nil

enemy.one = {
    name = "Dummy_0",
    hp = 1,
    at = 10,
    df = 10,
    x = nil,
    y = nil,
    alive = true,
}

enemy.two = {
    name = "Dummy_1",
    hp = 200,
    at = 5,
    df = 5,
    x = nil,
    y = nil,
    alive = true,
}


enemy.three = {
    name = "Dummy_2",
    hp = 200,
    at = 5,
    df = 5,
    x = nil,
    y = nil,
    alive = true,
}

local function load_images() -- load the sprites here!
    enemy.dummy0 = love.graphics.newImage("assets/battle_assets/enemies/template/images/dummy0.png")
        enemy.dummy1 = love.graphics.newImage("assets/battle_assets/enemies/template/images/dummy1.png")
            enemy.dummy2 = love.graphics.newImage("assets/battle_assets/enemies/template/images/dummy2.png")
end

local function load_custom_variables() -- this is for what you'll animate or something...
    -- enemy.music = love.audio.newSource("assets/battle_assets/music/dummy_song.ogg", "stream")
    --enemy.music:setLooping(true)

    enemy.one.x = 100
    enemy.one.y = 150

    enemy.two.x = 320
    enemy.two.y = 150

    enemy.three.x = 540
    enemy.three.y = 150
end

function enemy.load()
    load_custom_variables()
    load_images()

    enemy.turn = 1 -- current turn, only use 0 if you want the enemy to have the first turn.
    enemy.flavour_texts = {
    "* Template enemies.",
    "* They like... hate you?",
    "* Woah."
    }
end

function enemy.update(i) --i = dt
    --if not enemy.music:isPlaying() then
    --        enemy.music:play()
    --end

end

function enemy.draw()
    love.graphics.setColor(1, 1, 1, 1)
    if enemy.one.alive then
        love.graphics.draw(enemy.dummy0, enemy.one.x - enemy.dummy0:getWidth(), enemy.one.y - enemy.dummy0:getHeight(), 0, 2, 2)
    end

    if enemy.two.alive then
        love.graphics.draw(enemy.dummy1, enemy.two.x - enemy.dummy1:getWidth(), enemy.two.y - enemy.dummy1:getHeight(), 0, 2, 2)
    end

    if enemy.three.alive then
        love.graphics.draw(enemy.dummy2, enemy.three.x - enemy.dummy2:getWidth(), enemy.three.y - enemy.dummy2:getHeight(), 0, 2, 2)
    end
end


return enemy