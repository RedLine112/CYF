-- A wave of sweeping bone walls with a gap to dodge through.

timer = 0
state = 0 -- 0 for left-to-right, 1 for right-to-left.
wall_speed = 2
wall_x = -10
gap_y = Arena.height / 2

function Update()
    timer = timer + 1

    -- Part 1: Wall sweeping from left to right.
    if state == 0 then
        wall_x = wall_x + wall_speed
        -- When the wall is fully on screen, create the projectiles.
        if timer == 1 then
            gap_y = math.random(20, Arena.height - 20)
            -- Create bones above and below the gap.
            for y = 0, Arena.height, 10 do
                if y < gap_y - 20 or y > gap_y + 20 then
                    local bone = CreateProjectile('bone', wall_x, y)
                    bone.SetVar('is_wall', true) -- Mark as part of the wall.
                end
            end
        end
        -- Once the wall moves off-screen, reset for the next part.
        if wall_x > Arena.width + 10 then
            state = 1
            timer = 0
            wall_x = Arena.width + 10
            -- Remove the old wall projectiles.
            if bullets then
                for i = #bullets - 1, 0, -1 do
                    bullets[i].Remove()
                end
            end
        end

    -- Part 2: Wall sweeping from right to left.
    elseif state == 1 then
        wall_x = wall_x - wall_speed
        if timer == 1 then
            gap_y = math.random(20, Arena.height - 20)
            for y = 0, Arena.height, 10 do
                if y < gap_y - 20 or y > gap_y + 20 then
                    local bone = CreateProjectile('bone', wall_x, y)
                    bone.SetVar('is_wall', true)
                end
            end
        end
        if wall_x < -10 then
            EndWave()
        end
    end

    -- Update the position of all wall projectiles.
    if bullets then
        for i=0, #bullets-1 do
            if bullets[i].GetVar('is_wall') then
                if state == 0 then
                    bullets[i].MoveTo(wall_x, bullets[i].y)
                else
                    bullets[i].MoveTo(wall_x, bullets[i].y)
                end
            end
        end
    end
end
