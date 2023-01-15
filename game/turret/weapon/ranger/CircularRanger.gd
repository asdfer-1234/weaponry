extends Ranger
class_name CircularRanger

export(float) var min_range : float = 0
export(float) var max_range : float = 50

func get_targets(node : Node2D):
	var targets : Array = []
	for i in node.get_tree().get_nodes_in_group("stone"):
		var distance : float= node.position.distance_to(i.position)
		if distance >= min_range and distance <= max_range:
			targets.append(i)
	return targets

func _init(min_range, max_range):
	self.min_range = min_range
	self.max_range = max_range
