extends Control
class_name ItemStackDisplay
@export var placeholder : Texture

@export var item_stack : ItemStack:
	set(value):
		if value == null:
			var new_item_stack = ItemStack.new()
			new_item_stack.item = null
			item_stack = new_item_stack
		else:
			item_stack = value
		for i in item_stack.changed.get_connections():
			item_stack.changed.disconnect(i["callable"])
		item_stack.changed.connect(self.update_display)
		
		update_display()


func _ready():
	if item_stack == null:
		item_stack = null
	item_stack = item_stack.duplicate()

func update_display():
	if item_stack.item == null:
		$ItemTexture.texture = placeholder
		$Count.text = ""
	else:
		$ItemTexture.texture = item_stack.item.sprite
		if item_stack.item is StackableItem:
			$Count.text = _count_text(item_stack.count)
		else:
			$Count.text = ""

func _count_text(count : int) -> String:
	return "\n" + RichTextBuilder.right(count);

