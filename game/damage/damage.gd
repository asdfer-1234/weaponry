extends Resource
class_name Damage

enum Type {
	PHYSICAL,
	EXPLOSION,
	LIQUID,
	ACID,
	FIRE,
}

const type_icon = [
	"res://game/damage/icon/physical.png",
	"res://game/damage/icon/explosion.png",
	"res://game/damage/icon/liquid.png",
	"res://game/damage/icon/acid.png",
	"res://game/damage/icon/fire.png",
]

const type_color = [
	Color(1, 0.95, 0.76),
	Color(1, 0.85, 0.54),
	Color(0.32, 0.46, 1),
	Color(0.25, 1, 0.36),
	Color(1, 0.31, 0.31),
]

@export var type : Type = Type.PHYSICAL
@export var damage : int = 10

func tooltip():
	return RichTextBuilder.property_text(tr("DAMAGE"), minimal_tooltip())

func minimal_tooltip():
	return RichTextBuilder.color_text(RichTextBuilder.image(type_icon[int(type)]) + str(damage), type_color[int(type)])

func apply(modifier : Modifier):
	damage = modifier.damage.applied(damage)

func applied(modifier : Modifier):
	return duplicate(true).apply(modifier)
