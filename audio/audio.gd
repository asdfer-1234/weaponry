extends Node

const audio_node = preload("res://audio/audio_player.tscn")


func play_audio(audio):
	var instantiated = audio_node.instantiate()
	instantiated.stream = audio
	add_child(instantiated)
	
