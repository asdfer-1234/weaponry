extends StackableItem
class_name Ammunition

@export var modifier : Modifier

func tooltip():
	return super.tooltip() + modifier.tooltip()
