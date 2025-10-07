love.graphics.setDefaultFilter('nearest', 'nearest')

battle_engine = require("assets.battle_engine")
--overworld_engine = require("assets.overworld_engine")
player = require("player")

scene = {
    i = "battle", -- this is the current scene
    ii = "0", -- this is the enemy currently loaded
    iii = "0", -- this is the map currently loaded
    iv = false -- this has no meaning yet.
}

function love.update(dt)
    if scene.i == "battle" then
        battle_engine.update(dt)
    elseif scene.i == "overworld" then
        overworld_engine.update(dt)
    end
end

function love.draw()
    -- love.graphics.draw(love.graphics.newImage("8.png"))
    if scene.i == "battle" then
        battle_engine.draw()
    elseif scene.i == "overworld" then
        overworld_engine.draw()
    end
end