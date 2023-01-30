extends Node2D

const explosion = preload("res://game/explosion/explosion.tscn")

func _ready():
	print(explosion)
	add_child(explosion.instantiate())
