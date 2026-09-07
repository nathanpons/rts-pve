class_name ProjectileBase
extends Node2D
## signals
## enums
## consts
## exports
@export var speed: float = 30.0

## public vars
var damage: float = 20.0
var direction: Vector2 = Vector2.RIGHT
var target: Node2D = null
var target_last_position: Vector2 = Vector2.ZERO

## private vars
## onready vars
@onready var attack_shape: CollisionShape2D = $Area2D/CollisionShape2D

## built-in override methods
func _physics_process(delta: float) -> void:
	if is_instance_valid(target):
		target_last_position = target.global_position

		var curr_pos = global_position
		var next_pos = curr_pos.move_toward(target_last_position, speed * delta)

		if next_pos != curr_pos:
			look_at(next_pos)

		global_position = next_pos

		if curr_pos.distance_to(target_last_position) < 0.1:
			_projectile_reached_destination()
	else:
		queue_free()
		return

## public methods
func setup(p_target: Node2D, p_damage: float) -> void:
	target = p_target
	damage = p_damage


## private methods
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == target and body.has_method("take_damage"):
		body.take_damage(damage)

	queue_free()


func _projectile_reached_destination() -> void:
	queue_free()
