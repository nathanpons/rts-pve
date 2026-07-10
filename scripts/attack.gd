class_name Attack
extends Resource

enum AttackType {
	BIOLOGICAL,
	PHYSICAL,
	MAGIC,
	LASER,
	FIRE,
	ICE,
}

@export var attack_damage: float = 1.0
@export var attack_type: AttackType

func _init(_damage: float, _type: AttackType) -> void:
	self.attack_damage = _damage
	self.attack_type = _type
