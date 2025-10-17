-- typewriter.lua
local typewriter = {}
typewriter.__index = typewriter

function typewriter.new(x, y, text, font, sound)
    local self = setmetatable({}, typewriter)
    self.x = x
    self.y = y
    self.text = text
    self.font = font
    self.sound = sound

    self.wait_time = 0
    self.current_text = ""
    self.index = 1
    self.finished = false
    self.char_count = 0
    self.speed = 0.03
    self.timer = 0

    self.colors = {}       -- { {start_index, r, g, b}, ... }
    self.current_color = {1, 1, 1, 1}
    self.parsed_segments = {}  -- { {text="hi", color={1,0,0,1}}, ... }

    return self
end

function typewriter:update(dt, skip)
    if self.finished then return end

    if skip then
        self:finish_all()
        return
    end

    if self.wait_time > 0 then
        self.wait_time = math.max(0, self.wait_time - dt)
        return
    end

    self.timer = self.timer + dt
    while self.timer >= self.speed and not self.finished do
        self.timer = self.timer - self.speed
        self:next_character()
    end
end

function typewriter:next_character()
    if self.index > #self.text then
        self.finished = true
        return
    end

    local char = self.text:sub(self.index, self.index)
    if char == "/" then
        local code = self.text:sub(self.index + 1, self.index + 1)

        if code == "n" then
            self.current_text = self.current_text .. "\n"
            table.insert(self.parsed_segments, { text = "\n", color = {unpack(self.current_color)} })
            self.index = self.index + 2
            return
        elseif code == "w" then
            self.wait_time = 0.1
            self.index = self.index + 2
            return
        elseif code == "s" then
            local value, len = self:parse_brackets(self.index + 2)
            if value then
                self.speed = tonumber(value) or self.speed
                self.index = self.index + 2 + len
                return
            end
        elseif code == "c" then
            local value, len = self:parse_brackets(self.index + 2)
            if value then
                local r, g, b = value:match("(%d+),(%d+),(%d+)")
                if r and g and b then
                    r, g, b = tonumber(r)/255, tonumber(g)/255, tonumber(b)/255
                    self.current_color = {r, g, b, 1}
                end
                self.index = self.index + 2 + len
                return
            end
        end
    end

    self.current_text = self.current_text .. char
    table.insert(self.parsed_segments, {
        text = char,
        color = {unpack(self.current_color)}
    })

    self.index = self.index + 1
    self.char_count = self.char_count + 1

    if self.char_count % 2 == 0 and self.sound then
        self.sound:stop()
        self.sound:play()
    end

    if self.index > #self.text then
        self.finished = true
    end
end

function typewriter:parse_brackets(start_index)
    local close_index = self.text:find("%]", start_index)
    if not close_index then return nil end
    local content = self.text:sub(start_index, close_index - 1)
    local length = close_index - start_index + 1
    return content, length
end

function typewriter:draw()
    love.graphics.setFont(self.font)

    local x = self.x
    local y = self.y
    local line_height = self.font:getHeight()
    local current_x = x
    local current_y = y

    for _, segment in ipairs(self.parsed_segments) do
        if segment.text == "\n" then
            current_y = current_y + line_height
            current_x = x
        else
            love.graphics.setColor(segment.color)
            love.graphics.print(segment.text, current_x, current_y)
            local w = self.font:getWidth(segment.text)
            current_x = current_x + w
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
end

function typewriter:finish_all()
    if self.finished then return end

    self.parsed_segments = {}
    self.current_text = ""
    self.index = 1
    self.char_count = 0

    local i = 1
    self.current_color = {1, 1, 1, 1}

    while i <= #self.text do
        local char = self.text:sub(i, i)
        if char == "/" then
            local code = self.text:sub(i + 1, i + 1)
            if code == "n" then
                table.insert(self.parsed_segments, { text = "\n", color = {unpack(self.current_color)} })
                i = i + 2
            elseif code == "w" then
                i = i + 2
            elseif code == "s" then
                local val, len = self:parse_brackets(i + 2)
                if val then
                    self.speed = tonumber(val) or self.speed
                    i = i + 2 + len
                else
                    i = i + 1
                end
            elseif code == "c" then
                local val, len = self:parse_brackets(i + 2)
                if val then
                    local r, g, b = val:match("(%d+),(%d+),(%d+)")
                    if r and g and b then
                        self.current_color = {tonumber(r)/255, tonumber(g)/255, tonumber(b)/255, 1}
                    end
                    i = i + 2 + len
                else
                    i = i + 1
                end
            else
                -- Unknown code
                i = i + 1
            end
        else
            table.insert(self.parsed_segments, {
                text = char,
                color = {unpack(self.current_color)}
            })
            i = i + 1
        end
    end

    self.finished = true
end

function typewriter:clear(tbl)
    self.current_text = ""
    self.parsed_segments = {}
    self.char_count = 0
    self.index = 1
    self.timer = 0
    self.wait_time = 0
    self.finished = false
    self.current_color = {1, 1, 1, 1}

    if tbl and type(tbl) == "table" then
        for k in pairs(tbl) do
            tbl[k] = nil
        end
    end
end


function typewriter:is_finished()
    return self.finished
end

return typewriter