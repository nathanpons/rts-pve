extends CharacterBody2D

const SPEED = 100.0
const MIN_ZOOM: Vector2 = Vector2(0.5, 0.5)
const MAX_ZOOM: Vector2 = Vector2(10.0, 10.0)
const ZOOM_INCREMENT: Vector2 = Vector2(0.1, 0.1)
const ZOOM_SPEED: float = 20.0

var is_card_selection = false
var card_selection_popup = preload("uid://kc05cxcj7ery")
var target_zoom: Vector2 = Vector2(4.0, 4.0)
# const JUMP_VELOCITY = -300.0

@onready var camera: Camera2D = $PlayerCamera


func _ready() -> void:
	target_zoom = camera.zoom


func _physics_process(_delta: float) -> void:
	# Add the gravity.
	# if not is_on_floor():
		# velocity += get_gravity() * delta

	# Handle jump.
	# if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		# velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var horizontal_direction := Input.get_axis("move_left", "move_right")
	var vertical_direction := Input.get_axis("move_up", "move_down")
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if vertical_direction:
		velocity.y = vertical_direction * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()


func _process(delta: float) -> void:
	camera.zoom = camera.zoom.move_toward(target_zoom, ZOOM_SPEED * delta)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		target_zoom += ZOOM_INCREMENT
	elif event.is_action_pressed("zoom_out"):
		target_zoom -= ZOOM_INCREMENT

	target_zoom = target_zoom.clamp(MIN_ZOOM, MAX_ZOOM)

	if event.is_action_pressed("jump"):
		if not is_card_selection:
			open_card_selection_popup()
			is_card_selection = true
		else:
			close_card_selection_popup()
			is_card_selection = false


func open_card_selection_popup() -> void:
	print("open_card_selection_popup called")
	var game_objects = get_children()
	if "card_selection_popup" not in game_objects:
		var card_selection_popup_instance = card_selection_popup.instantiate()
		card_selection_popup_instance.name = "card_selection_popup"
		add_child(card_selection_popup_instance)


func close_card_selection_popup() -> void:
	print("close_card_selection_popup called")
	var game_objects = get_children()
	for child in game_objects:
		if child.name == "card_selection_popup":
			child.queue_free()