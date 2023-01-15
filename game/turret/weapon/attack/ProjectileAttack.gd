tool

extends Attack
class_name ProjectileAttack

export(Resource) var projectile_behaviour_resource = MovingProjectileBehaviour.new()
var projectile_behaviour

func update(node):
	projectile_behaviour = projectile_behaviour_resource

func attack(node):
	projectile_behaviour.projectile(node)
