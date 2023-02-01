extends Resource
class_name Damage

enum Type {
	PHYSICAL,
	EXPLOSION,
	LIQUID,
	ACID,
	FIRE,
}

var type_icon = [
	"res://game/damage/icon/physical.png",
	"res://game/damage/icon/explosion.png",
	"res://game/damage/icon/liquid.png",
	"res://game/damage/icon/acid.png",
	"res://game/damage/icon/fire.png",
]

@export var type = Type.PHYSICAL
@export var damage = 10


func tooltip():
	return RichTextBuilder.property_text("Damage", RichTextBuilder.color_text(RichTextBuilder.image(type_icon[int(type)]) + " " + str(damage), Palette.green))
