extends Stone
class_name Andesite

const granite_speed_boost = 1.5

func movement_process(delta):
	var granite_nearby = false
	for i in get_nearby_stones_by_distance(30):
		if i is Granite:
			granite_nearby = true
			break
	if granite_nearby:
		set_progress(progress + speed * delta * granite_speed_boost)
	else:
		super.movement_process(delta)
	
	
