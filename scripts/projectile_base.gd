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
func _projectile_reached_destination() -> void:
	print("Projectile reached it's destination without hitting the target!")
	queue_free()


# func _on_area_2d_area_entered(area: Area2D) -> void:
# 	# Ignore if it's not our targeted node or targeted node's hurtbox
# 	print("Projectile has entered its target's area")
# 	if area != target:
# 		print("projectile area entered wasn't it's target. Target: " + str(target.name) + " Area: " + str(area.name))
# 		return

# 	# Find the target unit node to apply damage
# 	var target_unit = area.get_parent() if area.get_parent() else area

# 	if target_unit.has_method("take_damage"):
# 		target_unit.take_damage(damage)

# 	queue_free() # Destroy projectile on hit


func _on_area_2d_area_entered(area: Area2D) -> void:
	# 1. Verify if the entered area OR its parent is our target
	var is_target = (area == target) or (area.get_parent() == target)
	
	if not is_target:
		return


	# 2. Check for take_damage on the area FIRST (matching your melee setup), then try parent
	if area.has_method("take_damage"):
		area.take_damage(damage)
	elif area.get_parent() and area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(damage)
	else:
		print("No take_damage method found on hit target or its parent!")

	queue_free() # Destroy projectile on hit
