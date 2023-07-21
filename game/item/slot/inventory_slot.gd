extends MultipleClickButton
class_name InventorySlot

signal changed

@export var item_stack : ItemStack :
	get:
		return $ItemStackDisplay.item_stack
	set(value):
		$ItemStackDisplay.item_stack = value

var cursor : ItemStackDisplay:
	get:
		return get_tree().get_first_node_in_group("item_cursor")

func _ready():
	super._ready()
	$ItemStackDisplay.changed.connect(emit_changed)

func _exit_tree():
	$ItemStackDisplay.changed.disconnect(emit_changed)

# input
func _primary_pressed():
	primary(cursor)

func _secondary_pressed():
	secondary(cursor)

func primary(_other):
	pass

func secondary(_other):
	pass

func _on_mouse_entered():
	$"../%Tooltip".enter_tooltip(self)

func _on_mouse_exited():
	$"../%Tooltip".exit_tooltip(self)
# input end

func tooltip():
	var build = ""
	return build

func update_display():
	$ItemStackDisplay.update_display()

func emit_changed():
	changed.emit()
