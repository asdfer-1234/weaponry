extends Path2D

const width = 16
const color = Palette.secondary
const detail = 128
@onready var line = $Line2D
@onready var build_blocker = $BuildBlocker
const build_blocker_shape = preload("res://game/map/build_blocker_shape.tscn")

func _ready():
	_ready_draw()
	_ready_buildblock()

func _ready_draw():
	line.default_color = color
	line.width = width
	for point in curve.get_baked_points():
		line.add_point(point + position)

func _ready_buildblock():
	for point in curve.get_baked_points():
		var instantiated = build_blocker_shape.instantiate()
		instantiated.position = point
		build_blocker.add_child(instantiated)
