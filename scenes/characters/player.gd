extends CharacterBody2D

const speed:int = 512
var direction: Vector2 = Vector2(0, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	motion_mode = 1
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	var current_direction = Input.get_vector("left", "right", "up", "down")
#	print(current_direction)
#	if(current_direction != Vector2(0,0)):
#		velocity = current_direction * speed * _delta
	direction = current_direction
#	else:
	velocity = direction * speed
		
	move_and_slide()
