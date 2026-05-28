class_name HealthComponent
extends Node2D

@export var min_health: float = 0.0
@export var max_health: float = 100.0
@export var health_bar: ProgressBar
var health: float


func _ready() -> void:
	health = max_health
	health_bar.min_value = min_health
	health_bar.max_value = max_health
	health_bar.value = health


func _process(_delta: float) -> void:
	rotation = -owner.rotation


func take_damage(damage_amount: float):
	health -= damage_amount
	health_bar.value = health
	print("Health: " + str(self.health))

	if health <= 0:
		get_parent().queue_free()
