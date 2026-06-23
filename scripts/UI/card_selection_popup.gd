extends Node
## signals
## enums
## consts
## exports
@export var card_container: HBoxContainer
@export var augment_card_uid: String

## public vars
var num_augment_cards: int = 3

## private vars
## onready vars


## built-in override methods
func _ready() -> void:
	_setup_augment_cards()
	if not augment_card_uid:
		print("WARNING: No augment card selected in node: " + self.name)


func _process(_delta: float) -> void:
	pass


## public methods
func get_num_cards() -> int:
	return num_augment_cards


func set_num_cards(num_cards: int) -> void:
	num_augment_cards = num_cards


func clear_augment_cards() -> void:
	var children = card_container.get_children()
	print(children)
	for child in children:
		if "AugmentCard" in child.name:
			child.queue_free()


func set_augment_cards() -> void:
	for i in range(num_augment_cards):
		var augment_card_path = ResourceUID.get_id_path(ResourceUID.text_to_id(augment_card_uid))
		var augment_card_scene: PackedScene = load(augment_card_path)
		var augment_card = augment_card_scene.instantiate()
		augment_card.name = "AugmentCard" + str(i + 1)
		card_container.add_child(augment_card)
		augment_card.set_card_title("Test title for card " + str(i + 1))
		augment_card.set_card_description("Test description for card " + str(i + 1))
		augment_card.set_upgrade_id(i + 1)


## private methods
func _setup_augment_cards() -> void:
	clear_augment_cards()
	set_augment_cards()
