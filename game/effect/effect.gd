extends Node
class_name Effect

@export var duration : float = 1

func _ready():
	get_tree().create_timer(duration, true, true).timeout.connect(expire)

func expire():
	queue_free()
