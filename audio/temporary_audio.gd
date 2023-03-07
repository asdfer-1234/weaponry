extends AudioStreamPlayer


func _on_finish_audio():
	queue_free()
