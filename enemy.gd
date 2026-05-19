extends CharacterBody2D


@export var wander_direction : Node2D
var current_target_position : Vector2
var target_floor = 2
var direction 
var doeswander = false
var path_manager : PathManager
var current_path
var current_floor = 0
var doorfound = false
var doors : Array[Door] = []
var door
var floortogo
var door_target_position = -1

func _ready():
	path_manager = get_tree().get_first_node_in_group("path_manager")



func _physics_process(delta):
	if door_target_position != -1:
		direction = sign(door_target_position.x - global_position.x)
		velocity.x = direction * 100
		velocity.y = 0;
		move_and_slide()
		update_path()


func update_path():
	if current_floor == target_floor:
		return
		
	
	if doorfound == false:
		
		if target_floor > current_floor:
			floortogo += floortogo
		else:
			floortogo -= floortogo
		
		doorfound = true;
		find_door()
	
	for Door in doors:
		if Door.global_position < global_position && Door.global_position > global_position:
			door_target_position = Door.global_position
			return
		else:
			door_target_position = Door.global_position





func find_door():
	doors = path_manager.give_doors(current_floor, floortogo)

"""
@export var wander_direction : Node2D
var current_target_position : Vector2
var target_floor = 2
var direction 
var doeswander = false
var path_manager : PathManager
var current_path
var current_floor = 0

func _ready():
	path_manager = get_tree().get_first_node_in_group("path_manager")
	go_to(Vector2(1000,600))

func _physics_process(delta):

	

	#if doeswander:
	#	velocity = wander_direction.direction * 200
	#	move_and_slide()
	update_path()
	
	
	#direction = sign(current_target_position.x - global_position.x)
	var dx = current_target_position.x - global_position.x
	velocity.x = sign(dx) * 100
	
	
	
	#velocity.x = direction * 50
	velocity.y = 0;
	move_and_slide()

	
	
func update_path():
	if current_floor == target_floor:
		current_path.clear()
		return
		
	current_path = path_manager.find_path(current_floor, target_floor)
	
	if current_path.size() > 0:
		var next_portal = current_path[0]
		current_target_position = next_portal.global_position
		
		
func go_to(y):
	current_target_position = y



"""
