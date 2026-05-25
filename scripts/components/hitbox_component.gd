class_name HitboxComponent
extends Area2D

@export var health_component : HealthComponent

func _ready() -> void:
	pass

func take_damage(attack_data):
	print(self.name + " area entered!")
	if is_instance_valid(health_component):
		health_component.take_damage(attack_data)
	else:
		print("Health component not found.")
