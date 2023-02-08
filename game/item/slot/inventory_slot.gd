extends MultipleClickButton
class_name InventorySlot

@export var item_stack : ItemStack :
	get:
		return $ItemStackDisplay.item_stack
	set(value):
		$ItemStackDisplay.item_stack = value
		changed.emit()

@export var accept_type : Item.Type = Item.Type.NONE:
	set(value):
		$ItemStackDisplay.placeholder = load(Item.placeholders[value])

var cursor:
	get:
		return get_tree().get_first_node_in_group("item_cursor")

signal changed

func _ready():
	super._ready()
	#item_stack = item_stack

func _primary_pressed():
	if match_type(cursor):
		primary(cursor)

func _secondary_pressed():
	if match_type(cursor):
		secondary(cursor)

func primary(other):
	pass

func secondary(other):
	pass

func match_type(compare):
	return accept_type == Item.Type.NONE or compare.item_stack.item == null or compare.item_stack.item.type == accept_type


func _on_mouse_entered():
	update_tooltip()

func update_tooltip():
	get_tree().get_first_node_in_group("tooltip").text = tooltip()

func tooltip():
	return "INVENTORY SLOT"

func update_display():
	$ItemStackDisplay.update_display()

