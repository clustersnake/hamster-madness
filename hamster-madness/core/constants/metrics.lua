-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
-- core/constants/metrics.lua
local M = {}

M.PLAYER_SPEED = 200
M.BALL_SHOT_SPEED = 400         -- 2x player
M.BALL_EXPELLED_SPEED = 200     -- 0.5x shot
M.PARRY_WINDOW = 0.2            -- seconds
M.SONAR_DURATION = 2.0          -- seconds
M.SONAR_COOLDOWN = 10.0         -- seconds

return M