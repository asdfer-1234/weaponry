extends Attack
class_name AttackArray


@export var attacks : Array[Attack] = []

func attack(from, target, damage_multiplier):
	for i in attacks:
		i.attack(from, target, damage_multiplier)

func add_attack(other):
	var added = self.duplicate()
	added.attacks.append(other)
	return added