extends Item
class_name AccessoryItem

@export var modifier : Modifier

func tooltip():
	return super.tooltip() + modifier.tooltip()
