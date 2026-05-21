extends Node

@warning_ignore("unused_signal")
signal movement_action(x, y)
@warning_ignore("unused_signal")
signal hiding_action(x, y, spot_y)
@warning_ignore("unused_signal")
signal pickup_action(x, y, item_container)
@warning_ignore("unused_signal")
signal prankdo_action(name)
@warning_ignore("unused_signal")
signal door_action(x, y, destination, destination_floor)

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
