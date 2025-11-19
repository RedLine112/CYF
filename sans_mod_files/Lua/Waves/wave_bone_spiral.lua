-- A wave of bones spiraling outwards, corrected for center-based coordinates and with added movement.

timer = 0
angle = 0
radius = 5 -- Start with a small radius to avoid a bone at the exact center.
rotation_speed = 0.15 -- Slightly faster rotation.
expansion_speed = 0.7 -- Slightly faster expansion.
bullet_speed = 2 -- Speed at which bones travel outwards.

function Update()
    timer = timer + 1

    -- We only create projectiles for a certain duration.
    if timer <= 150 then
        -- Increase the angle for the next bone's position.
        angle = angle + rotation_speed
        -- Increase the radius to make the spiral expand.
        radius = radius + expansion_speed

        -- Calculate the position for the new bone based on the spiral math.
        local x = 0 + math.cos(angle) * radius
        local y = 0 + math.sin(angle) * radius

        -- Create a new projectile at the calculated position.
        local bone = CreateProjectile('bone', x, y)

        -- Set its velocity to move outwards from the center.
        -- The direction is the same as the angle used to create it.
        bone.SetVar('xspeed', math.cos(angle) * bullet_speed)
        bone.SetVar('yspeed', math.sin(angle) * bullet_speed)
    end

    -- Update the position of all active bones.
    if bullets then
        for i=0, #bullets-1 do
            local bullet = bullets[i]
            if bullet.GetVar('xspeed') then
                bullet.Move(bullet.GetVar('xspeed'), bullet.GetVar('yspeed'))
                -- Remove bones that are way off-screen.
                if bullet.x < -Arena.width or bullet.x > Arena.width or bullet.y < -Arena.height or bullet.y > Arena.height then
                    bullet.Remove()
                end
            end
        end
    end

    -- End the wave after enough time has passed for all bones to leave the screen.
    if timer > 250 then
        EndWave()
    end
end
