class_name MeleeAttackComponent
extends Node2D

@export var attack_damage: float = 10.0
@export var attack_range: float = 20.0
@export var attack_cooldown: float = 1.0
@export var _attack_detection_range: float = attack_range + 50.0

var _attack_cooldown_timer: Timer = null
var possible_targets: Array[Area2D] = []
var target: Area2D = null
var team: int = 0
var node_name: String

@onready var attack_shape: CollisionShape2D = get_node_or_null("AttackShape")
@onready var attack_detection_range_shape: CollisionShape2D = $AttackDetectionRange/CollisionShape2D


func _ready() -> void:
	create_attack_cooldown_timer()

	if self.get_parent():
		node_name = self.get_parent().name
	else:
		node_name = "MeleeAttackComponent"

	# Shape configuration with unique instances
	if attack_shape and attack_shape.shape is CircleShape2D:
		attack_shape.shape = attack_shape.shape.duplicate()
		attack_shape.shape.radius = attack_range

	if attack_detection_range_shape and attack_detection_range_shape.shape is CircleShape2D:
		attack_detection_range_shape.shape = attack_detection_range_shape.shape.duplicate()
		attack_detection_range_shape.shape.radius = _attack_detection_range

	if get_parent() and "team" in get_parent():
		team = get_parent().team


func _process(_delta: float) -> void:
	_clean_target_list()

	# Continuous attack loop while holding a valid target
	if target and _attack_cooldown_timer.is_stopped():
		attack()


func attack() -> void:
	if not is_instance_valid(target):
		set_target()
		return

	if not _attack_cooldown_timer.is_stopped():
		return

	_perform_melee_attack(target)


func set_target() -> void:
	_clean_target_list()
	if possible_targets.is_empty():
		clear_target()
	else:
		target = possible_targets[0]


func clear_target() -> void:
	target = null
	if _attack_cooldown_timer and not _attack_cooldown_timer.is_stopped():
		_attack_cooldown_timer.stop()


func create_attack_cooldown_timer() -> void:
	if _attack_cooldown_timer == null:
		_attack_cooldown_timer = Timer.new()
		_attack_cooldown_timer.name = "AttackTimer"
		_attack_cooldown_timer.one_shot = true # Set to one_shot so .is_stopped() works reliably
		_attack_cooldown_timer.wait_time = attack_cooldown
		add_child(_attack_cooldown_timer)


func _clean_target_list() -> void:
	possible_targets = possible_targets.filter(func(a): return is_instance_valid(a))
	if target and not is_instance_valid(target):
		target = null


func _perform_melee_attack(target_area: Area2D) -> void:
	if not is_instance_valid(target_area):
		return

	# Check for take_damage on area first, then parent (matches projectile logic)
	if target_area.has_method("take_damage"):
		target_area.take_damage(attack_damage)
		_attack_cooldown_timer.start()
	elif target_area.get_parent() and target_area.get_parent().has_method("take_damage"):
		target_area.get_parent().take_damage(attack_damage)
		_attack_cooldown_timer.start()


func _on_area_entered(area: Area2D) -> void:
	var parent_unit = area.get_parent()
	if parent_unit and "team" in parent_unit and parent_unit.team == self.team:
		return

	if not possible_targets.has(area):
		possible_targets.append(area)
		if target == null:
			set_target()


func _on_area_exited(area: Area2D) -> void:
	if possible_targets.has(area):
		possible_targets.erase(area)
		if target == area:
			set_target()