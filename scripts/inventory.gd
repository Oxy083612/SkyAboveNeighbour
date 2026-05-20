extends Control
class_name Inventory
var pickedUpItems = []

func addItem(name):
	pickedUpItems.append(name)
	print(name)
	
func checkItem(name):
	print(name)
	for index in range(pickedUpItems.size()):
		print(pickedUpItems[index].itemName+"a")
		if pickedUpItems[index].itemName == name:
			return true
	return false
func getIndex(name):
	for index in range(pickedUpItems.size()):
		if pickedUpItems[index].itemName == name:
			return index
	return -1
	
func removeItem(name):
	pickedUpItems.remove_at(getIndex(name))

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
