extends Area2D

@export var projectile_behaviour : ProjectileBehaviour
@export var id : int

func _ready():
	projectile_behaviour.update(self)

func _physics_process(delta):
	projectile_behaviour._process(delta)

func _on_enter(target):
	if _projectile_hittable(target):
		target.excluded_projectiles.append(id)
		projectile_behaviour._on_hit(target)

func _projectile_hittable(target):
	var hit = projectile_behaviour.hit
	var excluded = target.excluded_projectiles.has(id)
	return not (hit or excluded)

func _draw():
	projectile_behaviour._draw()
