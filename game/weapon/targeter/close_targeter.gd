extends Targeter
class_name CloseTargeter

func get_target(node, targets):
	var target = null
	
	var squared_distance
	
	for i in targets:
		var current_squared_distance = i.global_position.distance_squared_to(node.global_position)
		if target == null or current_squared_distance < squared_distance:
			target = i
			squared_distance = current_squared_distance
	return target

func tooltip():
	return tr("CLOSE_TARGETER_TOOLTIP") + "\n"
