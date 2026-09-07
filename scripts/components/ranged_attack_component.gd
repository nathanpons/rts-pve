class_name RangedAttackComponent
extends Node2D
## signals
## enums
## consts
## exports
@export var attack_damage: int = 8
@export var projectile_scene_uid: String = "uid://bso2rsgpdonym"
@export var attack_range: float = 100.0
@export var attack_cooldown: float = 1.0
@export var _attack_detection_range: float = attack_range + 50

## public vars
var projectile_scene: PackedScene = null
var attack_object = load("uid://bv3tc5dkx7in") # attack.gd
var possible_targets = []
var target: Node = null
var team: int = 0

## private vars
var _attack_cooldown_timer: Timer = null

## onready vars
@onready var node_name = self.get_parent().name
@onready var attack_detection_range_shape: CollisionShape2D = $AttackDetectionRange/CollisionShape2D
@onready var attack_shape: CollisionShape2D = get_node("AttackShape")

## built-in override methods


func _ready() -> void:
	# Attack Timer and cooldown management
	create_attack_cooldown_timer()

	if ResourceLoader.exists(projectile_scene_uid):
		projectile_scene = load(projectile_scene_uid)

	# Attack shape and range
	if attack_shape and attack_shape.shape is CircleShape2D:
		attack_shape.shape = attack_shape.shape.duplicate()
		attack_shape.shape.radius = attack_range
	else:
		print("Could not find attack_shape.")

	# Attack Detection Range
	if attack_detection_range_shape and attack_detection_range_shape.shape is CircleShape2D:
		attack_detection_range_shape.shape = attack_detection_range_shape.shape.duplicate()
		attack_detection_range_shape.shape.radius = _attack_detection_range
		

	# Initialize team from parent
	if self.get_parent():
		team = self.get_parent().team
		print(node_name + " got set to team " + str(team))


func _process(delta: float) -> void:
	_clean_target_list()

	if target and _attack_cooldown_timer.is_stopped():
		attack()


## public methods
func attack() -> void:
	# # Check if target is valid and in range
	# if target == null:
	# 	print(node_name + "'s target is null. Cancelling attack.")
	# 	return
	
	# # Check if attack is on cooldown
	# if not _attack_cooldown_timer.is_stopped():
	# 	print(node_name + " cannot attack! Attack still on cooldown!")
	# _perform_ranged_attack(target)a

	if not is_instance_valid(target):
		set_target()
		return

	if not _attack_cooldown_timer.is_stopped():
		return # attack on cooldown

	_perform_ranged_attack(target)
	_attack_cooldown_timer.start()


func set_target() -> void:
	if possible_targets.is_empty():
		clear_target()
	else:
		target = possible_targets[0]
		print("Target set to: " + str(target))
		attack()


func clear_target() -> void:
	target = null
	if not _attack_cooldown_timer.is_stopped():
		_attack_cooldown_timer.stop()


func create_attack_cooldown_timer() -> void:
	# if _attack_cooldown_timer == null:
	# 	_attack_cooldown_timer = Timer.new()
	# 	_attack_cooldown_timer.name = "AttackTimer"
	# 	add_child(_attack_cooldown_timer)
	# 	_attack_cooldown_timer.timeout.connect(_on_attack_timeout)
	# 	_attack_cooldown_timer.wait_time = attack_cooldown
	# 	_attack_cooldown_timer.autostart = false


	if _attack_cooldown_timer == null:
		_attack_cooldown_timer = Timer.new()
		_attack_cooldown_timer.name = "AttackTimer"
		_attack_cooldown_timer.one_shot = true
		_attack_cooldown_timer.wait_time = attack_cooldown
		add_child(_attack_cooldown_timer)


## private methods
func _clean_target_list() -> void:
	# Remove bad/missing targets from the list of possible targets
	possible_targets = possible_targets.filter(func(a): return is_instance_valid(a))
	if target and not is_instance_valid(target):
		target = null


func _on_area_entered(area: Area2D) -> void:

	# Check if on separate teams
	if area.get_parent() and area.get_parent().team == self.team:
		return

	# Add target to possible targets
	if not possible_targets.has(area):
		possible_targets.append(area)
		print(node_name + " area added to possible targets")


		# Set target
		set_target()
		print("Possible target added: " + str(possible_targets))


func _on_area_exited(area: Area2D) -> void:
	if (possible_targets.has(area)):
		possible_targets.erase(area)
		set_target()
		print("Possible target removed: " + str(possible_targets))


func _on_attack_timeout() -> void:
	if not _attack_cooldown_timer:
		create_attack_cooldown_timer()
	attack()


func _perform_ranged_attack(target_area: Area2D) -> void:
	if projectile_scene == null:
		push_error("Projectile scene not loaded in RangedAttackComponent")
		return
	
	var projectile = projectile_scene.instantiate()
	get_tree().current_scene.add_child(projectile)

	projectile.global_position = global_position
	if projectile.has_method("setup"):
		projectile.setup(target_area, attack_damage)


func _on_attack_detection_range_area_entered(area: Area2D) -> void:
	var parent_unit = area.get_parent()
	# Ignore same team
	if parent_unit and "team" in parent_unit and parent_unit.team == self.team:
		return

	# If entered node isn't in possible targets list, add it
	if not possible_targets.has(area):
		possible_targets.append(area)
		if target == null:
			set_target()


func _on_attack_detection_range_area_exited(area: Area2D) -> void:
	# Remove exited node from possible targets and reset targeting if the node was the units target
	if possible_targets.has(area):
		possible_targets.erase(area)
		if target == area:
			set_target()
