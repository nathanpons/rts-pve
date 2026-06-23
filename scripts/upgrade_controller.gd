extends Node
## signals
signal upgrade_selected(upgrade_id: int)

## enums
## consts
## exports

## public vars
var upgrade_db: SQLite
var upgrade_db_path: String = "res://upgrade_data.db"
var upgrade_table_name: String = "upgrades"
var owned_upgrades_table_name: String = "owned_upgrades"
var is_card_selection = false
var card_selection_popup = preload("uid://kc05cxcj7ery")
var ui_layer: CanvasLayer

## private vars
var _camera: Node
var _owned_upgrades: Array[Upgrade] = []

## onready vars


## built-in override methods
func _ready() -> void:
	upgrade_db = SQLite.new()
	upgrade_db.path = upgrade_db_path
	upgrade_db.open_db()

	if is_instance_valid(_camera):
		_get_canvas_layer()

	upgrade_selected.connect(_on_upgrade_selected)


func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if not is_instance_valid(_camera):
			print("No camera selected in upgrade controller using event: " + str(event))
			return
		if not is_card_selection:
			open_card_selection_popup()
			is_card_selection = true
		else:
			close_card_selection_popup()
			is_card_selection = false


## public methods
func get_upgrades() -> Array:
	var all_rows: Array[Dictionary] = upgrade_db.select_rows(upgrade_table_name, "1=1", ["*"])
	return all_rows


func get_upgrade_by_id(upgrade_id: int, table_name: String):
	var upgrade_data = upgrade_db.select_rows(table_name, "id = " + str(upgrade_id), ["*"])
	_owned_upgrades.append(upgrade_data)


func add_upgrade(upgrade: Upgrade) -> void:
	if upgrade not in _owned_upgrades:
		_owned_upgrades.append(upgrade)


func remove_upgrade(upgrade: Upgrade) -> void:
	if upgrade in _owned_upgrades:
		_owned_upgrades.erase(upgrade)


func open_card_selection_popup() -> void:
	print("open_card_selection_popup called")
	var game_objects = ui_layer.get_children()
	if "card_selection_popup" not in game_objects:
		var card_selection_popup_instance = card_selection_popup.instantiate()
		card_selection_popup_instance.name = "card_selection_popup"
		ui_layer.add_child(card_selection_popup_instance)
		Engine.time_scale = 0.0


func close_card_selection_popup() -> void:
	print("close_card_selection_popup called")
	var game_objects = ui_layer.get_children()
	for child in game_objects:
		if child.name == "card_selection_popup":
			child.queue_free()
			Engine.time_scale = 1.0


func set_camera(camera: Node):
	_camera = camera
	_get_canvas_layer()


## private methods
func _on_upgrade_selected(upgrade_id: int) -> void:
	print("Upgrade Info received in upgrade controller: " + str(upgrade_id))
	var upgrade = get_upgrade_by_id(upgrade_id, upgrade_table_name)
	add_upgrade(upgrade)


func _get_canvas_layer() -> void:
	for child in _camera.get_children():
		if child.name == "CanvasLayer":
			ui_layer = child
			return

