extends Resource
class_name Behaviour

var node : Node

func update(node):
	self.node = node
	_update()

func _update():
	pass

func _process(_delta):
	pass

func _draw():
	pass
