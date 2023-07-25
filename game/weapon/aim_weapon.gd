extends Weapon
class_name AimWeapon

@export var infinite_swivel : bool = false
@export var swivel_speed : float = 360.0
@export var targeter : Targeter
@export var ranger : Ranger
@export var attack_speed : float = 2
@export var attack : Attack
var shootable = true

const shoot_angle = 5
const maximum_attack_delay = 5
const minimum_attack_speed = 0.01
const shoot_audio = preload("res://game/turret/shoot.wav")

func _process(delta):
	if not node.building:
		var target = get_targeter().get_target(node, get_ranger().get_targets(node))
		if target != null:
			swivel(node, delta, target.global_position)
			if (shootable and
					abs(_angle_difference(node.global_rotation,
					(target.global_position - node.global_position).angle())) <
					deg_to_rad(shoot_angle)):
				shoot(target)

func shoot(target):
	attack.attack(node, target, get_modifier())
	shootable = false
	var timer = node.get_tree().create_timer(get_attack_delay(), true, true)
	timer.timeout.connect(_timer_timeout)
	Audio.play_audio(shoot_audio, get_attack_delay())
	use_ammo()

func get_attack_delay():
	var delay = 1 / max(get_modifier().attack_speed.apply(attack_speed), minimum_attack_speed)
	return min(delay, maximum_attack_delay)

func _timer_timeout():
	shootable = true
	pass

func get_ranger():
	var applied_ranger
	if get_modifier().ranger == null:
		applied_ranger = ranger
	else:
		applied_ranger = get_modifier().ranger
	applied_ranger = applied_ranger.duplicate()
	applied_ranger.apply_boost(get_modifier().range_boost)
	return applied_ranger

func get_targeter():
	var modifier = get_modifier()
	if modifier.targeter == null:
		return targeter
	else:
		return modifier.targeter

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
	get_ranger()._draw(node)

func tooltip():
	var text = ""
	text += super.tooltip()
	if not infinite_swivel:
		text += RichTextBuilder.property_text(
				tr("SWIVEL"), RichTextBuilder.color_text(str(swivel_speed), Palette.green))
	text += RichTextBuilder.property_text(tr("ATTACK_SPEED"),
			RichTextBuilder.color_text(str(attack_speed), Palette.green))
	text += RichTextBuilder.subproperty(tr("RANGE"), ranger.tooltip())
	text += RichTextBuilder.subproperty(tr("ATTACK"), attack.tooltip())
	text += RichTextBuilder.subproperty(tr("TARGETING"), targeter.tooltip())
	
	return text
