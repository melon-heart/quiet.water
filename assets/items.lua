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