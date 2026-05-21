class_name Room

extends Node2D

@export var floor := 0
@export var floor_manager: FloorManager = null
var input_flag := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if input_flag:
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			input_flag = true
			SignalBus.movement_action.emit(get_global_mouse_position().x, floor_manager._get_floor_position(floor))
	
	input_flag = false
	


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.owner is PlayerCharacter:
		var player = area.owner as PlayerCharacter
		player.current_room = self
		
		
		
		
		
		
		
		
