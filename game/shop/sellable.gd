extends Resource
class_name Sellable

@export var availibility : float

func weight(progress):
	return availibility + (1 - availibility) * progress

func pick(_progress):
	return self
