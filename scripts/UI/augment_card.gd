extends Node
## signals
## enums
## consts
## exports
@export var image_node: TextureRect
@export var title_node: Label
@export var description_node: Label
@export var affected_units_node: Label
@export var affected_classes_node: Label

## public vars

## private vars
var _upgrade_id: int = 0
var _card_icon: Texture2D
var _card_title: String = "Test Title"
var _card_description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
var _affected_units: Array = ["Spore", "Botling"]
var _affected_classes: Array = ["Firemen"]
var _function: String = "_on_choose_test_upgrade()"

## onready vars

## built-in override methods
func _ready() -> void:
	_set_defaults()


func _process(_delta: float) -> void:
	pass


## public methods
func get_upgrade_id() -> int:
	return _upgrade_id


func set_upgrade_id(id: int) -> void:
	self._upgrade_id = id


func set_card_icon(icon_uid: String) -> void:
	var icon = load(icon_uid)
	# if typeof(image) is not Texture2D:
	# 	print("Cannot set card image. Expected type Texture2D, instead got: " + typeof(image))
	self._card_icon = icon
	self.image_node.texture = icon


func set_card_title(title: String) -> void:
	self._card_title = title
	self.title_node.text = title


func set_card_description(description: String) -> void:
	self._card_description = description
	self.description_node.text = description


func set_card_affected_units(units_string: String) -> void:
	var units = units_string.split(", ")
	for unit in units:
		unit = unit.strip_edges()
	self._affected_units = units
	var stringified_units = "Units: "
	for i in range(len(units)):
		stringified_units += str(units[i])
		if i < len(units) - 1:
			stringified_units += ", "
	self.affected_units_node.text = stringified_units


func set_card_affected_classes(classes_string: String) -> void:
	var classes = classes_string.split(", ")
	for item in classes:
		item = item.strip_edges()
	self._affected_classes = classes
	var stringified_classes = "Classes: "
	for i in range(len(classes)):
		stringified_classes += str(classes[i])
		if i < len(classes) - 1:
			stringified_classes += ", "
	self.affected_classes_node.text = stringified_classes


func get_function() -> String:
	return self._function


func set_function(function_name: String) -> void:
	self._function = function_name



## private methods
func _set_defaults() -> void:
	set_card_icon("uid://xs6qn84uoqi8")
	set_card_title("Test upgrade title")
	set_card_description("Test upgrade description")


func _on_panel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		print("Augment Clicked. Has upgrade id: " + str(get_upgrade_id()))
		UpgradeController.upgrade_selected.emit(get_upgrade_id())

