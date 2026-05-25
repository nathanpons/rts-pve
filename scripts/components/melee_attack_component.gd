class_name MeleeAttackComponent
extends Node2D

signal attack_started(attack, target)

@export var attack_damage: int = 10
@export var attack_range: float = 20.0
@export var attack_cooldown: float = 1.0
@export var is_debug: bool = false

var _last_attack_time: float = 0.0
var _attack_timer: Timer = null
var attack_object = load("uid://bv3tc5dkx7in") # attack.gd
var possible_targets = []
var target: Node = null

@onready var attack_shape: CollisionShape2D = get_node("AttackShape")


func _ready() -> void:
	# Attack Timer and cooldown management
	_attack_timer = Timer.new()
	add_child(_attack_timer)
	_attack_timer.timeout.connect(_on_attack_timeout)
	_attack_timer.wait_time = attack_cooldown
	_attack_timer.autostart = false

	# Attack shape and range
	if attack_shape:
		if attack_shape.shape is CircleShape2D:
			attack_shape.shape.radius = attack_range
			print("Attack shape set!")

	else:
		print("Could not find attack_shape.")


func _on_body_entered(body: Node2D):
	if (!possible_targets.has(body)):
		possible_targets.append(body)
		set_target()
		print("Possible target added: " + str(possible_targets))


func _on_body_exited(body: Node2D):
	if (possible_targets.has(body)):
		possible_targets.erase(body)
		set_target()
		print("Possible target removed: " + str(possible_targets))


func _perform_melee_attack(target_node: Unit) -> void:
	if target_node:
		if target_node.team != self.team:
			var attack_data = attack_object.new()
			attack_started.emit(attack_data)


func _on_attack_timeout() -> void:
	if _attack_timer:
		_attack_timer.wait_time = attack_cooldown
		attack()
		_attack_timer.start()


func attack() -> void:
	# Check if target is valid and in range
	if target == null:
		return
	
	_perform_melee_attack(target)


func set_target() -> void:
	if (!possible_targets.is_empty()):
		target = possible_targets[0]
		print("Target set to: " + str(target))
		attack()


func clear_target() -> void:
	target = null
