extends Area2D
class_name ItemPickup

@export var items: Array[Item]
@export var floor_manager: FloorManager
@export var floor_level: int

var input_flag := false
@export var is_empty := false

func _ready():
	input_pickable = true

func _input_event(_viewport, event, _shape_idx):
	if input_flag:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			input_flag = true
			SignalBus.pickup_action.emit(position.x, floor_manager._get_floor_position(floor_level), self)
	input_flag = false
