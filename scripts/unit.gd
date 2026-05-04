extends CharacterBody2D

@export var speed = 100
var rng = RandomNumberGenerator.new()
var av = Vector2.ZERO
var avoid_weight = 0.1
var target_radius = 20
var selected_color = Color(0, 1, 1, 0.25)
var selected_circle = CollisionShape2D.new()
var selected_circle_radius = 10
var is_idle = true
var is_selected = false:
	set = set_selected
var target = null:
	set = set_target


func set_selected(value: bool):
	is_selected = value
	queue_redraw()
	if is_selected:
		pass
	else:
		pass


func set_target(value):
	target = value


func avoid():
	var result = Vector2.ZERO
	var neighbors = $Detect.get_overlapping_bodies()
	if neighbors:
		for neighbor in neighbors:
			result += neighbor.position.direction_to(position)
		result /= neighbors.size()

	return result.normalized()


# func _input(event: InputEvent) -> void:
# 	if event.is_action_pressed("set_target"):
# 		target = get_global_mouse_position()


# func random_movement():
# 	var rand_move_timer = randf_range(5, 25)
# 	await get_tree().create_timer(rand_move_timer).timeout
# 	if velocity == Vector2.ZERO:
# 		var rand_vector2 := Vector2(rng.randf_range(-5, 5), rng.randf_range(-5, 5))
# 		var new_pos = position + rand_vector2
# 		self.set_target(rand_vector2)


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if target != null:
		velocity = position.direction_to(target)
		if position.distance_to(target) < target_radius:
			target = null

	av = avoid()
	velocity = (velocity + av * avoid_weight).normalized() * speed
	move_and_collide(velocity * delta)
	if velocity != Vector2.ZERO:
		var angle = atan2(velocity.y, velocity.x) + deg_to_rad(90)
		rotation = angle
		$AnimationPlayer.play("walking")
	else:
		$AnimationPlayer.play("idle")
		# random_movement()


func _draw() -> void:
	if is_selected:
		draw_circle(Vector2.DOWN, selected_circle_radius, selected_color, false, 1.0)
