extends Weapon
class_name AimWeapon

@export var infinite_swivel = false
@export var swivel_speed = 360.0
@export var targeter : Targeter
@export var ranger : Ranger
@export var attack_speed : float = 2
@export var attack : Attack
var shootable = true

const shoot_angle = 2
const maximum_attack_delay = 5

func _process(delta):
	if not node.building:
		var target = targeter.get_target(node, self.ranger.get_targets(node))
		if target != null:
			swivel(node, delta, target.global_position)
			if (shootable and
					abs(_angle_difference(node.global_rotation,
					(target.global_position - node.global_position).angle())) <
					deg_to_rad(shoot_angle)):
				shoot(target)

func shoot(target):
	attack.attack(node, target, get_damage_boost())
	shootable = false
	var timer = node.get_tree().create_timer(get_attack_delay(), true, true)
	timer.timeout.connect(_timer_timeout)
	use_ammo()

func get_attack_delay():
	var delay = 1 / get_attack_speed_boost().apply(attack_speed)
	return min(delay, maximum_attack_delay)

func get_attack_speed_boost():
	var boosts = []
	for i in get_all_modifiers():
		if i.attack_speed != null:
			boosts.append(i.attack_speed)
	return boost_array(boosts)

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

func _draw():
	ranger._draw(node)

func tooltip():
	var text = ""
	if not infinite_swivel:
		text += RichTextBuilder.property_text(
				tr("SWIVEL"), RichTextBuilder.color_text(str(swivel_speed), Palette.green))
	text += RichTextBuilder.property_text(tr("ATTACK_SPEED"),
			RichTextBuilder.color_text(str(attack_speed), Palette.green))
	text += RichTextBuilder.subproperty(tr("RANGE"), ranger.tooltip())
	text += RichTextBuilder.subproperty(tr("ATTACK"), attack.tooltip())
	text += RichTextBuilder.subproperty(tr("TARGETING"), targeter.tooltip())
	
	return text
