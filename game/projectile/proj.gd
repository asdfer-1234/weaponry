extends Area2D

@export var projectile_behaviour : ProjectileBehaviour

func _ready():
	projectile_behaviour.update(self)

func _physics_process(delta):
	projectile_behaviour._process(delta)


func _on_enter(target):
	if not projectile_behaviour.hit and not target.excluded_projectiles.has(self):
		target.excluded_projectiles.append(self)
		projectile_behaviour._on_hit(target)

func _draw():
	projectile_behaviour._draw()
