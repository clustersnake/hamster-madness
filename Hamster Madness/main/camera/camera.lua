-- camera.lua
-- Native camera module - replaces defold-orthographic
-- Sends messages to camera_controller.script on the camera GO

local M = {}

function M.follow(camera_id, target_id)
	msg.post(camera_id, "follow", { target = target_id })
end

function M.bounds(camera_id, left, bottom, right, top)
	msg.post(camera_id, "bounds", {
		left = left,
		bottom = bottom,
		right = right,
		top = top
	})
end

function M.shake(camera_id, intensity, duration, direction)
	msg.post(camera_id, "shake", {
		intensity = intensity,
		duration = duration,
		direction = direction
	})
end

function M.screen_to_world(camera_id, screen_position)
	local component_url = msg.url(nil, camera_id, "camera")
	return camera.screen_to_world(screen_position, component_url)
end

function M.world_to_screen(camera_id, world_position)
	local component_url = msg.url(nil, camera_id, "camera")
	return camera.world_to_screen(world_position, component_url)
end

return M
