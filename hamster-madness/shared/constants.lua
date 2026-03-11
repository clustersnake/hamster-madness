local M = {}
-- metrics:
M.PLAYER_SPEED = 150
M.PLAYER_PROTECTED_SPEED = 120  -- Penalización al estar dentro de la bola
M.BALL_SHOT_SPEED = 400         -- 2x player (aprox)
M.BALL_EXPELLED_SPEED = 200     -- 0.5x shot
M.PARRY_WINDOW = 0.2
M.SONAR_DURATION = 2.0
M.SONAR_COOLDOWN = 10.0

-- states:
M.PLAYER_PROTECTED = "protected"
M.PLAYER_VULNERABLE = "vulnerable"
M.PLAYER_DEAD = "dead"

M.BALL_WITH_PLAYER = "with_player"
M.BALL_IN_FLIGHT = "in_flight"
M.BALL_ON_GROUND = "on_ground"

-- upgrades: 
M.PARRY = "parry"
M.SONAR = "sonar"
M.SPIKE_SHIELD = "spike_shield"
M.PENETRATION = "penetration"

-- Percepción
M.DETECTION_RADIUS_SMALL = 150
M.DETECTION_RADIUS_LARGE = 300

-- Estados de IA
M.STATE_IDLE = "idle"       -- Patrulla o espera
M.STATE_CHASE = "chase"     -- Persigue al jugador
M.STATE_ATTACK = "attack"   -- Ejecuta el ataque
M.STATE_STUN = "stun"       -- Aturdido (por golpe o parry)

-- Tipos de daño
M.DAMAGE_NORMAL = 1
M.DAMAGE_CHARGED = 2        -- Tras rebotes

M.BALL_RANGE_SHOT = 600
M.BALL_RANGE_EXPELLED = 200

-- shared/constants.lua
M.HAMSTER_TYPES = {
	SPEEDY = { speed = 150, can_charge_bounce = false, can_charge_damage = false },
	TANK = { speed = 80, can_charge_damage = true }, -- Requiere estar quieto
	TRICKSHOT = { speed = 100, can_charge_bounce = true }, -- Único con rebotes cargados
	-- ... etc
}

return M