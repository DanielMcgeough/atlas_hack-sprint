extends Node2D


var speed = 250
var is_dead = false
var gameover = false

var levels = [
	preload("res://Scenes/Levels/Castle.tscn"),
	preload("res://Scenes/Levels/LavaStone.tscn"),
	preload("res://Scenes/Levels/Swamp.tscn")
]


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.gameover = false
	randomize()
	spawn_level(0, 0)
	spawn_level(3024, 0)

func _physics_process(delta):
	for ground in $Ground.get_children():
		ground.position.x -= speed*delta
		if ground.position.x < -3024:
			spawn_level(ground.position.x+6048, 0)
			ground.queue_free()

func spawn_level(x, y):
	var level = levels[randi() % len(levels)].instantiate()
	level.position = Vector2(x, y)
	$Ground.add_child(level)


func _process(_delta):
	var viewport_rect = get_viewport_rect()
	if $Knight.position.y > viewport_rect.end.y and is_dead and !gameover:
		Global.gameover = true
		# TODO: add timer here to delay gameover screen
		get_tree().change_scene_to_file("res://Scenes/game_over_screen.tscn")

func _on_knight_is_dying_changed(new_value):
	is_dead = new_value
	print("from game: ", new_value)
