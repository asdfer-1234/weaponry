extends Stone

@export var child_stone : PackedScene
@export var count : int = 2


func on_die():
	spawn_stone(child_stone, count)
