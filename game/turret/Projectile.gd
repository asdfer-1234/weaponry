extends Area2D

export var speed : int
export var pierce : int
export var damage : int

func _physics_process(_delta):
	translate(Vector2(speed, 0).rotated(rotation))

func on_hit(target):
	target.damage(damage)
	pierce -= 1
	if pierce <= 0:
		die()

func die():
	queue_free()
	

func _on_enter(target):
	if target.is_in_group("stone"):
		on_hit(target)

func _expire():
	die()
