extends Node2D


var speed = 200
var is_dead = false

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func _physics_process(delta):
	for ground in $Ground.get_children():
		ground.position.x -= speed*delta

func _process(_delta):
	var viewport_rect = get_viewport_rect()
	if $Knight.position.y > viewport_rect.end.y and is_dead:
		print("game over")

func _on_knight_is_dying_changed(new_value):
	print("from game: ", new_value)
