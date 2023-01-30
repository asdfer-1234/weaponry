extends Weapon
class_name AimWeapon

@export var infinite_swivel = false
@export var swivel_speed = 360.0
@export var targeter : Targeter
@export var ranger : Ranger
@export var attack_speed : float = 2
@export var attack : Attack
var shootable = true

const shoot_angle = 2.0

func _process(delta):
	var target = targeter.get_target(node, self.ranger.get_targets(node))
	if target != null:
		swivel(node, delta, target.global_position)
		if shootable and abs(_angle_difference(node.global_rotation, (target.global_position - node.global_position).angle())) < deg_to_rad(shoot_angle):
			shoot(node)

func shoot(node):
	attack.attack(node)
	shootable = false
	var timer = node.get_tree().create_timer(1 / attack_speed, true, true)
	timer.timeout.connect(_timer_timeout)
	
func _timer_timeout():
	shootable = true
	pass

func swivel(node, delta, target):
	var target_rotation = (target - node.global_position).angle()
	if infinite_swivel:
		node.global_rotation = target_rotation
	else:
		var relative_swivel = _angle_difference(node.global_rotation, target_rotation)
		var swivel_limit = deg_to_rad(swivel_speed) * delta
		if relative_swivel > 0:
			node.rotate(min(relative_swivel, swivel_limit))
		else:
			node.rotate(max(relative_swivel, -swivel_limit))

func _angle_difference(from, to):
	var ans = fposmod(to - from, TAU)
	if ans > PI:
		ans -= TAU
	return ans
