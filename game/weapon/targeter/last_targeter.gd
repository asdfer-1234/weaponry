extends Targeter
class_name LastTargeter

func get_target(node, targets):
	var target = null
	
	for i in targets:
		if target == null or target.progress > i.progress:
			target = i
	return target

func tooltip():
	return tr("LAST_TARGETER_TOOLTIP") + "\n"
