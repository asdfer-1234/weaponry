extends Item
class_name Accessory

@export var modifier : WeaponModifier

func tooltip():
	return super.tooltip() + modifier.tooltip()
