extends Node

var _random_number_generator = RandomNumberGenerator.new()

func _ready():
	_random_number_generator.randomize()

func randf_range(from, to):
	return _random_number_generator.randf_range(from, to)
