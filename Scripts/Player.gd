extends KinematicBody2D


# Const members
const Bullet := preload("res://Objects/Bullet.tscn")


## Exported variables
export var acceleration := 500
export var max_speed := 150
export var friction := 500


# Variable members
var input_vector := Vector2.ZERO;
var velocity := Vector2.ZERO;


# On ready variables
onready var animation_tree := $AnimationTree as AnimationTree
onready var playback := animation_tree.get("parameters/playback") as AnimationNodeStateMachinePlayback
onready var bullet_spawn_point := $BulletSpawnPoint as Position2D


# Input setup
func _process(_delta: float):
	var horizontal = Input.get_axis("ui_left", "ui_right")
	var vertical = Input.get_axis("ui_up", "ui_down")

	input_vector = Vector2(horizontal, vertical).normalized()


# Player behaviours
func _physics_process(delta):
	if input_vector != Vector2.ZERO:
		velocity = velocity.move_toward(input_vector * max_speed, acceleration * delta)
		playback.travel("player_walk")
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		playback.travel("RESET")

	# Alternative: look_at(get_global_mouse_position())
	var direction_to_mouse = position.direction_to(get_global_mouse_position())
	var angle_in_rad = atan2(direction_to_mouse.y, direction_to_mouse.x)

	rotation_degrees = rad2deg(angle_in_rad)

	if Input.is_action_just_pressed("ui_accept"):
		var bullet := Utils.instantiate(Bullet, bullet_spawn_point.global_position, get_tree().current_scene) as Area2D
		bullet.angle = angle_in_rad

	velocity = move_and_slide(velocity)
