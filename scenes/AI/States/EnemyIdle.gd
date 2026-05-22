# EnemyIdle.gd

class_name EnemyIdle
extends StateEnemy

var enemy : Enemy

@export var idle_time := 2.0

var timer := 0.0

func _ready():

	enemy = get_parent().get_parent() as Enemy


func Enter():

	print("ENTER IDLE")
	
	enemy._play_animation("idle")

	timer = idle_time

	enemy.stop()


func Update(delta):

	timer -= delta

	if timer <= 0:

		Transitioned.emit(self, "EnemyWalk")


func Exit():

	print("EXIT IDLE")
