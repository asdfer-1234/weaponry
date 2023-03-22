extends Attack
class_name EffectAttack

@export var effect : PackedScene

func attack(_from, target, _damage_multiplier = 1, _modifier_attack_used = false
):
	target.add_effect(effect)

func tooltip():
	var temp = effect.instantiate()
	var returner = RichTextBuilder.subproperty(tr("APPLY_EFFECT"), temp.tooltip())
	temp.queue_free()
	return returner
