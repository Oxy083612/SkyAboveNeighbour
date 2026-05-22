
extends StateEnemy
class_name EnemyDoorExit

var enemy : Enemy

@export var door_exit_time := 3.0

var timer := 0.0
var timer2 := 3.0


func _ready():
	
	enemy = get_parent().get_parent() as Enemy
	timer = door_exit_time
	
	
func Enter():

	print("ENTER DOOREXIT")
	#enemy.door.destination_door._play_animation("door_exit")
	
	
func Update(delta):

	timer -= delta

	if timer <= 0:
		if enemy.side_door:
			enemy.side_door._play_animation("idle")
			enemy.side_door.destination_door._play_animation("door_exit")
			timer2 -= delta
		else:
			enemy.door._play_animation("idle")
			enemy.door.destination_door._play_animation("door_exit")
			timer2 -= delta
		if timer2 <= 0:
			if enemy.side_door:
				enemy.side_door.destination_door._play_animation("idle")
			else:
				enemy.door.destination_door._play_animation("idle")
			#enemy.animated_sprite.flip
			Transitioned.emit(self, "EnemyWalk")
			enemy.show()
			timer = 3.0
			timer2 = 3.0
			
			
			
	
	
#DAJ TO NA KONIEC ANIMACJI, DZIĘKI!!!
#Transitioned.emit(self, "EnemyWalk")
	
func Exit():

	print("EXIT DOOREXIT")
	enemy.side_door = null
