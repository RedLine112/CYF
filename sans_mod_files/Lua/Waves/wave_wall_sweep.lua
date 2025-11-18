-- A wave of sweeping bone walls, corrected for center-based coordinates.

timer = 0
state = 0 -- 0 for left-to-right, 1 for right-to-left.
wall_speed = 3 -- The horizontal speed of the wall.

function Update()
    timer = timer + 1

    -- Create the wall once at the beginning of each state.
    if timer == 1 then
        -- Define vertical bounds of the arena.
        local top_y = -Arena.height / 2
        local bottom_y = Arena.height / 2

        -- Create a random gap for the player to pass through.
        local gap_center = math.random(top_y + 20, bottom_y - 20)
        local gap_size = 20

        -- Part 1: Wall sweeping from left to right.
        if state == 0 then
            local start_x = -Arena.width / 2 - 10
            -- Create a vertical line of bones.
            for y = top_y, bottom_y, 10 do
                -- Skip creating bones in the gap.
                if y < gap_center - gap_size or y > gap_center + gap_size then
                    local bone = CreateProjectile('bone', start_x, y)
                    bone.SetVar('xspeed', wall_speed) -- Give it a rightward velocity.
                end
            end

        -- Part 2: Wall sweeping from right to left.
        elseif state == 1 then
            local start_x = Arena.width / 2 + 10
            for y = top_y, bottom_y, 10 do
                if y < gap_center - gap_size or y > gap_center + gap_size then
                    local bone = CreateProjectile('bone', start_x, y)
                    bone.SetVar('xspeed', -wall_speed) -- Give it a leftward velocity.
                end
            end
        end
    end

    -- Update the position of all active bones.
    if bullets then
        for i=0, #bullets-1 do
            local bullet = bullets[i]
            if bullet.GetVar('xspeed') then
                bullet.Move(bullet.GetVar('xspeed'), 0)
            end
        end
    end

    -- State transition and wave ending logic.
    if state == 0 and timer > 150 then -- After enough time for the first wall to pass...
        state = 1
        timer = 0 -- Reset timer for the next state.
    elseif state == 1 and timer > 150 then -- After the second wall passes...
        EndWave()
    end
end
