extends MultipleClickButton

@export var item_stack : ItemStack :
	get:
		return $ItemStackDisplay.item_stack
	set(value):
		$ItemStackDisplay.item_stack = value

var cursor:
	get:
		return get_tree().get_first_node_in_group("item_cursor")

func _primary_pressed():
	if item_stack.item == cursor.item_stack.item and item_stack.item is StackableItem:
		merge(cursor)
	else:
		swap_other(cursor)

func _secondary_pressed():
	if cursor.item_stack.empty:
		get_one(cursor)
	elif cursor.item_stack.item == item_stack.item or item_stack.empty:
		drop_one(cursor)
	else:
		swap_other(cursor)

func swap_other(other):
	var swapper = other.item_stack
	other.item_stack = item_stack
	item_stack = swapper
	update_tooltip()

func merge(other):
	var total = other.item_stack.count + item_stack.count
	var stack_size = item_stack.item.stack_size
	if total <= stack_size:
		other.item_stack.item = null
		other.item_stack.count = 0
		item_stack.count = total
	else:
		if item_stack.count == stack_size:
			item_stack.count = total - stack_size
			other.item_stack.count = stack_size
		else:
			item_stack.count = stack_size
			other.item_stack.count = total - stack_size
	update_both()
	

func drop_one(other):
	item_stack.item = other.item_stack.item
	item_stack.count += 1
	other.item_stack.count -= 1
	update_both()

func get_one(other):
	other.item_stack.item = item_stack.item
	other.item_stack.count += 1
	item_stack.count -= 1
	update_both()


func update_display():
	$ItemStackDisplay.update_display()

func update_both():
	update_display()
	cursor.update_display()

func _on_mouse_entered():
	update_tooltip()

func update_tooltip():
	if item_stack.item != null:
		get_tree().get_first_node_in_group("tooltip").text = item_stack.item.tooltip()
