extends Area2D

@export var floor_id : int

func _on_body_entered(body: Node2D) -> void:
	if body.has_variable("current_floor"):
		body.current_floor = floor_id
