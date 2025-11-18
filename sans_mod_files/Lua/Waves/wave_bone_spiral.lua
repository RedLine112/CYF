-- A wave of bones spiraling outwards from the center of the arena.

timer = 0
angle = 0
radius = 0
rotation_speed = 0.1 -- How fast the spiral rotates.
expansion_speed = 0.5 -- How fast the spiral expands outwards.

function Update()
    timer = timer + 1

    -- Increase the angle for the next bone's position.
    angle = angle + rotation_speed
    -- Increase the radius to make the spiral expand.
    radius = radius + expansion_speed

    -- Calculate the position for the new bone based on the spiral math.
    local x = Arena.width/2 + math.cos(angle) * radius
    local y = Arena.height/2 + math.sin(angle) * radius

    -- Create a new projectile at the calculated position.
    local bone = CreateProjectile('bone', x, y)

    -- Make the bone stationary for this pattern.
    bone.SetVar('is_spiral', true)

    -- After a certain time, stop creating new bones.
    if timer > 200 then
        -- Remove any remaining bones after a short delay to let the pattern finish.
        if timer > 260 then
             if bullets then
                for i = #bullets - 1, 0, -1 do
                    bullets[i].Remove()
                end
            end
            EndWave()
        end
    end
end
