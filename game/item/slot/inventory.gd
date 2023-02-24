extends Node

func give(item_stack : ItemStack):
	item_stack = item_stack.duplicate()
	for i in get_children():
		if i.item_stack.empty or i.item_stack.item == item_stack.item:
			i.item_stack.item = item_stack.item
			item_stack.count += i.item_stack.count
			if item_stack.count <= item_stack.get_stack_size():
				i.item_stack = item_stack
				return
			else:
				i.item_stack.count = item_stack.item.get_stack_size()
				item_stack.count -= item_stack.item.get_stack_size()
