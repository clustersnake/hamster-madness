-- layers.lua
-- Z-layer constants for consistent draw order (back to front)

return {
	FLOOR           = -0.8,   -- Tilemap, tutorial floor indicators
	SHADOW          = -0.6,   -- Enemy shadows
	GROUND          = -0.4,   -- Fallen player, dropped items
	DOOR            = -0.2,   -- Doors
	ENEMY           =  0.0,   -- Enemies, enemy projectiles
	PLAYER          =  0.2,   -- Player character
	PLAYER_ATTACH   =  0.4,   -- Shield in player's hand
	PROJECTILE      =  0.6,   -- Player projectiles, active shield, ball, shockwaves
	CROSSHAIR       =  0.8,   -- Crosshair / cursor
}
