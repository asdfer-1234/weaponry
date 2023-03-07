extends Resource
class_name Wave

@export var stone_stream : StoneStream

signal spawn_finish

func spawn(map):
	stone_stream.spawn(map)
	await stone_stream.spawn_finish
	spawn_finish.emit()
