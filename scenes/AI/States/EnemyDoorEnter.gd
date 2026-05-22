extends StateEnemy
class_name EnemyDoorEnter

var enemy : Enemy

func _ready():
	
	enemy = get_parent().get_parent() as Enemy

func Enter():

	if enemy.side_door:
		print("ENTER DOORENTER")
		enemy.side_door._play_animation("door_enter")
		enemy.hide()
		
	else:
		print("ENTER DOORENTER")
		enemy.door._play_animation("door_enter")
		enemy.hide()
	
	
	

	
func Exit():

	print("EXIT DOORENTER")
	
