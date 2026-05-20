extends Control
class_name Medals

enum MedalState {
	GOOD,
	BAD,
	NONE
}

var current_state = MedalState.NONE
var medal_none = preload("res://UI/pngs/faceon_silver_coin.png")
var medal_good = preload("res://UI/pngs/gold_trophy.png")
var medal_bad = preload("res://UI/pngs/face_on_cross.png")

@onready var texture = $CenterContainer/TextureRect

func _init() -> void:
	current_state = MedalState.NONE
	texture.texture = medal_bad
	
func _change_medal(name):
	match name:
		"bad":
			texture.texture = medal_bad
			current_state = MedalState.BAD
		"good":
			texture.texture = medal_good
			current_state = MedalState.GOOD
		_:
			texture.texture = medal_none
			current_state = MedalState.NONE
	
