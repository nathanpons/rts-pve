extends Node2D

@export var unit_scene_uid = "uid://p52nn01mvgw7" # Ant unit UID
@export var sprite_uid = "uid://bywjfwmyuqynq" # Ant hill
@export var spawn_cooldown: float = 5.0
@export var team: int = 0

var loaded_unit: PackedScene
var units_spawned: int = 0
var spawn_circle_segments: int = 16
var spawn_circle_radius: float = 50.0
var unit_collision_shape: CollisionShape2D

@onready var spawn_position: Vector2 = $SpawnPosition.global_position


func _ready() -> void:
	$Sprite2D.texture = load(sprite_uid)
	loaded_unit = load(unit_scene_uid)
	# unit_collision_shape = loaded_unit.get_collision_shape()
	$SpawnTimer.wait_time = spawn_cooldown
	$SpawnTimer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_unit()


func spawn_unit() -> void:
	var spawn_location = find_viable_spawn_location_on_radius(spawn_position, spawn_circle_radius, spawn_circle_segments)
	if spawn_location == null:
		print("Cannot find viable spawn location for spawner: " + self.name)
		return

	var new_unit = loaded_unit.instantiate()
	new_unit.name = self.name + "/Unit " + str(units_spawned)
	new_unit.team = team
	units_spawned += 1
	get_tree().root.add_child(new_unit)
	new_unit.global_position = spawn_location
	

func find_viable_spawn_location_on_radius(center: Vector2, radius: float, segments: int):
	for i in segments:
		var angle: float = i + PI * 2.0 / segments
		var point: Vector2 = Vector2(center.x + cos(angle) * radius, center.y + sin(angle) * radius)
		# if is_area_clear(point, unit_collision_shape.shape.radius):
		if is_area_clear(point, 10.0):
			return point

	return null


func is_area_clear(global_pos: Vector2, radius: float) -> bool:
	var space_state = get_world_2d().direct_space_state
	
	# Create a circular shape for checking
	var circle_shape = CircleShape2D.new()
	circle_shape.radius = radius
	
	# Set up the query parameters
	var parameters = PhysicsShapeQueryParameters2D.new()
	parameters.shape = circle_shape
	parameters.transform = Transform2D(0.0, global_pos)
	# (Optional) Add specific collision masks to ignore (e.g., your player or map limits)
	# parameters.collision_mask = 0b11111111111111111111 

	# Perform the query
	var result = space_state.intersect_shape(parameters)
	
	# If the result array is empty, nothing is inside the circle
	return result.is_empty()