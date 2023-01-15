tool

extends Resource
class_name ProjectileBehaviour

export var sprite : Texture
export(int) var pierce = 1
export(float) var size = 1
export(float) var lifetime = 2


func update(node):
	node.get_node("Sprite").texture = sprite
	node.connect("area_entered", self, "on_hit", [node])
	node.lifetime = lifetime
	node.scale = Vector2.ONE * size
	node.pierce = pierce

func _process(node, delta):
	pass


func on_hit(target):
	pass
