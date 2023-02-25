extends Attack
class_name KnockbackAttack
@export var knockback : int

func attack(_from, target, modifier):
	target.knockback(modifier.knockback.apply(knockback))
