extends Area2D

# Emitted when instantiate
signal instantiated


# Member variables
var angle := 0.0 setget set_angle
var direction := Vector2.ZERO


# Export variables
export var speed := 500


func _physics_process(delta):
	position += direction * speed * delta


func set_angle(value):
	angle = value
	emit_signal("instantiated")


func _on_Bullet_instantiated():
	rotation_degrees = rad2deg(angle)

	var x_dir = cos(angle)
	var y_dir = sin(angle)

	direction = Vector2(x_dir, y_dir)

func _on_Bullet_body_entered(_body: Node):
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport):
	queue_free()
