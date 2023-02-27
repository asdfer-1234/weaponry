extends Attack
class_name AttackArray


@export var attacks : Array[Attack] = []

func attack(from, target, damage_multiplier, modifier_attack_used = false):
	for i in attacks:
		i.attack(from, target, damage_multiplier, modifier_attack_used)

func add(other):
	if other == null:
		return self
	attacks.append(other)

func to_attack_array():
	return self
