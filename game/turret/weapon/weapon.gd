extends Behaviour
class_name Weapon
@export var sprite : Texture = load("res://game/turret/weapon/default_weapon/default_weapon_turret.png")
@export var slotCount = 0
@export var flip_mode : SpriteFlipper.FlipMode = SpriteFlipper.FlipMode.NONE
@export var ammunition_slot_count : int

func _update():
	_update_sprite()

func _update_sprite():
	if node.has_node("Sprite"):
		node.get_node("Sprite").texture = sprite
		node.get_node("Sprite").flip_mode = flip_mode

func _select():
	pass

func _mouse_enter():
	pass

func _mouse_exit():
	pass

func tooltip():
	pass
