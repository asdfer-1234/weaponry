extends Node

@export var enemy_scene : PackedScene



func generate():
	var enemy = enemy_scene.instantiate()
	var hostile_path = $HostilePaths/HostilePath/PathFollow2D
	hostile_path.h_offset = 0
	enemy.position = hostile_path.global_position
	$Stones.add_child(enemy)
