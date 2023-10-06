extends Sprite2D

var movX =100
var movY = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(50,40)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x += movX * delta
	position.y += movY * delta
	
	if position.x >= get_window().size.x - 40:
		movX = -200
	if position.x <= 30 :
		movX = 200
		
	if position.y >= get_window().size.y  -40:
		movY = -200
	if position.y <= 30 :
		movY = 200
