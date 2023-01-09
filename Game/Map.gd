extends Node

export(PackedScene) var enemy_scene
export var interval : int

func generate():
	var enemy = enemy_scene.instance()
	var hostile_path = $HostilePaths/HostilePath/PathFollow2D
	hostile_path.offset = 0
	enemy.position = hostile_path.global_position
	$Stones.add_child(enemy)
