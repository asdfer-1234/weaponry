extends "res://Game/Stone.gd"

export(PackedScene) var child_stone

func on_die():
	spawn_stone(child_stone, 2)
