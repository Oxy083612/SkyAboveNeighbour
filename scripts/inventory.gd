extends Control
class_name Inventory
var pickedUpItems = []
func addItem(name):
	pickedUpItems.append(name)
	print(name)
func checkItem(name):
	return pickedUpItems.has(name)
func getIndex(name):
	for index in range(pickedUpItems.size()):
		if pickedUpItems[index] == name:
			return index
	return -1
func removeItem(name):
	pickedUpItems.remove_at(getIndex(name))

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass
