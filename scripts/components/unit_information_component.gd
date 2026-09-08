class_name UnitInformationComponent
extends Control
## signals
## enums
## consts
## exports
@export var team_colors: Array[Color] = [
	Color.BLUE,
	Color.RED,
	Color.YELLOW,
	Color.GREEN,
	Color.PURPLE,
]

## public vars
## private vars
## onready vars
@onready var team_label: Label = $VBoxContainer/InfoBox/TeamLabel
@onready var speed_label: Label = $VBoxContainer/InfoBox/SpeedLabel
@onready var health_label: Label = $VBoxContainer/InfoBox/HealthLabel

## built-in override methods
## public methods
func setup(team: int, speed: float, current_health: float) ->  void:
	if not is_node_ready():
		await ready

	update_team(team)
	update_speed(speed)
	update_health(current_health)


func update_team(team: int) -> void:
	team_label.text = "Team:%d" % team
	if team >= 0 and team < team_colors.size():
		team_label.modulate = team_colors[team]


func update_speed(speed: float) -> void:
	speed_label.text = "SPD:%d" % speed


func update_health(health: float) -> void:
	health_label.text = "HP:%d" % health


## private methods
