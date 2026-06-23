extends Node
## signals
## enums
## consts
## exports
@export var image_node: TextureRect
@export var title_node: Label
@export var description_node: Label

## public vars

## private vars
var _upgrade_id: int = 0
var _card_icon: Texture2D
var _card_title: String = "Test Title"
var _card_description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

## onready vars

## built-in override methods
func _ready() -> void:
	set_defaults()


func _process(_delta: float) -> void:
	pass


## public methods
func get_upgrade_id() -> int:
	return _upgrade_id


func set_upgrade_id(id: int) -> void:
	_upgrade_id = id


func set_card_icon(icon_uid: String) -> void:
	var icon = load(icon_uid)
	# if typeof(image) is not Texture2D:
	# 	print("Cannot set card image. Expected type Texture2D, instead got: " + typeof(image))
	self._card_icon = icon
	image_node.texture = icon


func set_card_title(title: String) -> void:
	self._card_title = title
	title_node.text = title


func set_card_description(description: String) -> void:
	self._card_description = description
	description_node.text = description


func set_defaults() -> void:
	set_card_icon("uid://xs6qn84uoqi8")
	set_card_title("Test upgrade title")
	set_card_description("Test upgrade description")


## private methods
func _on_panel_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("select"):
		print("Augment Clicked. Has upgrade id: " + str(get_upgrade_id()))
		UpgradeController.upgrade_selected.emit(get_upgrade_id())

