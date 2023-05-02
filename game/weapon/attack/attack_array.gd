extends Attack
class_name AttackArray


@export var attacks : Array[Attack] = []

func attack(from, target, damage_multiplier, modifier_attack_used = false):
	for i in attacks:
		i.attack(from, target, damage_multiplier)

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

func get_modified(modifier : Modifier):
	var modified_array : Array[Attack] = []
	for i in range(len(attacks)):
		modified_array = attacks[i].get_modified(modifier)
	AttackArray.new(modified_array)

func _init(attacks : Array[Attack] = []):
	self.attacks = attacks
