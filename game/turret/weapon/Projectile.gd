extends Area2D

export(Resource) var projectile_resource
onready var projectile : ProjectileBehaviour = projectile_resource
onready var pierce : int = projectile.pierce
var hit : bool = false

func _physics_process(delta):
	projectile._process(self, delta)
	

func die():
	queue_free()

func _on_enter(target : Node):
	if not hit and not target.died and not target.excluded_projectiles.has(self):
		target.excluded_projectiles.push_back(self)
		pierce -= 1
		if pierce <= 0:
			hit = true
			die()
		projectile.on_hit(target)

func _expire():
	die()
