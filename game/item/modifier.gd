extends Resource
class_name WeaponModifier

@export var damage : Boost
@export var attack_speed : Boost
@export var explosion : Boost
@export var extra_on_hit : Attack

func tooltip():
	var build = ""
	if damage != null:
		build += RichTextBuilder.property_text(tr("DAMAGE"), damage.minimal_tooltip())
	if attack_speed != null:
		build += RichTextBuilder.property_text(tr("ATTACK_SPEED"), attack_speed.minimal_tooltip())
	return build
