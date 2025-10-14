love.graphics.setDefaultFilter('nearest', 'nearest')

player = require("player")
key_state = require("assets.key_state")

battle_engine = require("assets.battle_engine")
overworld_engine = require("assets.overworld_engine")

typewriter = require("assets.typewriter")
writers = {}

soul = {}

scene = {
    i = "battle", -- this is the current scene
    ii = "template", -- this is the enemy currently loaded
    iii = "0", -- this is the map currently loaded
    iv = false -- this has no meaning yet.
}

fonts = {}
sounds = {}

function love.load()
    fonts["8bitoperator_jve"] = love.graphics.newFont("assets/fonts/8bitoperator_jve.ttf", 32)
    fonts["dotumche"] = love.graphics.newFont("assets/fonts/dotumche.ttf")
    fonts["determination-mono"] = love.graphics.newFont("assets/fonts/determination-mono.ttf", 32)
    fonts["crypto'morrow"] = love.graphics.newFont("assets/fonts/crypto'morrow.ttf", 15)
    fonts["papyrus"] = love.graphics.newFont("assets/fonts/papyrus.ttf")
    fonts["hachicro"] = love.graphics.newFont("assets/fonts/hachicro.ttf")
    fonts["hp"] = love.graphics.newFont("assets/fonts/hp.ttf", 10)
    fonts["sans"] = love.graphics.newFont("assets/fonts/sans.ttf")
    fonts["ja_JF-Dot-Shinonome14"] = love.graphics.newFont("assets/fonts/ja/JF-Dot-Shinonome14.ttf")
    fonts["ja_TanukiMagic"] = love.graphics.newFont("assets/fonts/ja/TanukiMagic.ttf")

    sounds["speak0"] = love.audio.newSource("assets/sounds/v_generic1.ogg", "static") 
    sounds["speak1"] = love.audio.newSource("assets/sounds/v_generic2.ogg", "static") 
    sounds["squeak"] = love.audio.newSource("assets/sounds/snd_squeak.ogg", "static") 
    sounds["select"] = love.audio.newSource("assets/sounds/snd_select.ogg", "static")
    sounds["punchstrong"] = love.audio.newSource("assets/sounds/snd_punchstrong.wav", "static") 
    sounds["punchweak"] = love.audio.newSource("assets/sounds/snd_punchweak.wav", "static")
    
    soul.image = love.graphics.newImage("assets/images/soul.png")
    soul.x = 0
    soul.y = 0
    soul.rotation = 0

    if player and player.load then player.load() end
    if battle_engine and battle_engine.load then battle_engine.load() end
end

function love.update(dt)
    key_state.update(dt)

    if scene.i == "battle" then
        battle_engine.update(dt)
    elseif scene.i == "overworld" then
        if overworld_engine and overworld_engine.update then
            overworld_engine.update(dt)
        end
    end
end

local function gradient()

    local top_color = {70/255, 200/255, 220/255}    
    local bottom_color = {0/255, 50/255, 100/255}


    local width, height = love.graphics.getDimensions()

    local gradient_mesh = love.graphics.newMesh({
        {0, 0,        0, 0, top_color[1], top_color[2], top_color[3], 1},
        {width, 0,     1, 0, top_color[1], top_color[2], top_color[3], 1},
        {width, height,1, 1, bottom_color[1], bottom_color[2], bottom_color[3], 1},
        {0, height,    0, 1, bottom_color[1], bottom_color[2], bottom_color[3], 1},
    }, "fan")

    love.graphics.draw(gradient_mesh)
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    gradient()
    -- love.graphics.draw(love.graphics.newImage("8.png"))
    if scene.i == "battle" then
        battle_engine.draw()
    elseif scene.i == "overworld" then
        if overworld_engine and overworld_engine.draw then
            overworld_engine.draw()
        end
    end
end

