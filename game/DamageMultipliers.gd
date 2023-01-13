extends Resource

class_name DamageMultipliers

export(Array, Resource) var damage_multipliers

func multiply(damage : Damage):
	for i in damage_multipliers:
		damage = i.multiply(damage)
	return damage

func _init(array : Array):
	damage_multipliers = array
