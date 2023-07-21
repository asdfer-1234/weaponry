extends Resource
class_name ItemStack

# Keep this code simple as possible. No relation with ItemStackDisplay or whatsoever

@export var item : Item:
	set(value):
		item = value
		if item == null && count != 0:
			count = 0
		emit_changed()

@export var count : int:
	set(value):
		count = value
		if count <= 0 or item == null:
			count = 0
			item = null
		emit_changed()

func full():
	if item is StackableItem:
		return count >= item.stack_size
	return false

func empty():
	return item == null or count <= 0


func get_stack_size():
	return 1

func _init(nitem : Item = null, ncount : int = 1):
	if nitem == null or ncount == 0:
		return
	item = nitem
	ncount = count
