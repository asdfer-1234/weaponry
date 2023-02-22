extends Attack
class_name ProjectileAttack

@export var projectile_behaviour : ProjectileBehaviour
@export var spread : float = 0
@export var count : int = 1
@export var delay : float = 0


func attack(from, _target, modifier):
	for i in range(count):
		var projectile = projectile_behaviour.projectile(from, modifier)
		projectile.rotate(randf_range(deg_to_rad(spread), -deg_to_rad(spread)))
		if delay != 0:
			await from.get_tree().create_timer(delay).timeout

func tooltip():
	return projectile_behaviour.tooltip()

func to_attack_array():
	var new = AttackArray.new()
	new.attacks = [self]
	return new
