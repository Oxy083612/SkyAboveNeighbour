extends Control
class_name InventoryUi

func getPath(icon_name):
	return "res://assets/UI/icons/" + icon_name + "_icon.png"

func addIcon(item):
	var item_name = item.itemName
	var texture = load(getPath(item_name)) as Texture2D

	var new_icon = TextureRect.new()
	new_icon.texture = texture
	new_icon.set_meta("item_name", item_name)

	add_child(new_icon)
	
func removeIcon(item):
		var icon_name = item.itemName
		for child in get_children():
			if child.has_meta("item_name") and child.get_meta("item_name") == icon_name:
				child.queue_free() 
				break
