-- undyne.lua (will be the base for any enemy... heh) still very much a WIP

local enemy = {}
local reference = nil

function enemy.load()
    reference = love.graphics.newImage("assets/battle_assets/enemies/undyne/images/reference.png")
end

function enemy.draw()
    love.graphics.setColor(1, 1, 1, 1)
    if reference then
        love.graphics.draw(reference, 320 - reference:getWidth(), 130 - reference:getHeight(), 0, 2, 2)
    end
end

return enemy