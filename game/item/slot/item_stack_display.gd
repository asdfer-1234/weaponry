extends Control
class_name ItemStackDisplay

@export var placeholder : Texture

signal changed

# Guaranteed to have a value - Except before _ready
@export var item_stack : ItemStack:
	set(value):
		if item_stack != null:
			item_stack.changed.disconnect(update_display)
			item_stack.changed.disconnect(emit_changed)
		if value != null:
			item_stack = value
		else:
			item_stack = ItemStack.new()
		item_stack.changed.connect(update_display)
		item_stack.changed.connect(emit_changed)
		update_display()
		changed.emit()

func _ready():
	item_stack = item_stack # guarantee item_stack has a value
	update_display()

func update_display():
	if item_stack.item == null:
		_empty_display()
		return
	
	$ItemTexture.texture = item_stack.item.sprite
	if item_stack.item is StackableItem:
		$Count.text = _count_text(item_stack.count)
	else:
		$Count.text = ""

func _empty_display():
	$ItemTexture.texture = placeholder
	$Count.text = ""

func _count_text(count : int) -> String:
	return "\n" + RichTextBuilder.right(str(count))

func emit_changed():
	changed.emit()
