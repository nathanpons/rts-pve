extends Node
## signals
## enums
## consts
## exports
@export var upgrade_name_node: TextEdit
@export var upgrade_description_node: TextEdit
@export var upgrade_affected_units_node: TextEdit
@export var upgrade_calls_function_node: TextEdit
@export var upgrade_attached_classes_node: TextEdit
@export var upgrade_row_id_node: TextEdit
## public vars
var upgrade_db: SQLite
var upgrade_db_path: String = "res://upgrade_data.db"
## private vars
## onready vars


## built-in override methods
func _ready() -> void:
	upgrade_db = SQLite.new()
	upgrade_db.path = upgrade_db_path
	upgrade_db.open_db()


func _process(delta: float) -> void:
	pass


## public methods


## private methods
func _on_create_table_button_down() -> void:
	var upgrades: Dictionary = {
		"id": {"data_type": "int", "primary_key": true, "not_null": true, "auto_increment": true},
		"name": {"data_type": "text", "not_null": true},
		"description": {"data_type": "text", "not_null": true},
		"affected_units": {"data_type": "text", "not_null": true},
		"calls_function": {"data_type": "text", "not_null": true},
		"classes": {"data_type": "text", "not_null": true},
	}
	upgrade_db.create_table("upgrades", upgrades)


func _on_delete_upgrade_button_down() -> void:
	var row_id = upgrade_row_id_node.text.strip_edges()

	if not row_id:
		print("Please provide an ID for the upgrade to delete.")
		return
	
	var did_delete = upgrade_db.delete_rows("upgrades", "id = " + row_id)
	if did_delete:
		print("Upgrade Successfully Deleted")
	else:
		print("Failed to delete upgrade")

func _on_update_upgrade_button_down() -> void:
	var upgrade_name = upgrade_name_node.text.strip_edges()
	var upgrade_description = upgrade_description_node.text.strip_edges()
	var affected_units = upgrade_affected_units_node.text.strip_edges()
	var calls_function = upgrade_calls_function_node.text.strip_edges()
	var classes = upgrade_attached_classes_node.text.strip_edges()
	var row_id = upgrade_row_id_node.text.strip_edges()
	var update_data: Dictionary = {}

	if not row_id:
		print("Please provide an ID for the upgrade to update.")
		return

	var row_exists = upgrade_db.query(
		"SELECT CASE 
			WHEN EXISTS (SELECT 1 FROM upgrades WHERE id = " +  row_id + ") THEN 1 
			ELSE 0 
		END AS id_exists;"
	)

	if not row_exists:
		print("Cannot find row with ID: " + row_id)
		return

	if upgrade_name:
		update_data["name"] = upgrade_name
	if upgrade_description:
		update_data["description"] = upgrade_description
	if affected_units:
		update_data["affected_units"] = affected_units
	if calls_function:
		update_data["calls_function"] = calls_function
	if classes:
		update_data["classes"] = classes

	if update_data.is_empty():
		print("Please fill in a field to update.")
		return

	var did_update = upgrade_db.update_rows("upgrades", "id = " + row_id, update_data)

	if did_update:
		print("Upgrade updated successfully.")
	else:
		print("Failed to update upgrade.")

func _on_add_upgrade_button_down() -> void:
	var upgrade_name = upgrade_name_node.text.strip_edges()
	var upgrade_description = upgrade_description_node.text.strip_edges()
	var affected_units = upgrade_affected_units_node.text.strip_edges()
	var calls_function = upgrade_calls_function_node.text.strip_edges()
	var classes = upgrade_attached_classes_node.text.strip_edges()

	if upgrade_name and upgrade_description and affected_units and calls_function and classes:
		upgrade_db.insert_row("upgrades", {
			"name": upgrade_name, 
			"description": upgrade_description, 
			"affected_units": affected_units, 
			"calls_function": calls_function,
			"classes": classes
		})
	else:
		print("Please fill in all fields.")


func _on_select_all_upgrades_button_down() -> void:
	var all_rows: Array[Dictionary] = upgrade_db.select_rows("upgrades", "1=1", ["*"])
	print(all_rows)


func _on_select_upgrade_by_name_button_down() -> void:
	var upgrade_name = upgrade_name_node.text.strip_edges()
	var select_condition = "name = '" + upgrade_name + "'"
	var selected_row: Array[Dictionary] = upgrade_db.select_rows("upgrades", select_condition, ["*"])
	print("Upgrade Name: " + upgrade_name)
	print(selected_row)

