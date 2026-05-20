extends Node

class_name PathManager

var doors : Array[Door] = []
var gooddoors : Array[Door] = []


func _ready():
	
	for node in get_tree().get_nodes_in_group("doors"):
		var door = node as Door
		if door:
			doors.append(door)



func give_doors(i, j):
	gooddoors.clear()
	for x : Door in doors:
		if x.current_floor == i && x.destination_floor == j:
			gooddoors.append(x)
	return gooddoors
	

	
	"""
	for Door in doors:
		if Door.current_floor == i && Door.destination_floor == j:
			gooddoors.append(Door)
	return gooddoors
"""


"""
var doors : Array[Door] = []

var floor_doors := {}

func _ready():
	
	var doors = get_tree().get_nodes_in_group("doors")
	build_graph()
	
func build_graph():
	
	floor_doors.clear()
	for door in doors:
		
		if not floor_doors.has(door.current_floor):
			floor_doors[door.current_floor] = []
			
		floor_doors[door.current_floor].append(door)
		
func find_path(start_floor : int, target_floor : int):
	var result : Array = []
	if start_floor == target_floor:
		return []
	
	var queue = []
	var visited = {}
	var parent = {}
	
	queue.append(start_floor)
	visited[start_floor] = true
	
	while queue.size() > 0:
		var current = queue.pop_front()
		
		if current == target_floor:
			break
			
		if not floor_doors.has(current):
			continue
		
		for door in floor_doors[current]:
			
			var next_floor = door.destination_floor 
			
			if not visited.has(next_floor):
			
				visited[next_floor] = true
				parent[next_floor] = {
					"floor": current,
					"door": door
				}
			
			queue.append(next_floor)
		
		
		
		var current_floor = target_floor

		while current_floor != start_floor:
			if not parent.has(current_floor):
				return []
		
			var data = parent[current_floor]
			
			result.push_front(data.door)
			
			current_floor = data.floor
			
		return result
	return result
"""
