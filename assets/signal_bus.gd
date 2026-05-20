extends Node

signal movement_action(x, y)
signal hiding_action(x, y, spot_y)
signal pickup_action(x, y, item_container)
signal prankdo_action(name)

enum InteractionTypes {
	PICKUP,
	PRANK,
	INFO,
}



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
