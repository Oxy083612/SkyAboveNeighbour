extends Area2D
class_name ItemPickup

@export var item: Item

var input_flag := false

func _ready():
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	if input_flag:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			input_flag = true
			SignalBus.pickup_action.emit(item)
			queue_free()

	input_flag = false
