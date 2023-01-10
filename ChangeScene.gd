extends Button

export(PackedScene) var scene : PackedScene;

func change_scene():
	get_tree().get_nodes_in_group("scene_manager")[0].change_scene(scene)
