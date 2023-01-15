tool

extends ProjectileBehaviour
class_name MovingProjectileBehaviour

export(float) var speed = 200

func _process(node, delta):
	node.translate(Vector2(speed, 0).rotated(node.rotation) * delta)
	pass
