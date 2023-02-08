extends Node

@export var start_scene : PackedScene

func _ready():
	add_child(start_scene.instantiate())

func change_scene(scene : PackedScene):
	get_child(0).queue_free()
	add_child(scene.instantiate())
