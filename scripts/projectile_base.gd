class_name ProjectileBase
extends Node2D
## signals
## enums
## consts
## exports
@export var speed: float = 30.0
@export var damage: float = 20.0

## public vars
var direction: Vector2 = Vector2.RIGHT
## private vars
## onready vars
@onready var attack_shape: CollisionShape2D = $Area2D/CollisionShape2D

## built-in override methods
func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

## public methods
## private methods
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)

	queue_free()
