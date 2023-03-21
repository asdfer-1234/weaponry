extends Node

const audio_node = preload("res://audio/audio_player.tscn")


func play_audio(audio, decibel = 0):
	var instantiated = audio_node.instantiate()
	instantiated.stream = audio
	instantiated.volume_db += decibel
	add_child(instantiated)
	
