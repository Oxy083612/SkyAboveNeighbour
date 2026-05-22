# EnemyWalk.gd

class_name EnemyWalk
extends StateEnemy

var enemy : Enemy

@export var interest_points : Array[InterestPoint]

var current_interest := 0

func _ready():

	enemy = get_parent().get_parent() as Enemy


func Enter():

	print("ENTER WALK")

	enemy._play_animation("move")

	select_interest_point()


func Physics_Update(delta):

	enemy.move_to_target()
	#print(enemy.current_room)
	#if enemy.reached_target():

	#	Transitioned.emit(self, "EnemyIdle")


func select_interest_point():

	if interest_points.is_empty():
		return

	if current_interest >= interest_points.size():
		current_interest = 0

	var point = interest_points[current_interest]

	enemy.go_to(point.global_position, point.current_floor)

	current_interest += 1


func on_interest_point(point):

	if point == interest_points[current_interest - 1]:

		enemy.stop()
		
		print("tu punkt")
		Transitioned.emit(self, "EnemyIdle")


func Exit():

	enemy.stop()

	print("EXIT WALK")
