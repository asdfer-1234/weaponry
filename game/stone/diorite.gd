extends Stone
class_name Diorite

const split_stone_andesite = preload("res://game/stone/stone.tscn")

func on_die():
	for i in get_nearby_stones_by_distance(30):
		if i is Andesite:
			spawn_stone(split_stone_andesite, 2)
			break
