@tool
class_name GameController
extends Node2D

@export var selection_color := Color(1, 1, 0)
@export var deselection_color := Color(0, 0, 0)
@export var highlight_modulate := Color(0.5, 1, 0, 0.5)
@export var units: Array[Node]

# Track the mouse down position for drag selection
@export var mouse_down_pos := Vector2()
var selected_units: Array[MyUnit]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Assume we have a "Units" container or get them dynamically
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
