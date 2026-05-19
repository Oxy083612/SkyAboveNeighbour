extends Area2D
class_name Door

@export var current_floor : int
@export var destination_floor : int

@export var destination_door : Door
@onready var destination_point = $DestinationPoint

func _get_exit_position() -> Vector2:
	return destination_point.global_position

func _on_body_entered(body: Node2D) -> void:
	body.set_position($DestinationPoint.global_position)
