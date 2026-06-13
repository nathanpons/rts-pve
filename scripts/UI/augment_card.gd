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
var _card_image: Texture2D
var _card_title: String = "Test Title"
var _card_description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."

## onready vars

## built-in override methods
func _ready() -> void:
	set_defaults()


func _process(_delta: float) -> void:
	pass


## public methods
func set_card_image(image_uid: String) -> void:
	var image = load(image_uid)
	# if typeof(image) is not Texture2D:
	# 	print("Cannot set card image. Expected type Texture2D, instead got: " + typeof(image))
	self._card_image = image
	image_node.texture = image


func set_card_title(title: String) -> void:
	self._card_title = title
	title_node.text = title


func set_card_description(description: String) -> void:
	self._card_description = description
	description_node.text = description


## private methods
func set_defaults() -> void:
	set_card_image("uid://xs6qn84uoqi8")
	set_card_title("gaming")
	set_card_description("France moment")
