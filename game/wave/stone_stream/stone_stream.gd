extends Resource
class_name StoneStream

signal spawn_finish

func spawn(map):
	spawn_finish.emit()

