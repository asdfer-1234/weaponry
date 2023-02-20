extends MultipleClickButton
class_name InventorySlot

@export var item_stack : ItemStack :
	get:
		return $ItemStackDisplay.item_stack
	set(value):
		$ItemStackDisplay.changed.disconnect(_emit_changed)
		$ItemStackDisplay.item_stack = value
		$ItemStackDisplay.changed.connect(_emit_changed)
		changed.emit()

@export var accept_type : Item.Type = Item.Type.NONE:
	set(value):
		accept_type = value
		$ItemStackDisplay.placeholder = load(Item.placeholders[value])
		changed.emit()

var cursor : ItemStackDisplay:
	get:
		return get_tree().get_first_node_in_group("item_cursor")

signal changed

func _ready():
	super._ready()
	$ItemStackDisplay.changed.connect(_emit_changed)

func _primary_pressed():
	if item_acceptable(cursor):
		primary(cursor)

func _secondary_pressed():
	if item_acceptable(cursor):
		secondary(cursor)

func primary(_other):
	pass

func secondary(_other):
	pass

func item_acceptable(other):
	return match_type(other)

func match_type(compare):
	return (accept_type == Item.Type.NONE or
			compare.item_stack.item == null or
			compare.item_stack.item.type == accept_type)


func _on_mouse_entered():
	$"../%Tooltip".enter_tooltip(self)

func _on_mouse_exited():
	$"../%Tooltip".exit_tooltip(self)


func tooltip():
	var build = ""
	if cursor.item_stack.item != null and not match_type(cursor):
		build += RichTextBuilder.color_text(
				tr("ITEM_RESTRICTION_DESCRIPTION") % \
				tr(Item.type_name[accept_type]), Palette.red) + "\n"
	return build

func update_display():
	$ItemStackDisplay.update_display()

func _emit_changed():
	changed.emit()
