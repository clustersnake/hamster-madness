extends Node2D

var flip_h = false
var flip_v = false

var pos: Vector2 = Vector2(100,100)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = pos


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#Input
	var direction  = Input.get_vector("left", "right", "up", "down")
	position += direction * 500 * delta
	$PlayerImage.flip_h = flip_h
	$PlayerImage.flip_v = flip_v
	
#	$PlayerImage.texture_ 
	
	if direction.x == -1:
		flip_h = true
	if direction.x == 1:
		flip_h = false
		
	if direction.y == -1:
		flip_v = true
	if direction.y == 1:
		flip_v = false
	
	
	
#	position.x += movX * delta
#	position.y += movY * delta
	# rotation_degrees = rotationValue
#
#	if position.x >= get_window().size.x - 60:
#		flip_h = true
#		movX = -200
#	if position.x <= 0 :
#		flip_h = false
#		rotationValue += 45
#		movX = 200
#
#	if position.y >= get_window().size.y  -60:
#		flip_v = true
#		rotationValue += 45
#		movY = -200
#	if position.y <= 0 :
#		flip_v = false
#		rotationValue += 45
#		movY = 200
