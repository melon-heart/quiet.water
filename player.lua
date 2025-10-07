player = {}
items = {}

function player.load()
    player.name = "melon"
    player.lv = 1
    player.mhp = 16 + (player.lv * 4)
    player.hp = player.mhp
    player.exp = 0
    player.g = 0

    player.s = 0
    player.se = 0
    player.x = 0
    player.y = 0
end

function player.update(i, ii, iii, iv, v) -- i = hp amount changed, ii = exp gained, iii = g gained, iv = item gained, v = item eaten
-- pretend the code is done
end 

return player