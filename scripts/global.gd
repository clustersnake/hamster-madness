extends Node

#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var score: int
var axis: Vector2

func get_axis() -> Vector2:
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	print('up: ', Input.is_action_pressed("up"))
	print('down: ', Input.is_action_pressed("down"))
	return axis.normalized()
