extends Node

@export var music : AudioStream

func _ready():
	get_tree().get_first_node_in_group("scene_manager").play_music(music)
