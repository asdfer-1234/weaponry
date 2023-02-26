extends Button

@export var scene : PackedScene

func change_scene():
	get_tree().get_first_node_in_group("scene_manager").change_scene(scene)


