extends Node

@export var start_scene : PackedScene
@export var scenes : Array[SceneName]

var map_unique : PackedScene

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

func change_scene_by_string(string : String):
	for i in scenes:
		if i.name == string:
			change_scene(i.scene)
			return
