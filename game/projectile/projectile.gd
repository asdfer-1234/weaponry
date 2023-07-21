extends Area2D

@export var projectile_behaviour : ProjectileBehaviour

func _ready():
	projectile_behaviour.update(self)

func _physics_process(delta : float):
	projectile_behaviour._process(delta)

func _on_enter(target : Stone):
	if _projectile_hittable(target):
		projectile_behaviour._on_hit(target)

func _projectile_hittable(target : Stone) -> bool:
	var projectile_expired : bool = projectile_behaviour.expired
	var target_expired : bool = target.expired
	return not (projectile_expired or target_expired)

func _draw():
	projectile_behaviour._draw()
