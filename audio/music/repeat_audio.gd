extends AudioStreamPlayer


func _ready():
	finished.connect(_repeat)
func _repeat():
	play()
