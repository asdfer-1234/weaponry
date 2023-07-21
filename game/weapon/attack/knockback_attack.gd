extends Attack
class_name KnockbackAttack
@export var knockback : int

func attack(_from, target):
	target.knockback(knockback)
