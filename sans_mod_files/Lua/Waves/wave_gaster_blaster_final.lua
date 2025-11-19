-- Sans's final gaster blaster attack.

timer = 0
state = 0 -- Manages the sequence of the attack.
blasters = {} -- To keep track of our gaster blasters.

-- Attack sequence:
-- 0: Top and bottom blasters appear.
-- 1: Top and bottom blasters fire.
-- 2: Left and right blasters appear.
-- 3: Left and right blasters fire.

function Update()
    timer = timer + 1

    -- State 0: Top and Bottom Blasters Appear
    if state == 0 then
        if timer == 1 then
            -- Top blasters
            for i = 1, 3 do
                local blaster = CreateProjectile('gaster_blaster', (i-2) * 80, -Arena.height/2 - 30)
                blaster.SetVar('type', 'blaster')
                blaster.sprite.Scale(0.5, 0.5) -- Scale down the blaster sprite.
                table.insert(blasters, blaster)
            end
            -- Bottom blasters
            for i = 1, 3 do
                local blaster = CreateProjectile('gaster_blaster', (i-2) * 80, Arena.height/2 + 30)
                blaster.SetVar('type', 'blaster')
                blaster.sprite.rotation = 180 -- Pointing upwards
                blaster.sprite.Scale(0.5, 0.5) -- Scale down the blaster sprite.
                table.insert(blasters, blaster)
            end
        end
        if timer > 60 then -- Wait for 1 second
            timer = 0
            state = 1
        end

    -- State 1: Top and Bottom Blasters Fire
    elseif state == 1 then
        if timer == 1 then
            for _, blaster in ipairs(blasters) do
                local beam_y_pos = blaster.y < 0 and blaster.y + 20 or blaster.y - 20
                local beam = CreateProjectile('beam', blaster.x, beam_y_pos)
                beam.SetVar('type', 'beam')
                beam.sprite.Scale(0.8, 10) -- Resized vertical beam.
            end
        end
        if timer > 30 then -- Beam lasts for 0.5 seconds
            -- Cleanup
            if bullets then
                for i = #bullets - 1, 0, -1 do bullets[i].Remove() end
            end
            blasters = {}
            timer = 0
            state = 2
        end

    -- State 2: Left and Right Blasters Appear
    elseif state == 2 then
        if timer == 1 then
            -- Left blasters
            for i = 1, 2 do
                local blaster = CreateProjectile('gaster_blaster', -Arena.width/2 - 30, (i-1.5) * 80)
                blaster.SetVar('type', 'blaster')
                blaster.sprite.rotation = -90 -- Pointing right
                blaster.sprite.Scale(0.5, 0.5) -- Scale down the blaster sprite.
                table.insert(blasters, blaster)
            end
            -- Right blasters
            for i = 1, 2 do
                local blaster = CreateProjectile('gaster_blaster', Arena.width/2 + 30, (i-1.5) * 80)
                blaster.SetVar('type', 'blaster')
                blaster.sprite.rotation = 90 -- Pointing left
                blaster.sprite.Scale(0.5, 0.5) -- Scale down the blaster sprite.
                table.insert(blasters, blaster)
            end
        end
        if timer > 60 then
            timer = 0
            state = 3
        end

    -- State 3: Left and Right Blasters Fire
    elseif state == 3 then
        if timer == 1 then
            for _, blaster in ipairs(blasters) do
                local beam_x_pos = blaster.x < 0 and blaster.x + 20 or blaster.x - 20
                local beam = CreateProjectile('beam', beam_x_pos, blaster.y)
                beam.SetVar('type', 'beam')
                beam.sprite.Scale(10, 0.8) -- Resized horizontal beam.
            end
        end
        if timer > 30 then
            EndWave()
        end
    end
end
