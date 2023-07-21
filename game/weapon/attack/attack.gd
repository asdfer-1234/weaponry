extends Resource
class_name Attack

func attack(_from, _target):
	pass

func tooltip():
	return ""

# Modifier stuff
func apply(_modifier):
	pass

func applied(modifier):
	var build = duplicate(true)
	build.apply(modifier)
	return build

# AttackArray stuff
func added(attack : Attack):
	var build : AttackArray = AttackArray.new()
	build.add(attack)
	return build
