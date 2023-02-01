extends Control

@export var item_stack : ItemStack:
	set(value):
		item_stack = value
		update_display()
	get:
		return item_stack

func _ready():
	item_stack = item_stack

func update_display():
	if item_stack == null:
		$ItemTexture.texture = null
		$Count.text = ""
	else:
		$ItemTexture.texture = item_stack.item.sprite
		if item_stack.item is StackableItem:
			$Count.text = _count_text(item_stack.count)
		else:
			$Count.text = ""

func _count_text(count : int) -> String:
	return "\n" + RichTextBuilder.right(count);

