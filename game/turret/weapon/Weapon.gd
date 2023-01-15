tool

extends Resource
class_name Weapon
export(Texture) var sprite : Texture = load("res://game/turret/weapon/default_weapon/triangle.png")
export(int) var slotCount = 0

func update_sprite(node : Node):
	if node.has_node("Sprite"):
		node.get_node("Sprite").texture = sprite


func process(node : Node, delta : float):
	pass

func free_weapon_children(node : Node):
	if node.has_node("Weapon"):
		for i in node.get_node("Weapon").get_children():
			i.queue_free()


func update_texture(node : Node):
	if node.has_node("Sprite"):
		node.get_node("Sprite").texture = sprite

func update(node : Node):
	update_texture(node)
	free_weapon_children(node)

func select(node : Node):
	pass

func mouse_enter(node : Node):
	pass

func mouse_exit(node : Node):
	pass

