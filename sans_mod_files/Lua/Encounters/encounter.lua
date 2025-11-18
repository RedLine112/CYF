-- Sans encounter script.

encountertext = "* the air is crackling with...\n* bone-rattling energy."
nextwaves = {"bones_horizontal"}
wavetimer = 4.0
arenasize = {160, 135}

enemies = {
"sans"
}

enemypositions = {
{0, 40}
}

-- A list of possible attacks for Sans.
possible_attacks = {"bones_horizontal", "bones_vertical"}

function EncounterStarting()
    -- You can set up things here that should happen at the very beginning of the encounter.
end

function EnemyDialogueStarting()
    -- This is a good place to change dialogue based on the state of the battle.
end

function EnemyDialogueEnding()
    -- This function is called right before the player's turn ends.
    -- We'll randomly select one of the possible attacks for the next wave.
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding()
    -- This is called after the player survives a wave.
    -- We'll just get a random comment from Sans.
    encountertext = RandomEncounterText()
end

function HandleSpare()
    -- You can't spare Sans in this version.
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
    BattleDialog({"* heh. you think that's\n* gonna help you?"})
end
