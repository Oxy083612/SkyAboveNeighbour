# Enemy.gd

class_name Enemy
extends CharacterBody2D

@export var speed := 300.0

var current_target_position : Vector2
var target_floor := 0
var current_floor := 0
@export var current_room : Room

var path_manager : PathManager

var current_path
var floortogo : int

var doorfound := false
var doors : Array[Door] = []
var door : Door
var door_target_position = -1

var floors : Array[Floor]

@onready var state_machine = $StateMachine
@onready var animated_sprite = $AnimatedSprite2D

func _ready():

	path_manager = get_tree().get_first_node_in_group("path_manager")
	
	for node in get_tree().get_nodes_in_group("floor"):
			var floor = node as Floor
			if floor:
				print(floor)
				floors.append(floor)

func move_to_target():

	update_path()

	var direction

	if door_target_position != -1:
		direction = sign(door_target_position - global_position.x)
	else:
		direction = sign(current_target_position.x - global_position.x)

	velocity.x = direction * speed
	velocity.y = 0

	move_and_slide()


func stop():

	velocity = Vector2.ZERO
	move_and_slide()


func reached_target() -> bool:

	return abs(global_position.x - current_target_position.x) < 10


func go_to(target_position : Vector2, floor : int):
	print(current_floor, target_floor)
	current_target_position = target_position
	target_floor = floor


func update_path():

	if current_floor == target_floor:
		return

	if !doorfound:

		if target_floor > current_floor:
			floortogo = current_floor + 1

		elif target_floor < current_floor:
			floortogo = current_floor - 1
		
		print(current_floor, floortogo)
		find_door()

		doorfound = true

		for x : Door in doors:

			door_target_position = x.global_position.x
			door = x
			return

	else:

		if floortogo == current_floor:

			doorfound = false
			door_target_position = -1


func find_door():
	doors = path_manager.give_doors(current_floor, floortogo)


func change_floor(i, j, k : Door):

	if k == door:
		
		position.y = floors[i].position.y
		current_floor = i
		current_room = k.destination_door.get_parent()
		door_target_position = -1
		doorfound = false


func on_interest_point(point):

	if state_machine.current_state is EnemyWalk:

		state_machine.current_state.on_interest_point(point)
		
func _play_animation(animation_name) -> void:
	print(animated_sprite)
	match animation_name:
		"idle":
			animated_sprite.flip_h = false
			animated_sprite.play("idle")
			pass
		"move":
			if velocity.x > 0:
				animated_sprite.flip_h = false
				animated_sprite.play("move")
			else:
				animated_sprite.flip_h = true
				animated_sprite.play("move")
			pass
