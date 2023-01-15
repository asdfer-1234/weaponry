extends Stone

export(PackedScene) var child_stone

func on_die():
	spawn_stone(child_stone, 2)
