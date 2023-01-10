extends Sprite


func _process(_delta):
	var target = $"../..".get_target()
	if target != null:
		visible = true
		global_position = target
		global_rotation = 0
	else:
		visible = false
