extends Resource
class_name StoneStream

signal spawn_finish

func spawn(_map):
	spawn_finish.emit()

