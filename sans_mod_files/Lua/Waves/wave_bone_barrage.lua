-- A chaotic barrage of bones targeting the player's position.

-- Timer to control the duration of the wave.
timer = 0

function Update()
    timer = timer + 1

    -- Create a new bone every 5 frames for a more intense barrage.
    if timer % 5 == 0 then
        -- Randomly choose a side of the arena to spawn the bone.
        local side = math.random(4)
        local x, y
        if side == 1 then -- Top
            x = math.random(Arena.width)
            y = -10
        elseif side == 2 then -- Bottom
            x = math.random(Arena.width)
            y = Arena.height + 10
        elseif side == 3 then -- Left
            x = -10
            y = math.random(Arena.height)
        else -- Right
            x = Arena.width + 10
            y = math.random(Arena.height)
        end

        local bone = CreateProjectile('bone', x, y)

        -- Calculate the direction towards the player.
        local angle = math.atan2(Player.y - y, Player.x - x)
        local speed = 3

        -- Set the bone's velocity based on the calculated angle.
        bone.SetVar('xspeed', math.cos(angle) * speed)
        bone.SetVar('yspeed', math.sin(angle) * speed)
    end

    -- Update the position of all bones.
    -- This check prevents the "attempt to get length of a nil value" error.
    if bullets then
        for i=0, #bullets-1 do
            local bullet = bullets[i]
            if bullet.GetVar('xspeed') ~= nil then
                bullet.Move(bullet.GetVar('xspeed'), bullet.GetVar('yspeed'))
                -- Remove bones that are far off-screen.
                if bullet.x < -30 or bullet.x > Arena.width + 30 or bullet.y < -30 or bullet.y > Arena.height + 30 then
                    bullet.Remove()
                end
            end
        end
    end

    -- End the wave after about 3 seconds.
    if timer > 180 then
        EndWave()
    end
end
