class_name Attack
extends Node2D

enum AttackType {
	BIOLOGICAL,
	PHYSICAL,
	MAGIC,
	LASER,
	FIRE,
	ICE,
}

var attack_damage: float = 1.0
var attack_type: AttackType

func _init(damage: float, type: AttackType) -> void:
	self.attack_damage = damage
	self.attack_type = type
