class_name MeleeAttackComponent
extends Node2D

@export var attack_damage: int = 10
@export var attack_range: float = 20.0
@export var attack_cooldown: float = 1.0

var _attack_cooldown_timer: Timer = null
var attack_object = load("uid://bv3tc5dkx7in") # attack.gd
var possible_targets = []
var target: Node = null

@onready var node_name = self.get_parent().name
@onready var attack_shape: CollisionShape2D = get_node("AttackShape")


func _ready() -> void:
	# Attack Timer and cooldown management
	_attack_cooldown_timer = Timer.new()
	_attack_cooldown_timer.name = "AttackTimer"
	add_child(_attack_cooldown_timer)
	_attack_cooldown_timer.timeout.connect(_on_attack_timeout)
	_attack_cooldown_timer.wait_time = attack_cooldown
	_attack_cooldown_timer.autostart = false

	# Attack shape and range
	if attack_shape:
		if attack_shape.shape is CircleShape2D:
			attack_shape.shape.radius = attack_range
			print("Attack shape set!")

	else:
		print("Could not find attack_shape.")


func _on_area_entered(area: Area2D) -> void:
	# Add target to possible targets
	if not possible_targets.has(area):
		possible_targets.append(area)

		# Check if on separate teams
		

		# Set target
		set_target()
		print("Possible target added: " + str(possible_targets))


func _on_area_exited(area: Area2D) -> void:
	if (possible_targets.has(area)):
		possible_targets.erase(area)
		set_target()
		print("Possible target removed: " + str(possible_targets))


func _on_attack_timeout() -> void:
	print(node_name + " attack timer ran out!")
	if not _attack_cooldown_timer:
		_attack_cooldown_timer = Timer.new()
	print(node_name + " setting attack timer")
	_attack_cooldown_timer.wait_time = attack_cooldown
	attack()


func _perform_melee_attack(target_area: Area2D) -> void:
	if target_area:
		var attack_data = 10.0 # Temporary attack data
		if is_instance_valid(target) and target.has_method("take_damage"):
			print(node_name + " is attacking target: " + str(target.get_parent().name))
			target.take_damage(attack_data)
			_attack_cooldown_timer.start()
		else:
			print("No take_damage method found on target: " + str(target.name))	


func attack() -> void:
	# Check if target is valid and in range
	if target == null:
		print(node_name + "'s target is null. Cancelling attack.")
		return
	
	# Check if attack is on cooldown
	if not _attack_cooldown_timer.is_stopped():
		print(node_name + " cannot attack! Attack still on cooldown!")
	_perform_melee_attack(target)


func set_target() -> void:
	if not possible_targets.is_empty():
		target = possible_targets[0]
		print("Target set to: " + str(target))
		attack()


func clear_target() -> void:
	target = null
