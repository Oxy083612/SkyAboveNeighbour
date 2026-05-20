extends Control
class_name InventoryUi

func getPath(name):
	return "res://assets/UI/icons/" + name + "_icon.png"

func addIcon(item):
	var item_name = item.itemName
	var image = Image.load_from_file(getPath(item_name))
	var texture = ImageTexture.create_from_image(image)
	var new_icon = TextureRect.new()
	new_icon.texture = texture
	new_icon.set_meta("item_name", item_name) 
	add_child(new_icon)
func removeIcon(item):
		var name = item.itemName
		for child in get_children():
			if child.has_meta("item_name") and child.get_meta("item_name") == name:
				child.queue_free() 
				break
