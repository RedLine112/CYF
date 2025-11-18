-- A wave of bones moving horizontally.

-- A random y position for the bone to spawn at.
local y_pos = math.random(0, Arena.height)

-- Create the bone projectile off-screen to the left.
local bone = CreateProjectile('bone', -10, y_pos)
bone.SetVar('speed', 4) -- Set a speed for the bone.

function Update()
    -- Move the bone to the right.
    bone.Move(bone.GetVar('speed'), 0)

    -- If the bone is off-screen to the right, remove it.
    if bone.x > Arena.width + 10 then
        bone.Remove()
        -- End the wave after the bone is gone.
        EndWave()
    end
end
