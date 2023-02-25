extends Node

@export var wave : Wave
@onready var hostile_path = $HostilePaths/HostilePath/PathFollow2D


func _ready():
	generate()


func generate():
	wave.spawn(self)
	await wave.spawn_finish
	print("spawn finish")


func spawn(stone : PackedScene):
	var instantiated = stone.instantiate()
	hostile_path.progress = 0
	instantiated.global_position = hostile_path.global_position
	$Stones.add_child(instantiated)
