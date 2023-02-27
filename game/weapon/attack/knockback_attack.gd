extends Attack
class_name KnockbackAttack
@export var knockback : int

func attack(_from, target, modifier, _modifier_attack_used = false):
	target.knockback(modifier.knockback.apply(knockback))
