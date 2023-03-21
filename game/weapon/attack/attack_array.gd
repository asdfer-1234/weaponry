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

func remove_non_infinite_use():
	var index = 0
	while index < len(attacks):
		while index < len(attacks) and not attacks[index].infinite_use:
			attacks.remove_at(index)
		index += 1;
