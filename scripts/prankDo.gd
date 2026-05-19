extends Area2D
class_name PrankDo

@export var prank: Prank
@onready var inventory: Inventory = %Control

var input_flag := false
##var requirementsMet = false
var requirementsMet = true
func _ready():
	input_pickable = true
func _input_event(viewport, event, shape_idx):
	if input_flag:
		return

	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if inventory.checkItem(prank.prankRequiredItem):
				requirementsMet=true
			if requirementsMet:
				input_flag = true
				SignalBus.prankdo_action.emit(prank)
			else:
				return
	input_flag = false
