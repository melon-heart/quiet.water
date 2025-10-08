-- player_actions.lua
local key_state = {
    z = {is_down = false, was_down = false, just_pressed = false},
    x = {is_down = false, was_down = false, just_pressed = false},
    up = {is_down = false, was_down = false, just_pressed = false},
    down = {is_down = false, was_down = false, just_pressed = false},
    left = {is_down = false, was_down = false, just_pressed = false},
    right = {is_down = false, was_down = false, just_pressed = false}
}

function key_state.update()
    for key, state in pairs(key_state) do
        if type(state) == "table" then
            state.is_down = love.keyboard.isDown(key)
            state.just_pressed = state.is_down and not state.was_down
            state.was_down = state.is_down
        end
    end
end

return key_state