class_name HealthComponent
extends Node2D

@export var MAX_HEALTH := 100
var health: float


func _ready() -> void:
	health = MAX_HEALTH


func take_damage(damage_amount: float):
	health -= damage_amount
	print("Health: " + str(self.health))

	if health <= 0:
		get_parent().queue_free()
