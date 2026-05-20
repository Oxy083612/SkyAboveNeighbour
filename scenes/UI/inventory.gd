extends Control
class_name Inventory
var pickedUpItems = []
@onready var inventory_ui: InventoryUi = $Hud/HBoxContainer2
func addItem(item):
	pickedUpItems.append(item)
	inventory_ui.addIcon(item)
func checkItem(name):
	for index in range(pickedUpItems.size()):
		if pickedUpItems[index].itemName == name:
			return true
	return false
func getIndex(item):
	for index in range(pickedUpItems.size()):
		if pickedUpItems[index].itemName == name:
			return index
	return -1
	
func removeItem(item):
	pickedUpItems.remove_at(getIndex(item))
	inventory_ui.removeIcon(item)
func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	pass
