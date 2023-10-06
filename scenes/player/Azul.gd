extends Sprite2D

var movX = 100
var movY = 100

var rotationValue: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(50,120)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += movX * delta
	position.y += movY * delta
	rotation_degrees = rotationValue
	
	if position.x >= get_window().size.x - 40:
		rotationValue += 45
		movX = -200
	if position.x <= 30 :
		rotationValue += 45
		movX = 200
		
	if position.y >= get_window().size.y  -40:
		rotationValue += 45
		movY = -200
	if position.y <= 30 :
		rotationValue += 45
		movY = 200
