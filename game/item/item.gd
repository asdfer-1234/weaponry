extends Resource
class_name Item

@export var name : String = "Item"
@export var sprite : Texture = preload("res://game/item/placeholder_item.png")
@export var stack_size : int

func tooltip():
	return tr(name) + "\n" + RichTextBuilder.color_text(tr(name + "_DESCRIPTION"), Palette.secondary) + "\n"

func get_stack_size():
	return 1

func on_buy():
	pass
