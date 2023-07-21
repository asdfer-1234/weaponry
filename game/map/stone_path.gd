extends Path2D
class_name StonePath

const width = 16
const color = Palette.secondary

var max_progress : float

# Onready variables
@onready var line = $Line
@onready var build_blocker = $BuildBlocker
@onready var path_follow = $PathFollow
const build_blocker_shape = preload("res://game/map/build_blocker_shape.tscn")


func _ready():
	_draw_path()
	_place_buildblock()
	_bake_max_progress()

func _draw_path():
	line.default_color = color
	line.width = width
	for point in curve.get_baked_points():
		line.add_point(point + position)

func _place_buildblock():
	for point in curve.get_baked_points():
		var instantiated = build_blocker_shape.instantiate()
		instantiated.position = point
		build_blocker.add_child(instantiated)

func _bake_max_progress():
	path_follow.progress_ratio = 1.0
	max_progress = path_follow.progress

func get_position_from_progress(progress):
	path_follow.progress = progress
	return path_follow.global_position
