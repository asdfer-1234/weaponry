extends Stone

const range = 100
const minimum = 10
const pull = 100

func _process(delta):
	var nearby_stones = get_nearby_stones_by_progress(range, -minimum) + get_nearby_stones_by_progress(-minimum, range)
	
	for i in nearby_stones:
		if i.progress < progress:
			i.progress += pull * delta
		elif i.progress > progress:
			i.progress -= pull * delta
