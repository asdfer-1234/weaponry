extends Node

var previous_id := 0

func get_id():
	previous_id += 1
	return previous_id
