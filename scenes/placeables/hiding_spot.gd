extends Node2D


var input_flag = false
@export var floor_manager: FloorManager
@export var floor: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if input_flag:
		return

	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			input_flag = true
			SignalBus.hiding_action.emit(position.x, floor_manager._get_floor_position(floor),  position.y)
	
	input_flag = false
