extends Button

@export var map_unique : PackedScene
@export var map_name : String:
	set(value):
		map_name = value
		if has_node("MapName"):
			$MapName.text = map_name

@export var preview : Texture:
	set(value):
		preview = value
		if has_node("Preview"):
			$Preview.texture = preview

const game = preload("res://game/game.tscn")

func _ready():
	map_name = map_name
	preview = preview

func _on_pressed():
	var scene_manager = get_tree().get_first_node_in_group("scene_manager")
	scene_manager.map_unique = map_unique
	scene_manager.change_scene(game)
