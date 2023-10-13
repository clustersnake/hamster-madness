extends Node2D

var item_scene: PackedScene = preload("res://scenes/items/item.tscn")

var item: Area2D
var screenSize:Vector2
var rng:int




func player_got_item_handler():
	print('player got item')
	create_new_item()
	
func create_new_item():
#	item.position = $Player.position * 1.5
	item.change_ball_color()
	item.position = set_item_position()
	
func set_item_position():
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(0, screenSize.x - 20)
	var rndY = rng.randi_range(0, screenSize.y - 20)
#	item.position = Vector2(rndX, rndY)
	return Vector2(rndX, rndY)

	
	
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
#	pass # Replace with function body.

	screenSize = get_viewport().get_visible_rect().size
  

	item = item_scene.instantiate()
	item.position = set_item_position()
	item.player_got_item.connect(player_got_item_handler)
	add_child(item)
#	print(item)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
