extends Resource
class_name Damage

enum Type {
	PHYSICAL,
	EXPLOSION,
	LIQUID,
	ACID,
	FIRE,
}

@export var type = Type.PHYSICAL
@export var damage = 10

