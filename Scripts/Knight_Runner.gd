extends Node2D


var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _physics_process(delta):
	for ground in $Ground.get_children():
		ground.position.x -= speed*delta

func _on_knight_is_dying_changed(new_value):
	print("from game: ", new_value)

func _on_knight_char_dead_off_screen():
	print("game over")
