extends Behaviour
class_name Weapon
@export var sprite : Texture = load("res://game/weapon/default_weapon/default_weapon_turret.png")
@export var flip_mode : SpriteFlipper.FlipMode = SpriteFlipper.FlipMode.NONE

func _update():
	super._update()
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
	return ""

func use_ammo():
	var modifiable_weapon = node.get_modifiable_weapon()
	if modifiable_weapon != null:
		modifiable_weapon.use_ammo()

func apply(modifier : Modifier):
	pass

func applied(modifier : Modifier) -> Weapon:
	var build = duplicate(true)
	build.apply(modifier)
	return build
