extends Resource
class_name ItemStack

@export var item : Item:
	set(value):
		item = value
		emit_changed()

@export var count : int:
	set(value):
		count = value
		if count <= 0:
			count = 0
			item = null
		emit_changed()


var full:
	get:
		if item is StackableItem:
			return count >= item.stack_size
		return false

var empty:
	get:
		return item == null or count <= 0

signal item_changed

func emit_changed():
	super.emit_changed()
	item_changed.emit()

func get_stack_size():
	return 1
