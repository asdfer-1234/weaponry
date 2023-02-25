extends Stone
class_name Granite

const diorite_damage_multiplier = 0.7
func damage(amount : Damage):
	amount = amount.duplicate()
	var diorite_nearby = false
	for i in get_nearby_stones_by_distance(30):
		if i is Diorite:
			amount.damage *= diorite_damage_multiplier
			break
	super.damage(amount)
