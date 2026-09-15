local item_lists = {
    full = {
        "Monster Candy", "Croquet Roll", "Stick", "Bandage", "Rock Candy", "Pumpkin Rings", "Spider Donut", "Stoic Onion", "Ghost Fruit", "Spider Cider", "Butterscotch Pie", "Faded Ribbon", "Toy Knife", "Tough Glove", "Manly Bandanna", "Snowman Piece", "Nice Cream", "Puppydough Icecream", "Bisicle", "Unisicle", "Cinnamon Bun", "Temmie Flakes", "Abandoned Quiche", "Old Tutu", "Ballet Shoes", "Punch Card", "Annoying Dog", "Dog Salad", "Dog Residue", "Dog Residue", "Dog Residue", "Dog Residue", "Dog Residue", "Dog Residue", "Astronaut Food", "Instant Noodles", "Crab Apple", "Hot Dog...?", "Hot Cat", "Glamburger", "Sea Tea", "Starfait", "Legendary Hero", "Cloudy Glasses", "Torn Notebook", "Stained Apron", "Burnt Pan", "Cowboy Hat", "Empty Gun", "Heart Locket", "Worn Dagger", "Real Knife", "The Locket", "Bad Memory", "Dream", "Undyne's Letter", "Undyne's Letter EX", "Popato Chisps", "Junk Food", "Mystery Key", "Face Steak", "Hush Puppy", "Snail Pie", "Temmie Armor"
    },
    short = {
        "MnstrCndy", "CroqtRoll", "Stick", "Bandage", "RockCandy", "PunkRings", "SpdrDonut", "Onion", "GhstFruit", "SpdrCider", "Pie", "Ribbon", "Knife", "Glove", "Bandanna", "SnowPiece", "NiceCream", "PuppyCream", "Bisicle", "Unisicle", "Cinnabun", "Flakes", "Quiche", "Tutu", "Shoes", "Card", "Dog", "Salad", "Residue", "Residue", "Residue", "Residue", "Residue", "Residue", "AstroFood", "Noodles", "Apple", "HotDog", "HotCat", "Burger", "Tea", "Starfait", "Hero", "Glasses", "Notebook", "Apron", "Pan", "Hat", "Gun", "Locket", "Dagger", "Knife+", "Locket+", "Memory", "Dream", "Letter", "LetterEX", "Chisps", "Junk", "Key", "Steak", "HushPuppy", "SnailPie", "TemArmor"
    },
    serious = {
        "MnstrCndy", "CroqtRoll", "Stick", "Bandage", "RockCandy", "PmknRings", "SpdrDonut", "StocOnion", "GhostFrut", "SpdrCider", "ButtPie", "Ribbon", "ToyKnife", "TuffGlove", "ManlyBand", "SnowPiece", "NiceCream", "IceCream", "Bisicle", "Unisicle", "CinnaBun", "TemFlakes", "Quiche", "OldTutu", "BltShoes", "PunchCard", "AnnoyDog", "DogSalad", "Residue1", "Residue2", "Residue3", "Residue4", "Residue5", "Residue6", "AstroFood", "InstaNood", "CrabApple", "HotDog", "HotCat", "GlamBurg", "SeaTea", "StarFait", "LegHero", "CldyGlass", "TornNtbk", "Apron", "BurntPan", "CowboyHat", "EmptyGun", "HrtLocket", "WrnDagger", "RealKnife", "TheLocket", "BadMemory", "LastDream", "Letter1", "Letter2", "Popato", "JunkFood", "MystKey", "FaceSteak", "HushPuppy", "SnailPie", "TemArmor"
    },
    descriptions = {
        "Has a distinct, non-licorice flavor.",
        "Fried dough traditionally served with a mallet.",
        "Its bark is worse than its bite.",
        "It has already been used several times.",
        "Here is a recipe to make this at home: 1. Find a rock",
        "A small pumpkin cooked like onion rings.",
        "A donut made with Spider Cider in the batter.",
        "Even eating it raw, the tears just won't come.",
        "If eaten, it will never pass to the other side.",
        "Made with whole spiders, not just the juice.",
        "Butterscotch-cinnamon pie, one slice.",
        "If you're cuter, monsters won't hit you as hard.",
        "Made of plastic. A rarity nowadays.",
        "A worn pink leather glove. For five-fingered folk.",
        "It has seen some wear. It has abs drawn on it.",
        "Please take this to the ends of the earth.",
        "Instead of a joke, the wrapper says something nice.",
        "'Puppydough Icecream' Made by young pups.",
        "It's a two-pronged popsicle, so you can eat it twice.",
        "It's a SINGLE-pronged popsicle. Wait, that's just normal...",
        "A cinnamon roll in the shape of a bunny.",
        "It's just torn up pieces of colored construction paper.",
        "A psychologically damaged spinach egg pie.",
        "Finally, a protective piece of armor.",
        "These used shoes make you feel incredibly dangerous.",
        "Use to make punching attacks stronger in one battle. Use outside of battle to look at the card.",
        "A little white dog. It's fast asleep...",
        "Recovers HP. (Hit Poodles.)",
        "Shiny trail left behind by a dog.",
        "Dog-shaped husk shed from a dog's carapace.",
        "Dirty dishes left unwashed by a dog.",
        "Glowing crystals secreted by a dog.",
        "Jigsaw puzzle left unfinished by a dog.",
        "Web spun by a dog to ensnare prey.",
        "For feeding a pet astronaut.",
        "Comes with everything you need for a quick meal!",
        "An aquatic fruit that resembles a crustacean.",
        "The 'meat' is made of something called a 'water sausage.'",
        "Like a hot dog, but with little cat ears on the end.",
        "A hamburger made of edible glitter and sequins.",
        "Made from glowing marshwater. Increases SPEED for one battle.",
        "A sweet treat made of sparkling stars.",
        "Sandwich shaped like a sword. Increases ATTACK when eaten.",
        "Glasses marred with wear. Increases INV by 9. (After you get hurt by an attack, you stay invulnerable for longer.)",
        "Contains illegible scrawls. Increases INV by 6. (After you get hurt by an attack, you stay invulnerable for longer.)",
        "Heals 1 HP every other turn.",
        "Damage is rather consistent. Consumable items heal 4 more HP.",
        "This battle-worn hat makes you want to grow a beard. It also raises ATTACK by 5.",
        "An antique revolver. It has no ammo. Must be used precisely, or damage will be low.",
        "It says 'Best Friends Forever.'",
        "Perfect for cutting plants and vines.",
        "Here we are!",
        "You can feel it beating.",
        "?????",
        "The goal of Determination.",
        "Letter written for Dr. Alphys.",
        "It has DON'T DROP IT written on it.",
        "Regular old popato chisps.",
        "Food that was probably once thrown away.",
        "It is too bent to fit on your keychain.",
        "Huge steak in the shape of Mettaton's face. (You don't feel like it's made of real meat...)",
        "This wonderful spell will stop a dog from casting magic.",
        "An acquired taste.",
        "The things you can do with a college education! Raises ATTACK when worn. Recovers HP every other turn. INV up slightly."
    },
    item_type = {
        "consumable", "consumable", "weapon", "armor", "consumable",
        "consumable", "consumable", "consumable", "consumable", "consumable",
        "consumable", "armor", "weapon", "weapon", "armor",
        "consumable", "consumable", "consumable", "consumable", "consumable",
        "consumable", "consumable", "consumable", "armor", "weapon",
        "misc", "misc", "consumable", "misc", "misc",
        "misc", "misc", "misc", "misc", "consumable",
        "consumable", "consumable", "consumable", "consumable", "consumable",
        "consumable", "consumable", "consumable", "armor", "weapon",
        "armor", "weapon", "armor", "weapon", "armor",
        "weapon", "weapon", "armor", "consumable", "consumable",
        "misc", "misc", "consumable", "consumable", "misc",
        "consumable", "consumable", "consumable", "armor"
    },
    item_heal_amount = {
        10, 15, 0, 0, 1, -- 1 Monster Candy, 2 Croquet Roll, 3 Stick, 4 Bandage (armor), 5 Rock Candy
        8, 12, 5, 16, 24, -- 6 Pumpkin Rings, 7 Spider Donut, 8 Stoic Onion, 9 Ghost Fruit, 10 Spider Cider
        "ALL", 0, 0, 0, 0, -- 11 Butterscotch Pie (full heal), 12 Faded Ribbon, 13 Toy Knife, 14 Tough Glove, 15 Manly Bandanna
        45, 15, 28, 11, 11, -- 16 Snowman Piece, 17 Nice Cream, 18 Puppydough Icecream, 19 Bisicle, 20 Unisicle
        22, 2, 34, 0, 0, -- 21 Cinnamon Bun, 22 Temmie Flakes, 23 Abandoned Quiche, 24 Old Tutu, 25 Ballet Shoes
        0, 0, {2, 10, 30, "ALL"}, 0, 0, -- 26 Punch Card (no heal, +2-6 AT for a battle), 27 Annoying Dog, 28 Dog Salad  (random), 29-30Dog Residue
        0, 0, 0, 0, 21, -- 31-34 Dog Residue, 35 Astronaut Food
        4, 18, 20, 21, 27, -- 36 Instant Noodles (4 in battle; see note), 37 Crab Apple, 38 Hot Dog...?, 39 Hot Cat, 40 Glamburger
        10, 14, 40, 0, 0, -- 41 Sea Tea (+SPEED), 42 Starfait, 43 Legendary Hero (+4 AT), 44 Cloudy Glasses, 45 Torn Notebook
        0, 0, 0, 0, 0, -- 46 Stained Apron (armor), 47 Burnt Pan, 48 Cowboy Hat, 49 Empty Gun, 50 Heart Locket
        0, 0, 0, -1, 17, -- 51 Worn Dagger, 52 Real Knife, 53 The Locket, 54 Bad Memory (drains 1 HP, heals ALL if HP<=3), 55 Dream
        0, 0, 13, 17, 0,  -- 56 Undyne's Letter, 57 Undyne's Letter EX, 58 Popato Chisps, 59 Junk Food, 60 Mystery Key
        60, 65, "MAX-1", 0 -- 61 Face Steak, 62 Hush Puppy, 63 Snail Pie (full HP minus 1), 64 Temmie Armor (armor)
    },
    item_used_text_normal = { -- it works by having custom text first, and then adds the default text at the end.
        "You ate the Monster Candy."
    },
    item_used_text_serious = {
        "You ate the Monster Candy."
    }
}

local function to_roman(number)
    local numerals = {
        {1000, "m"}, {900, "cm"}, {500, "d"}, {400, "cd"},
        {100, "c"}, {90, "xc"}, {50, "l"}, {40, "xl"},
        {10, "x"}, {9, "ix"}, {5, "v"}, {4, "iv"}, {1, "i"}
    }

    local result = ""
    for _, pair in ipairs(numerals) do
        local value, symbol = pair[1], pair[2]
        while number >= value do
            result = result .. symbol
            number = number - value
        end
    end

    return result
end

local function build_group(values)
    local group = {}
    for index, value in ipairs(values) do
        group[to_roman(index)] = value
    end
    return group
end

items = {
    full = build_group(item_lists.full),
    short = build_group(item_lists.short),
    serious = build_group(item_lists.serious),
    descriptions = build_group(item_lists.descriptions)
}

for index, value in ipairs(item_lists.full) do
    items[to_roman(index)] = value
end

inventory = {items.i, items.i, items.i, items.x, items.xi, items.x, items.x, items.x} -- max of 8 please! while we could do higher, i'd rather not.

return items