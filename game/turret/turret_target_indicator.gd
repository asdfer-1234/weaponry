extends Control


func _process(_delta):
	return
	var target_turret = get_parent().turret
	if target_turret == null:
		visible = false
		return
	var target = target_turret.get_target()
	if target != null:
		visible = true
		global_position = Vector2(target.x - 8, target.y - 8)
	else:
		visible = false
