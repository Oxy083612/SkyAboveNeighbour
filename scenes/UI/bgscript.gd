extends AudioStreamPlayer2D
const bg = preload("res://assets/sounds/bgmusic.ogg")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_playing():
		set_stream(bg)
		play()
		print(bg)
