love.graphics.setDefaultFilter('nearest', 'nearest')
player = require("player")
key_state = require("assets.key_state")
battle_engine = require("assets.battle_engine")
overworld_engine = require("assets.overworld_engine")
typewriter = require("assets.typewriter")
writers = {}
soul = {}
scene = {
    i = "battle",
    ii = "template", -- current enemy  
    iii = "template", -- idfk i actually forgot
    iv = false
}
fonts = {}
sounds = {}

local ripple = {
    shader  = nil,
    canvas  = nil,
    active  = false,
    elapsed = 0,
    duration = 2.5,
    speed          = 2.0,
    frequency      = 50.0,
    ripple_rate    = 2.0,
    rgb_strength   = 6.0,
    radius         = 0.5,
    amplitude      = 5,
}

function love.load()
    love.audio.setVolume(0.5)
    fonts["8bitoperator_jve"] = love.graphics.newFont("assets/fonts/8bitoperator_jve.ttf", 32)
    fonts["dotumche"] = love.graphics.newFont("assets/fonts/dotumche.ttf")
    fonts["determination-mono"] = love.graphics.newFont("assets/fonts/determination-mono.ttf", 32)
    fonts["crypto'morrow"] = love.graphics.newFont("assets/fonts/crypto'morrow.ttf", 16)
    fonts["papyrus"] = love.graphics.newFont("assets/fonts/papyrus.ttf")
    fonts["hachicro"] = love.graphics.newFont("assets/fonts/hachicro.ttf")
    fonts["hp"] = love.graphics.newFont("assets/fonts/hp.ttf", 10)
    fonts["sans"] = love.graphics.newFont("assets/fonts/sans.ttf", 16)
    fonts["sans2"] = love.graphics.newFont("assets/fonts/sans.ttf", 32)
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

    -- Ripple setup
    local w, h = love.graphics.getDimensions()
    ripple.canvas = love.graphics.newCanvas(w, h)
    ripple.shader = love.graphics.newShader("ripple.glsl")

    -- Send all uniforms matching the original GML names
    ripple.shader:send("frequency",     ripple.frequency)
    ripple.shader:send("amplitude",     ripple.amplitude)
    ripple.shader:send("ripple_rate",   ripple.ripple_rate)
    ripple.shader:send("rgb_strength",  ripple.rgb_strength)
    ripple.shader:send("radius",        ripple.radius)
    ripple.shader:send("aspect",        {w, h})
    ripple.shader:send("center",        {0.5, 0.5})
    ripple.shader:send("time",          0.0)
end

function love.keypressed(key)
    if key == "2" then
        local cx = math.random()
        local cy = math.random()
        ripple.shader:send("center", {cx, cy})
        ripple.active  = true
        ripple.elapsed = 0
    end
end

function love.update(dt)
    key_state.update(dt)

    if ripple.active then
        ripple.elapsed = ripple.elapsed + dt
    
        ripple.shader:send("time", ripple.elapsed * ripple.speed)

        local t = ripple.elapsed / ripple.duration

        local amp = ripple.amplitude * (1 - t)
        ripple.shader:send("amplitude", amp)
    
        if ripple.elapsed >= ripple.duration then
            ripple.active  = false
            ripple.elapsed = 0
        end
    end

    if scene.i == "battle" then
        battle_engine.update(dt)
    elseif scene.i == "overworld" then
        if overworld_engine and overworld_engine.update then
            overworld_engine.update(dt)
        end
    end
end

local function drawScene()
    if scene.i == "battle" then
        battle_engine.draw()
    elseif scene.i == "overworld" then
        if overworld_engine and overworld_engine.draw then
            overworld_engine.draw()
        end
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)

    if ripple.active then
        love.graphics.setCanvas(ripple.canvas)
        love.graphics.clear()
        drawScene()
        love.graphics.setCanvas()

        love.graphics.setShader(ripple.shader)
        love.graphics.draw(ripple.canvas, 0, 0)
        love.graphics.setShader()
    else
        drawScene()
    end
    
    love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
end

