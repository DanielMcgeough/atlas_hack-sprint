extends Node2D


var speed = 250
var is_dead = false
var gameover = false


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.gameover = false
	randomize()

func _physics_process(delta):
	for ground in $Ground.get_children():
		ground.position.x -= speed*delta


func _process(_delta):
	var viewport_rect = get_viewport_rect()
	if $Knight.position.y > viewport_rect.end.y and is_dead and !gameover:
		Global.gameover = true
		# TODO: add timer here to delay gameover screen
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")

func _on_knight_is_dying_changed(new_value):
	is_dead = new_value
	print("from game: ", new_value)
