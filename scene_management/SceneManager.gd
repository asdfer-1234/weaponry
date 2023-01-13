extends Node

export(PackedScene) var start_scene : PackedScene

func _ready():
	add_child(start_scene.instance())


func change_scene(scene : PackedScene):
	get_child(0).queue_free()
	add_child(scene.instance())
