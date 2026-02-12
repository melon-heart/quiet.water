player = {}
items = {}

function player.load()
    player.name = "melon"
    player.lv = 8
    player.mhp = 16 + (player.lv * 4)
    player.hp = player.mhp /2
    player.exp = 0
    player.g = 0
    player.weapon = "tough_glove" -- stick, toy_knife, tough_glove, ballet_shoes, torn_notebook, burnt_pan, empty_gun, frying_pan, real_knife ONLY one of these are implemented though. (currently. won't update this text in future though.)
    player.armour = "tutu" -- unfortunately, armour does nothing... because i'm too lazy to make it do anything. do it yourself.

    player.i = 0 -- selection
    player.ii = 0 -- selection part 2!
    player.iii = 0 -- selection part 3... rest are placeholder i'll need later
    player.iv = 0 -- atk amount probably?
    player.v = 0

    -- base + weapon attack setup
    player.base_atk = 8 + (player.lv * 2)

    local weapon_atk = {
        stick = 0,
        toy_knife = 3,
        tough_glove = 5,
        ballet_shoes = 7,
        torn_notebook = 2,
        burnt_pan = 10,
        empty_gun = 12,
        frying_pan = 10,
        real_knife = 99
    }

    player.weapon_atk = weapon_atk[player.weapon] or 0
    player.total_atk = player.base_atk + player.weapon_atk
end

-- simple player damage calculation
function player.calc_damage(enemy_df, hit_mult)
    local reduction = enemy_df / 4
    local raw = (player.total_atk - reduction) * hit_mult
    local dmg = math.floor(math.max(0, raw))
    return dmg
end

function player.update(i, ii, iii, iv, v) -- i = hp amount changed, ii = exp gained, iii = g gained, iv = item gained, v = item eaten
    if i ~= 0 then
        player.hp = player.hp + i 
        if player.hp >= player.mhp then 
            player.hp = player.mhp
        end
    end
end 

return player
