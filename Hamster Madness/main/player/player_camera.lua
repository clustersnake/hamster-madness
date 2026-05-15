-- player_camera.lua
-- Configuración de cámara para el jugador

local camera = require "orthographic.camera"
local room_data = require "main.data.room_data"

local M = {}

function M.setup(player_id)
	local camera_id = go.get_id("/camera")
	local room = room_data.current

	if room.scrollable then
		camera.follow(camera_id, player_id)
		local bounds = room.camera_bounds
		camera.bounds(camera_id, bounds.left, bounds.bottom, bounds.right, bounds.top)
		print("[Player] Cámara: follow con bounds")
	else
		local center = room.camera_center
		go.set_position(vmath.vector3(center.x, center.y, 0), camera_id)
		print("[Player] Cámara: fija en centro")
	end
end

return M
