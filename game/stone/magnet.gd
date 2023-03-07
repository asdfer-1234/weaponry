extends Stone

const magnet_range = 100
const minimum = 10
const pull = 100

func _process(delta):
	var nearby_stones = get_nearby_stones_by_progress(magnet_range, -minimum) + get_nearby_stones_by_progress(-minimum, magnet_range)
	
	for i in nearby_stones:
		if i.progress < progress:
			i.progress += pull * delta
		elif i.progress > progress:
			i.progress -= pull * delta
