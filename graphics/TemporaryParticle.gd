extends Particles2D

func _ready():
	emitting = true
	$Timer.wait_time = lifetime

func _expire():
	queue_free()
