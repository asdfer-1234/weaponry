extends GameGlobalVariable

var health:
	get:
		return value
	set(set_value):
		value = set_value
		if value <= 0:
			gameover()

func gameover():
	print("gameover")
	Engine.time_scale = 0
