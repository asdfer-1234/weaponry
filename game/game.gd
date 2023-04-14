extends Node

func _ready():
	add_child(get_tree().get_first_node_in_group("scene_manager").map_unique.instantiate())
