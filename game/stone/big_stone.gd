extends Stone

@export var child_stone : PackedScene

func on_die():
	spawn_stone(child_stone, 2)

