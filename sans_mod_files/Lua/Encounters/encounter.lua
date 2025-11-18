-- Sans encounter script.

encountertext = "* the air is crackling with...\n* bone-rattling energy."
-- The first wave is set here. Subsequent waves are chosen in EnemyDialogueEnding.
nextwaves = {"wave_bone_platforms"}
-- Increased timer to allow for longer, more complex waves.
wavetimer = 8.0
arenasize = {160, 135}

enemies = {
"sans"
}

enemypositions = {
{0, 40}
}

-- Updated list with the new, more challenging attacks.
possible_attacks = {"wave_bone_platforms", "wave_bone_barrage"}

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
