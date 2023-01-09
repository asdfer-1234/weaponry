tool

extends Node2D

export var attack_speed : float setget set_attack_speed
export var attack_range : float setget set_attack_range
export var rotation_speed : float
export var attack_angle : float
export(PackedScene) var projectile : PackedScene


func set_attack_range(set):
	attack_range = set
	
	if has_node("Range/CollisionShape2D"):
		$Range/CollisionShape2D.shape.radius = attack_range

func set_attack_speed(set):
	attack_speed = set
	
	if has_node("ShootTimer"):
		$ShootTimer.wait_time = attack_speed

func _physics_process(_delta):
	if not Engine.editor_hint:
		turret_process()

func turret_process():
	var target = get_target()
	if target != null:
		swivel(target)
		if shootable(target) && $ShootTimer.is_stopped():
			shoot(target)

func get_target():
	var enemies = get_tree().get_nodes_in_group("stone")
	
	if len(enemies) == 0:
		return
	
	var max_progressed = null
	
	for i in enemies:
		if max_progressed == null || i.progress > max_progressed.progress:
			if $Range.overlaps_area(i):
				max_progressed = i
	if max_progressed != null:
		return max_progressed.position


func swivel(target : Vector2):
	var target_rotation = (target - global_position).angle()
	var relative_swivel = angle_difference(global_rotation, target_rotation)
	if relative_swivel > 0:
		rotate(min(relative_swivel, deg2rad(rotation_speed)))
	else:
		rotate(max(relative_swivel, -deg2rad(rotation_speed)))
	

func shootable(target : Vector2):
	var target_rotation = (target - global_position).angle()
	return abs(angle_difference(target_rotation, global_rotation)) <= deg2rad(attack_angle)


func shoot(target):
	$ShootTimer.start()
	instantiate_projectile()

func instantiate_projectile():
	var instantiated = projectile.instance()
	instantiated.global_position = global_position
	instantiated.global_rotation = global_rotation
	get_tree().root.add_child(instantiated)

func angle_difference(from : float, to : float):
	var ans = fposmod(to - from, TAU)
	if ans > PI:
		ans -= TAU
	return ans
