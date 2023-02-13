extends Area2D

@export var projectile_behaviour : ProjectileBehaviour
var damage_multiplier


func _ready():
	projectile_behaviour = projectile_behaviour.duplicate()
	projectile_behaviour.update(self)

func _physics_process(delta):
	projectile_behaviour._process(delta)


func _on_enter(target):
	if not projectile_behaviour.hit:
		projectile_behaviour._on_hit(target)

func _draw():
	projectile_behaviour._draw()
