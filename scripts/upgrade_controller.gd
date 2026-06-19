extends Node
## signals
## enums
## consts
## exports
## public vars
var upgrade_db: SQLite
var upgrade_db_path: String = "res://data.db"

## private vars
var _owned_upgrades: Array[Upgrade] = []
## onready vars
## built-in override methods


func _ready() -> void:
	upgrade_db = SQLite.new()
	upgrade_db.path = upgrade_db_path
	upgrade_db.open_db()

	create_upgrade_table()

func _process(delta: float) -> void:
	pass


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


## private methods
