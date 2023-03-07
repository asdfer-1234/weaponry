extends Node

const press_audio = preload("res://ui/button_click.wav")
func _ready():
	get_parent().pressed.connect(_pressed)

func _pressed():
	Audio.play_audio(press_audio)
