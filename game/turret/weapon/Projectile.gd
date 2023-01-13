extends Area2D

var speed : float = 1
var pierce : int = 1
var damage : Damage = Damage.new(10, Damage.Type.PHYSICAL)
var hit = false


func _physics_process(delta):
	translate(Vector2(speed, 0).rotated(rotation) * delta)
	
func on_hit(target):
	target.damage(damage)
	pierce -= 1
	if pierce <= 0:
		hit = true
		die()

func die():
	queue_free()
	

func _on_enter(target):
	if not hit and not target.died and not target.excluded_projectiles.has(self):
		target.excluded_projectiles.push_back(self)
		on_hit(target)
			

func _expire():
	die()
