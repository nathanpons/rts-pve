extends Node2D

var dragging = false
var drag_start = Vector2.ZERO
var selection_rect = RectangleShape2D.new()
var selection_color := Color.AQUA

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			queue_redraw()
			var drag_end = get_global_mouse_position()
			selection_rect.extents = abs(drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var q = PhysicsShapeQueryParameters2D.new()
			q.shape = selection_rect
			q.collision_mask = 2
			q.transform = Transform2D(0, (drag_end + drag_start) / 2)
	if event is InputEventMouseMotion and dragging:
		queue_redraw()

func _draw() -> void:
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), selection_color, false, 2.0)


# Called when the node enters the scene tree for the first time.
# func _ready() -> void:
	# # Create collision and make it centered
	# var rect = RectangleShape2D.new()
	# rect.size = hit_area.body_shape.size
	# hit_area.shape = rect
	
	# # Make collision shape centered on Area2D
	# hit_area.body_shape = rect
	# # Note: Area2D expects a CollisionShape2D
	# # If you are using a Texture, the Area2D shape is defined by TextureRect
	# # For simplicity, let's use a basic rectangle.
	# hit_area.body_shape = RectangleShape2D.new()
	# hit_area.body_shape.size = Vector2(20, 20)
	
# func _on_hit_area_body_entered(body: RigidBody2D) -> void:
# 	# This is mainly for physics. For selection, we ignore this
# 	# But if you use the Area2D for collision detection, you can toggle selection here
# 	pass

# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta: float) -> void:
# 	pass

# func highlight(color: Color) -> void:
# 	hit_area.modulate = color

# func dehighlight() -> void:
# 	hit_area.modulate = selection_color

# func is_in_selection_area(min_pos: Vector2, max_pos: Vector2) -> bool:
# 	var unit_position = hit_area.global_position
# 	return min_pos.x < unit_position.x and unit_position.x < max_pos.x and \
# 		   min_pos.y < unit_position.y and unit_position.y < max_pos.y
