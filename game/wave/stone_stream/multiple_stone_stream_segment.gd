extends StoneStream
class_name MultipleStoneStreamSegment

@export var wave_segment : Array[StoneStreamSegment]

signal wave_segment_spawn_finish

func spawn(map):
	
	for i in wave_segment:
		i.spawn(map)
		i.spawn_finish.connect(_on_spawn_finish)
	for i in wave_segment:
		await wave_segment_spawn_finish
	spawn_finish.emit()

func _on_spawn_finish():
	wave_segment_spawn_finish.emit()
