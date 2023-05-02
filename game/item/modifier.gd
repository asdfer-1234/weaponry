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
@export var attack_on_expire : Attack

func tooltip():
	var build = ""
	if damage != null:
		build += RichTextBuilder.property_text(tr("DAMAGE"), damage.minimal_tooltip())
	if attack_speed != null:
		build += RichTextBuilder.property_text(tr("ATTACK_SPEED"), attack_speed.minimal_tooltip())
	if pierce != null:
		build += RichTextBuilder.property_text(tr("PIERCE"), pierce.minimal_tooltip())
	if count != null:
		build += RichTextBuilder.property_text(tr("COUNT"), count.minimal_tooltip())
	if spread != null:
		build += RichTextBuilder.property_text(tr("SPREAD"), spread.minimal_tooltip())
	if knockback != null:
		build += RichTextBuilder.property_text(tr("KNOCKBACK"), knockback.minimal_tooltip())
	if range_boost != null:
		build += RichTextBuilder.property_text(tr("RANGE"), range_boost.minimal_tooltip())
	if ranger != null:
		build += RichTextBuilder.subproperty(tr("RANGE"), ranger.tooltip())
	if targeter != null:
		build += targeter.tooltip()
	if explosion != null:
		build += RichTextBuilder.property_text(tr("EXPLOSION"), explosion.minimal_tooltip())
	if attack_on_hit != null:
		build += RichTextBuilder.subproperty(tr("ON_HIT"), attack_on_hit.tooltip())
	if attack_on_expire != null:
		build += RichTextBuilder.subproperty(tr("ON_EXPIRE"), attack_on_expire.tooltip())
	return build

func _init():
	damage = Boost.new()
	attack_speed = Boost.new()
	pierce = Boost.new()
	count = Boost.new()
	spread = Boost.new()
	knockback = Boost.new()
	range_boost = Boost.new()
	explosion = Boost.new()
	attack_on_hit = AttackArray.new()
	attack_on_expire = AttackArray.new()

func add(other):
	damage.add(other.damage)
	attack_speed.add(other.attack_speed)
	pierce.add(other.pierce)
	count.add(other.count)
	spread.add(other.spread)
	knockback.add(other.knockback)
	range_boost.add(other.range_boost)
	explosion.add(other.explosion)
	attack_on_hit.add(other.attack_on_hit)
	attack_on_expire.add(other.attack_on_expire)
	
	if ranger == null:
		ranger = other.ranger
	if targeter == null:
		targeter = other.targeter
