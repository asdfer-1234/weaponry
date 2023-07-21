extends Item
class_name WeaponItem

@export var weapon : ModifiableWeapon

func tooltip():
	# temporary testing code start
	if weapon == null:
		return super.tooltip()
	# temporary testing code end
	return super.tooltip() + weapon.tooltip()

func on_buy():
	weapon.setup_items()
