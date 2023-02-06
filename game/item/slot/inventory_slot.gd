extends MultipleClickButton
class_name InventorySlot

@export var item_stack : ItemStack :
	get:
		return $ItemStackDisplay.item_stack
	set(value):
		$ItemStackDisplay.item_stack = value
		for i in item_stack.changed.get_connections():
			item_stack.changed.disconnect(i["callable"])
		item_stack.changed.connect(emit_changed)
		emit_changed()

var cursor:
	get:
		return get_tree().get_first_node_in_group("item_cursor")


signal changed


func _ready():
	super._ready()
	item_stack = item_stack

func _primary_pressed():
	pass

func _secondary_pressed():
	pass

func _on_mouse_entered():
	update_tooltip()

func update_tooltip():
	pass

func emit_changed():
	changed.emit()
