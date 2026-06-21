class_name TableData
extends Node
## signals

## enums

## consts

## exports

## public vars
static var upgrades_table: Dictionary = {
	"id": {"data_type": "int", "primary_key": true, "not_null": true, "auto_increment": true},
	"name": {"data_type": "text", "not_null": true},
	"description": {"data_type": "text", "not_null": true},
	"icon_uid": {"data_type": "text", "not_null": true},
	"affected_units": {"data_type": "text", "not_null": true},
	"calls_function": {"data_type": "text", "not_null": true},
	"classes": {"data_type": "text", "not_null": true},
}

## private vars

## onready vars

## built-in override methods

## public methods
static func get_upgrades_table() -> Dictionary:
	return upgrades_table


## private methods
