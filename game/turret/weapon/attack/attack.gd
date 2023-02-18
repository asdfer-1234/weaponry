extends Resource
class_name Attack

func attack(_from, _target, _damage_multiplier):
	pass

func tooltip():
	return ""


func add_attack(other):
	var added = AttackArray.new()
	added.attacks = [self, other]
	return added
