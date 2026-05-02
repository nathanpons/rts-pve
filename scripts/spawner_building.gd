extends Node2D

@export var unit_scene_path = "res://scenes/unit.tscn"
var loaded_unit: PackedScene

func _ready() -> void:
	loaded_unit = load(unit_scene_path)

func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var new_unit = loaded_unit.instantiate()
	get_tree().root.add_child(new_unit)
	new_unit.global_position = $SpawnPosition
