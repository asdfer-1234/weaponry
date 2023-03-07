extends StoneStream
class_name StoneStreamSegment

@export var stone : PackedScene

@export var delay : float
@export var count : int
@export var interval : float

func spawn(map):
	await map.get_tree().create_timer(delay, true, true).timeout
	
	for i in range(0, count - 1):
		if _spawn_stone(map) == false:
			spawn_finish.emit()
			return
		await map.get_tree().create_timer(interval, true, true).timeout
	if _spawn_stone(map) == false:
		spawn_finish.emit()
		return
	spawn_finish.emit()

func _spawn_stone(map):
	if map == null:
		return false
	map.spawn_stone_begin(stone)
	return true

