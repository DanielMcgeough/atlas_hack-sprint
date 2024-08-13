extends CharacterBody2D

@onready var _animated_sprite = $AnimatedSprite2D


const SPEED = 350.0
const JUMP_VELOCITY = -450.0
var is_dying = false
var change_is_dying = false
signal is_dying_changed(new_value)
var ascent_distance = 0
var ascent_speed = 300
var rotation_speed = 180
var descent_speed = 300


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _ready():
	_animated_sprite.play("running")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump -- we want to only jump
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		_animated_sprite.play("jump")
	elif (Input.is_action_pressed("ui_down")):
		_animated_sprite.play("roll")
	if (Input.is_action_pressed("ui_right")):
		_animated_sprite.play("Attack")
	elif is_on_floor():
		_animated_sprite.play("running")

	position.x = 192

	move_and_slide()


func _on_hitbox_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	var delta = get_physics_process_delta_time()
	if body.name == "Body":
		pass
	else:
		change_is_dying = true
		if ascent_distance < 300:
				velocity.y = -ascent_speed
				rotation += rotation_speed * delta
				ascent_distance += ascent_speed * delta
		else:
			velocity.y = descent_speed


func _process(_delta):
	change_is_dying = check_dying_condition()
	if change_is_dying != is_dying:
		is_dying = change_is_dying
		emit_signal("is_dying_changed", is_dying)
		if is_dying:
			turn_off_collision_layer()
			_animated_sprite.play("no animation")

func check_dying_condition():
	return change_is_dying

func turn_off_collision_layer():
	$Body.set_deferred("disabled", true)
	$"Hitbox/Hitbox Area".set_deferred("disabled", true)

