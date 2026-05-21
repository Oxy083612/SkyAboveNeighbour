extends Area2D
class_name PrankDo

@export var prank: Prank
@export var floor_manager: FloorManager
@export var floor_level: int
var is_prank_set := false
var is_prank_done := false


var input_flag := false

func _ready():
	input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if input_flag:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if prank != null:
				input_flag = true
				SignalBus.prankdo_action.emit(position.x, floor_manager._get_floor_position(floor_level), prank)
			else:
				print("null")
				
	input_flag = false
