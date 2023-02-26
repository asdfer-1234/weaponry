extends Button

@export var scene : String

func change_scene():
	get_tree().get_first_node_in_group("scene_manager").change_scene_by_string(scene)


