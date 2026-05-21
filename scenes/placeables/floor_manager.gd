extends Node
class_name FloorManager

@export var floors: Array[FloorLevel]

func _get_floor_position(floor_level: int) -> float:
	for x in floors:
		if x.floor == floor_level:
			return x.global_position.y
	return 0
				
		
