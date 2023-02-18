extends Attack
class_name EffectAttack

@export var effect : PackedScene

func attack(_from, target, _damage_multiplier = 1):
	target.add_child(effect.instantiate())

func tooltip():
	var temp = effect.instantiate()
	return RichTextBuilder.subproperty(tr("APPLY_EFFECT"), temp.tooltip())
	temp.queue_free()
