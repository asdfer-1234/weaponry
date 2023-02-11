extends StackableItem
class_name Ammunition

@export var attack_speed_multiplier : float = 1
@export var damage_multiplier : float = 1

func tooltip():
	return (super.tooltip() +
			RichTextBuilder.property_text(
					"Damage", RichTextBuilder.multiplier_text(damage_multiplier)) + 
			RichTextBuilder.property_text(
					"Attack speed", RichTextBuilder.multiplier_text(attack_speed_multiplier)))

