extends Node

@export var start_scene : PackedScene

var scene_node : Node:
	set(value):
		if scene_node != null:
			scene_node.queue_free()
		scene_node = value
		add_child(scene_node)
		move_child(scene_node, 1)


func _ready():
	scene_node = start_scene.instantiate()

func change_scene(scene : PackedScene):
	scene_node = scene.instantiate()
