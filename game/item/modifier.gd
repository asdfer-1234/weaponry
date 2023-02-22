extends Resource
class_name WeaponModifier

@export var damage : Boost
@export var attack_speed : Boost
@export var pierce : Boost
@export var explosion : Boost
@export var extra_on_hit : Attack

func tooltip():
	var build = ""
	if damage != null:
		build += RichTextBuilder.property_text(tr("DAMAGE"), damage.minimal_tooltip())
	if attack_speed != null:
		build += RichTextBuilder.property_text(tr("ATTACK_SPEED"), attack_speed.minimal_tooltip())
	return build

func merge_array(array):
	var new = WeaponModifier.new()
	new.initialize_merge()
	for i in array:
		new.add(i)
	return new

func initialize_merge():
	damage = Boost.new()
	attack_speed = Boost.new()
	pierce = Boost.new()
	explosion = Boost.new()
	extra_on_hit = AttackArray.new()

func add(other):
	damage.add(other.damage)
	attack_speed.add(other.attack_speed)
	pierce.add(other.pierce)
	explosion.add(other.explosion)
	extra_on_hit.add(other)
