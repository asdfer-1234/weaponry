tool

extends Weapon
class_name AimWeapon

export(bool) var infinite_swivel = false
export(float) var swivel_speed = 360.0
export(Resource) var targeter_resource = FirstTargeter.new()
var targeter
export(Resource) var ranger_resource = CircularRanger.new(0, 50)
var ranger
export(Resource) var attack_resource = ProjectileAttack.new()
var attack
const shoot_angle = 2.0

func update(node):
	.update(node)
	targeter = targeter_resource
	ranger = ranger_resource
	attack = attack_resource

func process(node, delta):
	.process(node, delta)
	swivel(node, targeter.get_target(node, ranger.get_targets(node)), delta)

func shoot(node):
	attack.attack(node)

func swivel(node, target, delta):
	var target_rotation = (target - node.global_position).angle()
	if infinite_swivel:
		node.global_rotation = target_rotation
	else:
		var relative_swivel = angle_difference(node.global_rotation, target_rotation)
		var swivel_limit = deg2rad(swivel_speed) * delta
		if relative_swivel > 0:
			node.rotate(min(relative_swivel, swivel_limit))
		else:
			node.rotate(max(relative_swivel, -swivel_limit))

func angle_difference(from, to):
	var ans = fposmod(to - from, TAU)
	if ans > PI:
		ans -= TAU
	return ans
