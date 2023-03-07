extends Ranger
class_name GlobalRanger

func extent():
	return 130

func get_targets(node, group = "stone"):
	return node.get_tree().get_nodes_in_group("stone")

func tooltip():
	return tr("UNLIMITED") + "\n"
