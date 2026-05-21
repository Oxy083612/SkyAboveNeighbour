class_name Enemy
extends CharacterBody2D


@export var wander_direction : Node2D
var current_target_position : Vector2
var target_floor
var direction 
var doeswander = true
var path_manager : PathManager
var current_path
var current_floor = 0
var doorfound = false
var doors : Array[Door] = []
var door : Door
var floortogo : int
var door_target_position = -1
var looper_interest = 0
@export var interest_points : Array[InterestPoint]



func _ready():
	path_manager = get_tree().get_first_node_in_group("path_manager")
	#get_interest_points()
	#print(get_tree().get_first_node_in_group("path_manager"))
	#go_to(Vector2(1000,600),2)



func _physics_process(_delta):
	if doeswander:
		#print("ideeeee")
		go_to_interest_point()
		
	update_path()

		#direction = wander_direction.direction
	
	if door_target_position != -1:
		direction = sign(door_target_position - global_position.x)
	else:
		direction = sign(current_target_position.x - global_position.x)
	velocity.x = direction * 300
	velocity.y = 0;
	move_and_slide()
		

func update_path():
	#current_path = path_manager.find_path(current_floor, target_floor)

	
	if current_floor == target_floor:
		return
		
	if doorfound == false:
		#print(target_floor)
		
		if target_floor != -10:
			#print(target_floor)
			#print("     ")
			#print(current_floor)
			if target_floor > current_floor:
				floortogo = current_floor + 1
				#print("uuuuuuuuu")
				
			if target_floor < current_floor:
				floortogo = current_floor - 1
				#print("dddddddddddddd")
		
		find_door()
		doorfound = true;
		
		
		for x : Door in doors:
			if x.global_position < global_position && x.global_position > global_position || x.global_position > global_position && x.global_position < global_position:
				door_target_position = x.global_position.x
				door = x;
				return
			else:
				door_target_position = x.global_position.x
				door = x;
			
	elif doorfound == true:
		if floortogo == current_floor:
			doorfound = false;
			print(doorfound)





func find_door():
	#print(current_floor)
	#print("     ")
	#print(floortogo)
	doors = path_manager.give_doors(current_floor, floortogo)
	#print(doors)


func go_to(y, floor_level):
	current_target_position = y
	target_floor = floor_level


func change_floor(i, j, k):
	if (k == door):
		current_floor = i
		position = j
		door_target_position = -1
		doorfound = false;
 

func get_interest_points():
	for node in get_tree().get_nodes_in_group("FirstEnemy"):
		var interest_point = node as InterestPoint
		#print(interest_point)
		if interest_point:
			interest_points.append(interest_point)
			


func go_to_interest_point():
	#interest_points.shuffle()
	#print(looper_interest)
	if looper_interest >= interest_points.size():
		looper_interest = 0;
		
	go_to(interest_points[looper_interest].position , interest_points[looper_interest].current_floor)
	print(interest_points[looper_interest], interest_points[looper_interest].current_floor)
	doeswander = false;
	looper_interest += 1;


func on_interest_point(k):
	if k == interest_points[looper_interest-1]:
		rotate(90)
		direction = 0
		doeswander = true;
		#doorfound = false;
		#update_path()
		#door = null

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
