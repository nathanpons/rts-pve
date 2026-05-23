class_name Unit
extends CharacterBody2D

enum Faction {
	BUG, # Bug
	BOT, # WOBOT 🤖
	MYSTIC, # Dryads, wisps, ent, elemental. Prob no human forms
	NEUTRAL, # Everything else
}

@export var speed: int = 100
@export var faction: Faction
@export var team: int = 0
@export var health_component: HealthComponent
@export var hitbox_component: HitboxComponent
@export var attack_component: Node2D
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
@onready var idle_movement_timer: Timer = $IdleMovementTimer


func _ready() -> void:
	idle_movement_timer.timeout.connect(_on_idle_movement_timeout)


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if target != null:
		cancel_idle_methods()
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
		if idle_movement_timer.is_stopped():
			print("Starting idle movement for unit %s" % self.name)
			idle_movement()


func _draw() -> void:
	if is_selected:
		draw_circle(Vector2.DOWN, selected_circle_radius, selected_color, false, 1.0)


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


# Idle Movement Workflow
func idle_movement() -> void:
	idle_movement_timer.wait_time = randf_range(5.0, 10.0)
	idle_movement_timer.start()


func get_random_nearby_pos() -> Vector2:
	# Get a random vector in the range of -5 to 5
	var rand_vector2 = Vector2(randf_range(-50.0, 50.0), randf_range(-50.0, 50.0))
	var new_pos = position + rand_vector2
	return new_pos


func move_to_pos_if_idle(pos: Vector2) -> void:
	if not is_instance_valid(self):
		return 
	if target == null:
		target = pos


func _on_idle_movement_timeout() -> void:
	move_to_pos_if_idle(get_random_nearby_pos())
	idle_movement_timer.stop()


func cancel_idle_methods() -> void:
	# Cancel Idle Movement
	idle_movement_timer.stop()


# End Idle Movement workflow
