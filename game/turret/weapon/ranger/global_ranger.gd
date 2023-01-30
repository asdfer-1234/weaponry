tool

extends Ranger
class_name GlobalRanger

func get_targets(node):
	return node.get_tree().get_nodes_in_group("stone")
