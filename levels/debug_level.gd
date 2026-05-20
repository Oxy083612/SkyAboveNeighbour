extends Node2D


@onready var player = $PlayerCharacter

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in get_tree().get_first_node_in_group("Pranks")
		var prank = x as Prank
		player.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
