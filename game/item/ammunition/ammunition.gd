extends StackableItem
class_name Ammunition

@export var attack_speed_multiplier : float = 1
@export var damage_multiplier : float = 1

func tooltip():
	return (super.tooltip() +
			RichTextBuilder.property_text(
					tr("DAMAGE"), RichTextBuilder.multiplier_text(damage_multiplier)) + 
			RichTextBuilder.property_text(
					tr("ATTACK_SPEED"), RichTextBuilder.multiplier_text(attack_speed_multiplier)))

