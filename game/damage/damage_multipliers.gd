extends Resource

class_name DamageMultipliers

@export var damage_multipliers : Array[DamageMultiplier]

func multiply(damage : Damage):
	for i in damage_multipliers:
		damage = i.multiply(damage)
	return damage

func _init(array : Array[DamageMultiplier] = []):
	damage_multipliers = array
