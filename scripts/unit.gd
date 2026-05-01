extends CharacterBody2D

@export var speed = 100
var target = null

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("set_target"):
		target = get_global_mouse_position()

func _physics_process(delta: float) -> void:
	if target != null:
		velocity = position.direction_to(target)
	velocity = velocity.normalized() * speed
	move_and_collide(velocity * delta)
	if velocity != Vector2.ZERO:
		var angle = atan2(velocity.y, velocity.x) + deg_to_rad(90)
		rotation = angle
		$AnimationPlayer.play("walking")
	else:
		$AnimationPlayer.play("idle")
