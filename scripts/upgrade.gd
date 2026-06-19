class_name Upgrade
extends Node
## signals
## enums
## consts
## exports
## public vars
var id: int

## private vars
var _name: String = "base upgrade name"
var _description: String = "base upgrade description"
var _affected_units: Array[String] = []

## onready vars


## built-in override methods
func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass


## public methods
func get_upgrade_name() -> String:
	return _name


func set_upgrade_name(upgrade_name: String) -> void:
	_name = upgrade_name


func get_upgrade_description() -> String:
	return _description


func set_upgrade_description(upgrade_description: String) -> void:
	_description = upgrade_description


func get_affected_units() -> Array[String]:
	return _affected_units


func add_affected_unit(unit_name: String) -> void:
	if unit_name not in _affected_units:
		_affected_units.append(unit_name)


func remove_affected_unit(unit_name: String) -> void:
	if unit_name in _affected_units:
		_affected_units.erase(unit_name)


## private methods
