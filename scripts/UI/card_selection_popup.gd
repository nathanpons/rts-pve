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
	for child in children:
		if "AugmentCard" in child.name:
			child.queue_free()


func set_augment_cards() -> void:
	var augment_card_num = 0
	var upgrades = _select_random_upgrades()
	for upgrade in upgrades:
		augment_card_num += 1
		var augment_card_path = ResourceUID.get_id_path(ResourceUID.text_to_id(augment_card_uid))
		var augment_card_scene: PackedScene = load(augment_card_path)
		var augment_card = augment_card_scene.instantiate()
		augment_card.name = "AugmentCard" + str(augment_card_num)
		card_container.add_child(augment_card)
		augment_card.set_card_title(upgrade.name)
		augment_card.set_card_description(upgrade.description)
		augment_card.set_card_icon(upgrade.icon_uid)
		augment_card.set_card_affected_units(upgrade.affected_units)
		augment_card.set_card_affected_classes(upgrade.classes)
		augment_card.set_function(upgrade.calls_function)
		augment_card.set_upgrade_id(upgrade.id)


## private methods
func _setup_augment_cards() -> void:
	clear_augment_cards()
	set_augment_cards()


func _select_random_upgrades() -> Array:
	var selected_upgrades = []
	var all_upgrades = UpgradeController.get_upgrades()
	var num_upgrades = min(num_augment_cards, len(all_upgrades))
	all_upgrades.shuffle()
	if num_upgrades > 0:
		selected_upgrades = all_upgrades.slice(0, num_upgrades)

	return selected_upgrades
