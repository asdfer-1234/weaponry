extends Item
class_name Accessory

@export var modifier : Modifier

func tooltip():
	return super.tooltip() + modifier.tooltip()
