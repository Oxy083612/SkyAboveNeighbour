class_name PlayerCharacter
extends Node2D

enum State {
	IDLE,
	WALK,
	ENTERING_DOOR,
	EXITING_DOOR,
	CREEP,
	INTERACTION,
}

@export var speed := 200.0
var target_x := 0
var target_y := 0
var CurrentState := State.IDLE


func _init() -> void:
	MovementBus.movement_action.connect(_on_move)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target_x = position.x
	target_y = position.y

func _on_move(x, y) -> void:
	target_x = x
	position.y = y
	CurrentState = State.WALK

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = sign(target_x - position.x)
	
	if abs(position.x - target_x) > 2 && CurrentState == State.WALK:
		position.x += dir * speed * delta
	else:
		CurrentState = State.IDLE
		
		
func state_handler() -> void:
	match(CurrentState):
		State.IDLE:
			pass
