-- A wave of bone platforms moving across the screen.

-- Timer to control the flow of the wave.
timer = 0
-- State to manage the two parts of the wave (upwards and downwards).
state = 0

function Update()
    timer = timer + 1

    -- Part 1: Platforms moving from bottom to top.
    if state == 0 then
        -- Every 15 frames, create a new row of platforms.
        if timer % 15 == 0 then
            -- Create two bones with a gap for the player to dodge through.
            local gap = math.random(0, Arena.width - 80)
            local bone1 = CreateProjectile('bone', gap - 100, Arena.height + 10)
            local bone2 = CreateProjectile('bone', gap + 100, Arena.height + 10)
            -- Give them an upward velocity.
            bone1.SetVar('yspeed', -3)
            bone2.SetVar('yspeed', -3)
        end
        -- After about 2 seconds, move to the next state.
        if timer > 120 then
            state = 1
            timer = 0
        end

    -- Part 2: Platforms moving from top to bottom.
    elseif state == 1 then
        -- Every 15 frames, create a new row of platforms.
        if timer % 15 == 0 then
            local gap = math.random(0, Arena.width - 80)
            local bone1 = CreateProjectile('bone', gap - 100, -10)
            local bone2 = CreateProjectile('bone', gap + 100, -10)
            -- Give them a downward velocity.
            bone1.SetVar('yspeed', 3)
            bone2.SetVar('yspeed', 3)
        end
        -- After another 2 seconds, end the wave.
        if timer > 120 then
            EndWave()
        end
    end

    -- Update the position of all existing bones.
    -- This check prevents the "attempt to get length of a nil value" error.
    if bullets then
        for i=0, #bullets-1 do
            local bullet = bullets[i]
            if bullet.GetVar('yspeed') ~= nil then
                bullet.Move(0, bullet.GetVar('yspeed'))
                -- Remove bones that are way off-screen.
                if bullet.y < -30 or bullet.y > Arena.height + 30 then
                    bullet.Remove()
                end
            end
        end
    end
end
