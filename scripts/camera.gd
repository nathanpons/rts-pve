extends CharacterBody2D

## signals
## enums
## consts
const BASE_SPEED = 200.0
const SPRINT_MARKIPLIER = 2.0
const MIN_ZOOM: Vector2 = Vector2(0.5, 0.5)
const MAX_ZOOM: Vector2 = Vector2(10.0, 10.0)
const ZOOM_INCREMENT: Vector2 = Vector2(0.1, 0.1)
const ZOOM_BASE_SPEED: float = 20.0

## exports
## public vars
var target_zoom: Vector2 = Vector2(4.0, 4.0)
var speed: float = BASE_SPEED

## private vars
## onready vars
@onready var camera: Camera2D = $PlayerCamera

## built-in override methods


func _ready() -> void:
	target_zoom = camera.zoom
	UpgradeController.set_camera(self)


func _physics_process(_delta: float) -> void:
	if Input.is_action_pressed("sprint"):
		speed = BASE_SPEED * SPRINT_MARKIPLIER
	elif Input.is_action_just_released("sprint"):
		speed = BASE_SPEED
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
		velocity.x = horizontal_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if vertical_direction:
		velocity.y = vertical_direction * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	move_and_slide()


func _process(delta: float) -> void:
	camera.zoom = camera.zoom.move_toward(target_zoom, ZOOM_BASE_SPEED * delta)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		target_zoom += ZOOM_INCREMENT
	elif event.is_action_pressed("zoom_out"):
		target_zoom -= ZOOM_INCREMENT

	target_zoom = target_zoom.clamp(MIN_ZOOM, MAX_ZOOM)


## public methods

## private methods
