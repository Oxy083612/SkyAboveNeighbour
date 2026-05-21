
class_name Door
extends Area2D
@export var current_floor : int
@export var destination_floor : int
@export var floor_manager : FloorManager

@export var destination_door : Door
@onready var destination_point = $DestinationPoint

var input_flag = false

func _get_exit_position() -> Vector2:
	return destination_point.global_position

func _on_body_entered(body: Node2D) -> void:
	#body.set_position($DestinationPoint.global_position)
	if body.is_class("CharacterBody2D"):
		var enemy = body as Enemy
		enemy.change_floor(destination_floor, $DestinationPoint.global_position, self)


func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if input_flag:
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			input_flag = true
			destination_point.position = Vector2(destination_point.position.x, floor_manager._get_floor_position(destination_floor))
			SignalBus.door_action.emit(global_position.x, floor_manager._get_floor_position(current_floor), destination_point, destination_floor)
	
	input_flag = false
