extends Button

@export var item_stack : ItemStack :
	get:
		return $ItemStackDisplay.item_stack
	set(value):
		$ItemStackDisplay.item_stack = value


func _on_pressed():
	var cursor = get_tree().get_first_node_in_group("item_cursor")
	var swapper = cursor.item_stack
	cursor.item_stack = item_stack
	item_stack = swapper
	update_tooltip()

func _on_mouse_entered():
	update_tooltip()

func update_tooltip():
	if item_stack != null:
		get_tree().get_first_node_in_group("tooltip").text = item_stack.item.tooltip()

