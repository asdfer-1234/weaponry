extends Item
class_name AmmunitionItem

@export var modifier : Modifier

func tooltip():
	return super.tooltip() + modifier.tooltip()
