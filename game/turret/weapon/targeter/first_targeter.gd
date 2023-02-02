extends Targeter
class_name FirstTargeter

func get_target(_node, targets):
	var target = null
	
	for i in targets:
		if target == null or target.progress < i.progress:
			target = i
	return target

func tooltip():
	return "TARGETS FIRST\n"
