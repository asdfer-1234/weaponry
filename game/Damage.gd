extends Resource
class_name Damage

enum Type {
	PHYSICAL,
	EXPLOSION,
	LIQUID,
	ACID,
	FIRE,
}

export(Type) var type = Type.PHYSICAL
export(int) var damage : int = 10

func _init(var damage, var type):
	self.damage = damage
	self.type = type
