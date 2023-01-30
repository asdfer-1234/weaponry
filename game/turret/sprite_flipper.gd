extends Sprite2D
class_name SpriteFlipper


enum FlipMode {NONE, HORIZONTAL, VERTICAL}

@export var flip_mode : FlipMode = FlipMode.NONE

func _process(_delta):
	if flip_mode == FlipMode.NONE:
		return
	elif flip_mode == FlipMode.HORIZONTAL:
		flip_v = abs(global_rotation) > TAU / 4
	else:
		flip_v = global_rotation < 0
