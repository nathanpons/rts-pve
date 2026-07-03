class_name HealthComponent
extends Node2D

@export var min_health: float = 0.0
@export var max_health: float = 100.0
@export var health_bar: ProgressBar
var curr_health: float


func _ready() -> void:
	curr_health = max_health
	health_bar.min_value = min_health
	health_bar.max_value = max_health
	health_bar.value = curr_health


func _process(_delta: float) -> void:
	rotation = -owner.rotation


func get_max_health() -> float:
	return max_health


func set_max_health(new_max_health: float) -> void:
	max_health = new_max_health


func take_damage(damage_amount: float):
	curr_health -= damage_amount
	health_bar.value = curr_health
	print("Health: " + str(self.curr_health))

	if curr_health <= 0:
		get_parent().queue_free()
