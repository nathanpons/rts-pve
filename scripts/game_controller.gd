@tool
class_name GameController
extends Node2D


var is_card_selection = false
var card_selection_popup = preload("uid://kc05cxcj7ery")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _unhandled_input(event: InputEvent) -> void:
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