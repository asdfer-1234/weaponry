extends Resource
class_name DamageMultiplier

export(Damage.Type) var type
export(float) var multiplier

func multiply(damage : Damage):
	damage = damage.duplicate()
	if damage.type == type:
		damage.damage *= multiplier
	return damage
	
