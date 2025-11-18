-- Sans monster script.
comments = {"heya.", "what's up?", "you look busy."}
-- "Check" is removed from this list because `cancheck = true` adds it automatically.
commands = {"Joke", "Taunt"}
randomdialogue = {"it's a beautiful day outside.", "birds are singing,\nflowers are blooming...", "on days like these,\nkids like you...", "should be burning in hell."}

sprite = "sans"
name = "Sans"
hp = 1
atk = 1
def = 1
check = "* SANS 1 ATK 1 DEF\n* The easiest enemy.\n* Can only deal 1 damage."
dialogbubble = "left"
canspare = false
cancheck = true

-- Happens after the slash animation but before
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
        BattleDialog({"* heh. changed your mind?"})
    else
        -- player did actually attack
        BattleDialog({"* so, i guess that's it, huh?"})
    end
end

-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "JOKE" then
        -- Use BattleDialog to show the text immediately.
        BattleDialog({"* what do you call a skeleton\nwith no friends?", "* ...", "* lonely."})
    elseif command == "TAUNT" then
        -- Use BattleDialog to show the text immediately.
        BattleDialog({"* you're just a kid.\n* what do you know about\n  the world?"})
    end
end
