extends Attack
class_name AttackArray

@export var attacks : Array[Attack] = []

func attack(from, target):
	for i in attacks:
		i.attack(from, target)

func add(other : Attack):
	attacks.append(other)

func added(other : Attack):
	var build = attacks.duplicate()
	for i in range(0, len(build)):
		build[i] = build[i].duplicate()
	if other is AttackArray:
		attacks.append_array(other.attacks)
	else:
		add(other)

func get_modified(modifier : Modifier):
	var modified_array : Array[Attack] = []
	for i in range(len(attacks)):
		modified_array = attacks[i].get_modified(modifier)
	AttackArray.new(modified_array)

func _init(attacks : Array[Attack] = []):
	self.attacks = attacks

func applied(modifier : Modifier) -> Attack:
	var build = duplicate()
	for i in range(len(attacks)):
		build.attacks[i] = attacks[i].applied(modifier)
	return build
