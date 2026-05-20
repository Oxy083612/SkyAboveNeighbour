extends Area2D
class_name PrankDo

@export var prank: Prank

var input_flag := false

func _ready():
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if input_flag:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if prank != null:
				input_flag = true
				SignalBus.prankdo_action.emit(position.x, 450, prank)
			else:
				print("null")
				
	input_flag = false
