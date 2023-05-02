extends Item
class_name WeaponItem

@export var weapon : Weapon

func tooltip():
	return super.tooltip() + weapon.tooltip()
