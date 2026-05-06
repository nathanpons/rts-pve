extends Node2D

@export var unit_scene_path = "res://scenes/unit.tscn"
var loaded_unit: PackedScene
var units_spawned: int = 0

func _ready() -> void:
	loaded_unit = load(unit_scene_path)


func _process(delta: float) -> void:
	pass


func _on_spawn_timer_timeout() -> void:
	var new_unit = loaded_unit.instantiate()
	new_unit.name = self.name + "/Unit " + str(units_spawned)
	units_spawned += 1
	get_tree().root.add_child(new_unit)
	new_unit.global_position = $SpawnPosition.global_position
