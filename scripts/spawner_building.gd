extends Node2D

@export var unit_scene_uid = "uid://p52nn01mvgw7" # Ant unit UID
@export var spawn_cooldown: float = 5.0
@export var team: int = 0

var loaded_unit: PackedScene
var units_spawned: int = 0

func _ready() -> void:
	loaded_unit = load(unit_scene_uid)
	$SpawnTimer.wait_time = spawn_cooldown
	$SpawnTimer.start()


func _on_spawn_timer_timeout() -> void:
	var new_unit = loaded_unit.instantiate()
	new_unit.name = self.name + "/Unit " + str(units_spawned)
	units_spawned += 1
	get_tree().root.add_child(new_unit)
	new_unit.global_position = $SpawnPosition.global_position
