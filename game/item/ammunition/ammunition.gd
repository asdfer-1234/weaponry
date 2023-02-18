extends StackableItem
class_name Ammunition

@export var modifier : WeaponModifier

func tooltip():
	return super.tooltip() + modifier.tooltip()
