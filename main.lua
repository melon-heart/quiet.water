love.graphics.setDefaultFilter('nearest', 'nearest')

player = require("player")

battle_engine = require("assets.battle_engine")
--overworld_engine = require("assets.overworld_engine")

scene = {
    i = "battle", -- this is the current scene
    ii = "0", -- this is the enemy currently loaded
    iii = "0", -- this is the map currently loaded
    iv = false -- this has no meaning yet.
}

fonts = {}

function love.load()
    fonts["8bitoperator_jve"] = love.graphics.newFont("assets/fonts/8bitoperator_jve.ttf")
    fonts["dotumche"] = love.graphics.newFont("assets/fonts/dotumche.ttf")
    fonts["determination-mono"] = love.graphics.newFont("assets/fonts/determination-mono.ttf")
    fonts["crypto'morrow"] = love.graphics.newFont("assets/fonts/crypto'morrow.ttf")
    fonts["papyrus"] = love.graphics.newFont("assets/fonts/papyrus.ttf")
    fonts["hachicro"] = love.graphics.newFont("assets/fonts/hachicro.ttf")
    fonts["hp"] = love.graphics.newFont("assets/fonts/hp.ttf")
    fonts["sans"] = love.graphics.newFont("assets/fonts/sans.ttf")
    fonts["ja_JF-Dot-Shinonome14"] = love.graphics.newFont("assets/fonts/ja/JF-Dot-Shinonome14.ttf")
    fonts["ja_TanukiMagic"] = love.graphics.newFont("assets/fonts/ja/TanukiMagic.ttf")
    -- initialize player and engines that need the graphics context
    if player and player.load then player.load() end
    if battle_engine and battle_engine.load then battle_engine.load() end
end

function love.update(dt)
    if scene.i == "battle" then
        battle_engine.update(dt)
    elseif scene.i == "overworld" then
        if overworld_engine and overworld_engine.update then
            overworld_engine.update(dt)
        end
    end
end

function love.draw()
    love.graphics.clear(0/255, 80/255, 80/255)
    -- love.graphics.draw(love.graphics.newImage("8.png"))
    if scene.i == "battle" then
        battle_engine.draw()
    elseif scene.i == "overworld" then
        if overworld_engine and overworld_engine.draw then
            overworld_engine.draw()
        end
    end
end