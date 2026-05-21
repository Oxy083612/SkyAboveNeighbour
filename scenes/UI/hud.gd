extends CanvasLayer

@onready var medal_container = $MedalContainer

@onready var medal_inst := preload("res://scenes/UI/medal_box.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var pranks_bad = 4
	var pranks_good = 2
	
	if pranks_bad > pranks_good:
		_initiate_medal_container(pranks_good)
	else:
		_initiate_medal_container(pranks_bad)	

func _initiate_medal_container(number):
	for x in range(number):
		var child = medal_inst.instantiate()
		var medal = child as Medal
		medal_container.add_child(medal)
		child._change_medal(0)
		
	
	
