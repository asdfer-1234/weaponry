extends Resource
class_name Attack

@export var infinite_use : bool = false

func attack(_from, _target, _modifier):
	pass

func tooltip():
	return ""

func get_modified(modifer : Modifier):
	pass
