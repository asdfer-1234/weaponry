extends Area2D

@export var projectile_behaviour : ProjectileBehaviour
var just_hit : bool

func _ready():
	projectile_behaviour.update(self)
	just_hit = true

func _physics_process(delta : float):
	projectile_behaviour._process(delta)
	just_hit = false

func _on_enter(target : Stone):
	if not just_hit and _projectile_hittable(target):
		projectile_behaviour._on_hit(target)
		just_hit = true

func _projectile_hittable(target : Stone) -> bool:
	var hit : bool = projectile_behaviour.hit
	var died : bool = target.died
	return not (hit or died)

func _draw():
	projectile_behaviour._draw()
