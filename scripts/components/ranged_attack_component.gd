class_name RangedAttackComponent
extends Node2D
## signals
## enums
## consts
## exports
## public vars
## private vars

## onready vars
@onready var attack_detection_range_shape: CollisionShape2D = $AttackDetectionRange/CollisionShape2D

## built-in override methods


func _ready() -> void:
	# Attack Timer and cooldown management
	create_attack_cooldown_timer()

	# Attack shape and range
	if attack_shape:
		if attack_shape.shape is CircleShape2D:
			attack_shape.shape.radius = attack_range
			print("Attack shape set!")
	else:
		print("Could not find attack_shape.")

	# Attack Detection Range
	if attack_detection_range_shape and attack_detection_range_shape.shape is CircleShape2D:
		attack_detection_range_shape.shape.radius = _attack_detection_range
		

	# Initialize team from parent
	if self.get_parent():
		team = self.get_parent().team
		print(node_name + " got set to team " + str(team))


## public methods
func attack() -> void:
	# Check if target is valid and in range
	if target == null:
		print(node_name + "'s target is null. Cancelling attack.")
		return
	
	# Check if attack is on cooldown
	if not _attack_cooldown_timer.is_stopped():
		print(node_name + " cannot attack! Attack still on cooldown!")
	_perform_ranged_attack(target)


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
	if _attack_cooldown_timer == null:
		_attack_cooldown_timer = Timer.new()
		_attack_cooldown_timer.name = "AttackTimer"
		add_child(_attack_cooldown_timer)
		_attack_cooldown_timer.timeout.connect(_on_attack_timeout)
		_attack_cooldown_timer.wait_time = attack_cooldown
		_attack_cooldown_timer.autostart = false


## private methods
func _on_area_entered(area: Area2D) -> void:

	# Check if on separate teams
	if area.get_parent() and area.get_parent().team == self.team:
		print(node_name + " is on the same team as target " + area.get_parent().name + ", Team: " + str(team))
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
	pass