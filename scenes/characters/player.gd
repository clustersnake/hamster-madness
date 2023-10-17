extends CharacterBody2D

const speed:int = 256
const item_size: = 128
var direction: Vector2 = Vector2(0, 0)
var body_ball: PackedScene = preload("res://scenes/items/item.tscn")
var body: Area2D
var hero_moved:bool = false

const player_textures = [
	preload("res://assets/player/Cat_Left.png"),
	preload("res://assets/player/Cat_Right.png"),
	preload("res://assets/player/Cat_Up.png"),
	preload("res://assets/player/Cat_Down.png"),
]
const texture_shield = preload("res://assets/player/shield.png")

var items_count:int = 0
var items_positions:Array[Vector2] = []
var items: Array[Sprite2D] = []

func get_item(texture):
#	items_positions.push_back(position)
	items_count += 1
	if items_count == 1:
		show_shield()
	else:
		add_item(texture) 
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

func add_item(texture):
	var item = Sprite2D.new()
#	item.scale = Vector2(.2,.2)
	
#	if items_count == 1:
#		item.position = position
#		item.texture = texture_shield
#	else: 
	item.position = position - velocity * item_size * 128
	item.texture = texture
	
	$Items.add_child(item)
	items.push_front(item)
	print('item')

func show_shield():
	$Hamster/Shield.visible = true
	print('shield')
#	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func update_positions(pos):
	if items_count <= 1:
		return
	if items[0].position == pos:
#		items[0].position = pos
		return
	var new_pos = items[0].position - velocity * item_size * 128
	
	items[0].position = pos - velocity * item_size * 128
#	if update_all != true:
#		return
		
#	for i in range(items.size()-1, -1, -1):
	for i in items_count -1:
		if i > 0:
			var current_pos =  items[i].position
			items[i].position = new_pos 
			new_pos = current_pos  - velocity * item_size * 128
#			pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(_evt):
#	print(_evt.as_text())
#	if _evt.is_action('up'):
#		print('up')
	
	var current_direction = Input.get_vector("left", "right", "up", "down")
#	print(current_direction)
	if current_direction != Vector2(0,0):
		hero_moved = true
#		velocity = current_direction * speed * _delta
	direction = current_direction
	
#	update_positions(position)
#	if(_evt.is_action('left')):
#		$Hamster.texture = textures[0]
#	if(_evt.is_action('right')):
#		$Hamster.texture = textures[1]
#	if(_evt.is_action('up')):
#		$Hamster.texture = textures[2]
#	if(_evt.is_action('down')):
#		$Hamster.texture = textures[3]
		
#	if(current_direction != Vector2(0,0)):
#	update_positions(position)
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
	print(items.size())

func _process(delta):
#	var current_direction = Input.get_vector("left", "right", "up", "down")
	if direction == Vector2(-1,0):
		$Hamster.texture = player_textures[0]
	if direction == Vector2(1,0):
		$Hamster.texture = player_textures[1]
	if direction == Vector2(0,-1):
		$Hamster.texture = player_textures[2]
	if direction == Vector2(0,1):
		$Hamster.texture = player_textures[3]
		
#	velocity = direction * speed * delta
	position = position + (direction * speed * delta)
#	update_positions(position)
#	move_and_slide()


func _on_items_update_timer_timeout():
	if hero_moved:
		update_positions(position)
		hero_moved = false
