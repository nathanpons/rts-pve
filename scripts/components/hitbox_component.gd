class_name HitboxComponent
extends Area2D

@export var health_component : HealthComponent

func _ready() -> void:
	connect("mouse_entered", take_damage)

func take_damage():
	print(self.name + " mouse entered!")
	health_component.take_damage(10.0)
