extends Node
## signals
## enums
## consts
## exports
@export var camera: Node

## public vars
var upgrade_db: SQLite
var upgrade_db_path: String = "res://data.db"
var is_card_selection = false
var card_selection_popup = preload("uid://kc05cxcj7ery")
var ui_layer: CanvasLayer

## private vars
var _owned_upgrades: Array[Upgrade] = []

## onready vars

## built-in override methods


func _ready() -> void:
	upgrade_db = SQLite.new()
	upgrade_db.path = upgrade_db_path
	upgrade_db.open_db()

	create_upgrade_table()

	get_canvas_layer()

func _process(delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		if not is_card_selection:
			open_card_selection_popup()
			is_card_selection = true
		else:
			close_card_selection_popup()
			is_card_selection = false


## public methods
func create_upgrade_table() -> void:
	var upgrades: Dictionary = {
		"id": "INTEGER PRIMARY KEY AUTOINCREMENT",
		"name": "TEXT NOT NULL",
		"description": "TEXT NOT NULL",
		"affected_units": "TEXT",
	}


func get_upgrades() -> Array[Upgrade]:
	return _owned_upgrades


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


func get_canvas_layer() -> void:
	for child in camera.get_children():
		if child.name == "CanvasLayer":
			ui_layer = child
			return


## private methods
	