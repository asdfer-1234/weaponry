extends Resource
class_name DamageMultiplier

@export var type = Damage.Type.PHYSICAL
@export var multiplier : float = 1

func multiply(damage : Damage):
	damage = damage.duplicate()
	if damage.type == type:
		@warning_ignore("narrowing_conversion")
		damage.damage *= multiplier
	return damage
	
