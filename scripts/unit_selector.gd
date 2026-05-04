extends Node2D

var dragging = false
var drag_start = Vector2.ZERO
var selection_rect = RectangleShape2D.new()
var selection_color := Color.AQUA
var selected = []


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			drag_start = get_global_mouse_position()
			for item in selected:
				item.collider.is_selected = false
			selected = []
		elif dragging:
			dragging = false
			var drag_end = get_global_mouse_position()
			selection_rect.extents = abs(drag_end - drag_start) / 2
			var space = get_world_2d().direct_space_state
			var q = PhysicsShapeQueryParameters2D.new()
			q.shape = selection_rect
			q.collision_mask = 2
			q.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(q)
			for item in selected:
				item.collider.is_selected = true

	if event is InputEventMouseMotion:
		queue_redraw()

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		if event.pressed:
			for item in selected:
				item.collider.target = get_global_mouse_position()


func _draw() -> void:
	if dragging:
		draw_rect(Rect2(drag_start, get_global_mouse_position() - drag_start), selection_color, false, 2.0)
