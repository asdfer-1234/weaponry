extends Attack
class_name ProjectileAttack

@export var projectile_behaviour : ProjectileBehaviour
@export var spread : float = 0
@export var count : int = 1

func attack(node):
	for i in range(count):
		var projectile = projectile_behaviour.projectile(node)
		projectile.rotate(Random.randf_range(deg_to_rad(spread), -deg_to_rad(spread)))
