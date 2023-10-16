extends Area2D

signal player_got_item

const textures = [
	preload("res://assets/objects/balls/ball1.svg"),
	preload("res://assets/objects/balls/ball2.svg"),
	preload("res://assets/objects/balls/ball3.svg"),
	preload("res://assets/objects/balls/ball4.svg"),
	preload("res://assets/objects/balls/ball5.svg"),
	preload("res://assets/objects/balls/ball6.svg"),
	preload("res://assets/objects/balls/ball7.svg")]

func change_ball_color():
	$Ball.texture = textures[round(randi_range(0,6))]
	

func _on_body_entered(body):
#	pass # Replace with function body.
#	print(body)
	player_got_item.emit()
