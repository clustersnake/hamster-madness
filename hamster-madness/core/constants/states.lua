-- Put functions in this file to use them in several other scripts.
-- To get access to the functions, you need to put:
-- require "my_directory.my_file"
-- in any script using the functions.
-- core/constants/states.lua
local M = {}

M.PLAYER_PROTECTED = "protected"
M.PLAYER_VULNERABLE = "vulnerable"
M.PLAYER_DEAD = "dead"

M.BALL_WITH_PLAYER = "with_player"
M.BALL_IN_FLIGHT = "in_flight"
M.BALL_ON_GROUND = "on_ground"

return M