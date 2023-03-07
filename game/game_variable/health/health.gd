extends GameGlobalVariable

const health_loss_audio = preload("res://game/game_variable/health_loss.wav")

var health:
	get:
		return value
	set(set_value):
		Audio.play_audio(health_loss_audio)
		value = set_value
		if value <= 0:
			value = 0
			if not %GameEnd.game_over:
				%GameEnd.defeat()
