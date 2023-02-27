extends GameGlobalVariable

var health:
	get:
		return value
	set(set_value):
		value = set_value
		if value <= 0:
			value = 0
			if not %GameEnd.game_over:
				%GameEnd.defeat()
	
