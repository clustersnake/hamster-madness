extends CharacterBody2D

const speed:int = 256
var direction: Vector2 = Vector2(0, 0)
var body_ball: PackedScene = preload("res://scenes/items/item.tscn")
var body: Area2D

const textures = [
	preload("res://assets/player/Cat_Left.png"),
	preload("res://assets/player/Cat_Right.png"),
	preload("res://assets/player/Cat_Up.png"),
	preload("res://assets/player/Cat_Down.png"),
]

var items_count:int = 0
var items_positions:Array[Vector2] = []

func get_item():
	items_count += 1
	if items_count == 1:
		show_shield()
	items_positions.push_back(position)
#	else: 
#	items_positions.push_back(position)
#	print('----')
#	print(items_positions)
#	body = body_ball.instantiate()
#	body.position = items_positions[items_count - 1]
#	body.name = "body-" + str(items_count)
##	body.player_got_item.connect(player_got_item_handler)
#	add_child(body)
	
#	pass

func show_shield():
#	$Hamster/Shield.visible = true
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func update_positions():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_evt):
#	print(_evt.as_text())
#	if _evt.is_action('up'):
#		print('up')
	
	var current_direction = Input.get_vector("left", "right", "up", "down")
#	print(current_direction)
#	if current_direction != Vector2(0,0):
#		velocity = current_direction * speed * _delta
	direction = current_direction
	
	
#	if(_evt.is_action('left')):
#		$Hamster.texture = textures[0]
#	if(_evt.is_action('right')):
#		$Hamster.texture = textures[1]
#	if(_evt.is_action('up')):
#		$Hamster.texture = textures[2]
#	if(_evt.is_action('down')):
#		$Hamster.texture = textures[3]
		
#	if(current_direction != Vector2(0,0)):
#		if items_count > 0:
#			for i in items_count:
#				if(i < items_count - 1):
#					items_positions[i+1] = items_positions[i]
##				name
#			items_positions[0] = position
#	else:
#	velocity = direction * speed
#	move_and_slide()
#	position = position + current_direction * speed
	print(items_positions)

func _process(delta):
#	var current_direction = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2(-1,0):
		$Hamster.texture = textures[0]
	if direction == Vector2(1,0):
		$Hamster.texture = textures[1]
	if direction == Vector2(0,-1):
		$Hamster.texture = textures[2]
	if direction == Vector2(0,1):
		$Hamster.texture = textures[3]
		
#	velocity = direction * speed * delta
	position = position + (direction * speed * delta)
#	move_and_slide()
