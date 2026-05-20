extends Node2D

class_name Interest_point

@export var current_floor : int 


func _on_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"):
		var enemy = body as Enemy
		enemy.on_interest_point(self)
