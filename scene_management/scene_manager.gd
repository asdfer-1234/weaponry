extends Node

@export var start_scene : PackedScene
@export var scenes : Array[SceneName]

var map_unique : PackedScene

var scene : PackedScene:
	set(value):
		scene = value
		scene_node = scene.instantiate()

var scene_node : Node:
	set(value):
		if scene_node != null:
			scene_node.queue_free()
		scene_node = value
		add_child(scene_node)
		move_child(scene_node, 2)


func _ready():
	scene = start_scene

func change_scene(new_scene : PackedScene):
	scene = new_scene

func change_scene_by_string(string : String):
	for i in scenes:
		if i.name == string:
			change_scene(i.scene)
			return

func reload_scene():
	scene = scene

func play_music(stream):
	if $Music.stream != stream:
		$Music.stream = stream
		$Music.play()
