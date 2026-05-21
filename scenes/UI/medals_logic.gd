extends Control
class_name Medal

enum MedalState {
	GOOD,
	BAD,
	NONE
}

var current_state = MedalState.NONE
var medal_none = preload("res://assets/UI/pngs/faceon_silver_coin.png")
var medal_good = preload("res://assets/UI/pngs/faceon_gold_coin.png")
var medal_bad = preload("res://assets/UI/pngs/face_on_cross.png")

@onready var texture = $TextureRect

func _ready() -> void:
	current_state = MedalState.NONE
	texture.texture = medal_none
	
func _change_medal(type):
	print(texture)
	match type:
		"bad":
			texture.texture = medal_bad
			current_state = MedalState.BAD
		"good":
			texture.texture = medal_good
			current_state = MedalState.GOOD
		_:
			texture.texture = medal_none
			current_state = MedalState.NONE
	
