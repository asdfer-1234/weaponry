extends Resource

class_name Item

@export var name : String = "Item"
@export_multiline var description : String
@export var sprite : Texture = preload("res://game/item/placeholder_item.png")

enum Type {
	NONE = 0,
	WEAPON = 1,
	AMMUNITION = 2,
	ACCESSORY = 3,
}

const placeholders = [
	null,
	"res://game/item/slot/placeholder/weapon_placeholder.png",
	"res://game/item/slot/placeholder/ammunition_placeholder.png",
	"res://game/item/slot/placeholder/accessory_placeholder.png",
]
@export var type : Type = Type.NONE



func tooltip():
	return name + "\n" + RichTextBuilder.color_text(description, Palette.secondary)
