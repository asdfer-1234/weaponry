extends Attack
class_name ProjectileAttack

@export var projectile_behaviour : ProjectileBehaviour
@export var spread : float = 0
@export var count : int = 1
@export var delay : float = 0


func attack(from, _target, modifier):
	super.attack(from, _target, modifier)
	for i in range(modifier.count.apply(count)):
		var projectile = projectile_behaviour.projectile(from, modifier)
		var applied_spread = modifier.spread.apply(spread)
		projectile.rotate(randf_range(deg_to_rad(applied_spread), -deg_to_rad(applied_spread)))
		if delay != 0:
			await from.get_tree().create_timer(delay).timeout

func tooltip():
	var build = ""
	build += RichTextBuilder.property_text(
			tr("SPREAD"), 
			RichTextBuilder.color_text(str(spread), 
			Palette.red))
	if count != 1:
		build += RichTextBuilder.property_text(
				tr("COUNT"), 
				RichTextBuilder.color_text(str(count), 
				Palette.green))
	if delay != 0:
		build += RichTextBuilder.property_text(
				tr("DELAY"), 
				RichTextBuilder.color_text(str(delay), 
				Palette.yellow))
	build += projectile_behaviour.tooltip()
	return build

func to_attack_array():
	var new = AttackArray.new()
	new.attacks = [self]
	return new
