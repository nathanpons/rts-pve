@tool
class_name MyUnit
extends Node2D


@onready var hit_area = $Area2D
@export var selection_color := Color(1, 1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create collision and make it centered
	var rect = RectangleShape2D.new()
	rect.size = hit_area.body_shape.size
	hit_area.shape = rect
	
	# Make collision shape centered on Area2D
	hit_area.body_shape = rect
	# Note: Area2D expects a CollisionShape2D
	# If you are using a Texture, the Area2D shape is defined by TextureRect
	# For simplicity, let's use a basic rectangle.
	hit_area.body_shape = RectangleShape2D.new()
	hit_area.body_shape.size = Vector2(20, 20)
	
func _on_hit_area_body_entered(body: RigidBody2D) -> void:
	# This is mainly for physics. For selection, we ignore this
	# But if you use the Area2D for collision detection, you can toggle selection here
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
