extends InventorySlot
class_name ItemSlot



func primary(other):
	if item_stack.item == cursor.item_stack.item and item_stack.item is StackableItem:
		merge(other)
	else:
		swap_other(other)

func secondary(other):
	if other.item_stack.empty:
		get_one(other)
	elif other.item_stack.item == item_stack.item or item_stack.empty:
		drop_one(other)
	else:
		swap_other(other)

func swap_other(other):
	var swapper = other.item_stack
	other.item_stack = item_stack
	item_stack = swapper
	changed.emit()

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

func drop_one(other):
	item_stack.item = other.item_stack.item
	item_stack.count += 1
	other.item_stack.count -= 1

func get_one(other):
	other.item_stack.item = item_stack.item
	other.item_stack.count += 1
	item_stack.count -= 1

func tooltip():
	var build = super.tooltip()
	
	if item_stack.item == null:
		return build
	else:
		return build + item_stack.item.tooltip()
