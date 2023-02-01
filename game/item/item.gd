extends Resource

class_name Item

@export var name : String = "Item"
@export_multiline var description : String
@export var sprite : Texture = preload("res://game/item/placeholder_item.png")

func tooltip():
	return name + "\n" + RichTextBuilder.color_text(description, Palette.secondary)
