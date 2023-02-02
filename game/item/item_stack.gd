extends Resource
class_name ItemStack

	

@export var item : Item:
	get:
		return _item
	set(value):
		_item = value
		if _item == null:
			_count = 0
		emit_changed()
var _item : Item
@export var count : int:
	get:
		return _count
	set(value):
		_count = value
		if _count <= 0:
			_count = 0
			_item = null
		emit_changed()
var _count : int

var full:
	get:
		if item is StackableItem:
			return count >= item.stack_size
		return false

var empty:
	get:
		return item == null or count <= 0
