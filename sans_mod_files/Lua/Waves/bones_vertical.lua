-- A wave of bones moving vertically.

-- A random x position for the bone to spawn at.
local x_pos = math.random(0, Arena.width)

-- Create the bone projectile off-screen at the top.
local bone = CreateProjectile('bone', x_pos, -10)
bone.SetVar('speed', 4) -- Set a speed for the bone.

function Update()
    -- Move the bone downwards.
    bone.Move(0, bone.GetVar('speed'))

    -- If the bone is off-screen at the bottom, remove it.
    if bone.y > Arena.height + 10 then
        bone.Remove()
        -- End the wave after the bone is gone.
        EndWave()
    end
end
