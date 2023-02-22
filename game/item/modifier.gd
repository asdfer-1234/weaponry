extends Resource
class_name Modifier

@export var damage : Boost
@export var attack_speed : Boost
@export var pierce : Boost
@export var count : Boost
@export var spread : Boost
@export var knockback : Boost
@export var range_boost : Boost
@export var ranger : Ranger
@export var targeter : Targeter
@export var explosion : Boost
@export var attack_on_hit : Attack

func tooltip():
	var build = ""
	if damage != null:
		build += RichTextBuilder.property_text(tr("DAMAGE"), damage.minimal_tooltip())
	if attack_speed != null:
		build += RichTextBuilder.property_text(tr("ATTACK_SPEED"), attack_speed.minimal_tooltip())
	return build

func merge_array(array):
	var new = Modifier.new()
	new.initialize_merge()
	for i in array:
		new.add(i)
	return new

func initialize_merge():
	damage = Boost.new()
	attack_speed = Boost.new()
	pierce = Boost.new()
	count = Boost.new()
	spread = Boost.new()
	knockback = Boost.new()
	range_boost = Boost.new()
	explosion = Boost.new()
	attack_on_hit = AttackArray.new()

func add(other):
	damage.add(other.damage)
	attack_speed.add(other.attack_speed)
	pierce.add(other.pierce)
	count.add(other.count)
	spread.add(other.spread)
	knockback.add(other.knockback)
	explosion.add(other.explosion)
	attack_on_hit.add(other.attack_on_hit)
	
	if ranger == null:
		ranger = other.ranger
	if targeter == null:
		targeter = other.targeter
