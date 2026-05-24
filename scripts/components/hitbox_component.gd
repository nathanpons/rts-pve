class_name HitboxComponent
extends Area2D

@export var health_component : HealthComponent

func _ready() -> void:
	pass

func take_damage(attack_data: Attack):
	print(self.name + " area entered!")
	health_component.take_damage(attack_data.attack_damage)
