extends StoneStream
class_name StoneStreamSegment

@export var stone : PackedScene

@export var delay : float
@export var count : int
@export var interval : float

func spawn(map):
	await map.get_tree().create_timer(delay, true, true).timeout
	
	for i in range(0, count - 1):
		_spawn_stone(map)
		await map.get_tree().create_timer(interval, true, true).timeout
	_spawn_stone(map)
	spawn_finish.emit()

func _spawn_stone(map):
	map.spawn(stone)

