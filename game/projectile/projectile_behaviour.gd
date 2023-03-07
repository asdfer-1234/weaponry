extends Behaviour
class_name ProjectileBehaviour


const default_projectile = preload("res://game/projectile/projectile.tscn")

@export var pierce = 1
@export var size : float = 1
@export var damage : Damage
@export var lifetime : float = 2
@export var attack_on_hit : Attack
@export var attack_on_expire : Attack
var modifier : Modifier
var hit = false
var modifier_attack_used = false

func get_default_projectile():
	return default_projectile


func projectile(node, new_modifier):
	var instantiated = get_default_projectile().instantiate()
	_set_defaults(node, instantiated)
	node.get_node("../%ProjectileCanvas").call_deferred("add_child", instantiated)
	instantiated.projectile_behaviour.modifier = new_modifier
	if instantiated.projectile_behaviour.modifier.pierce != null:
		instantiated.projectile_behaviour.pierce = instantiated.projectile_behaviour.modifier.pierce.apply(instantiated.projectile_behaviour.pierce)
	return instantiated

func _set_defaults(node, instantiated):
	instantiated.projectile_behaviour = self.duplicate()
	instantiated.scale = size * Vector2.ONE
	instantiated.position = node.position
	instantiated.global_rotation = node.global_rotation
	

func _update():
	super._update()
	node.get_tree().create_timer(lifetime).timeout.connect(expire)

func expire():
	_on_expire()
	node.queue_free()

func _on_hit(target):
	if target.died:
		return
	pierce -= 1
	
	var applied_damage = damage.duplicate()
	if modifier != null and modifier.damage != null:
		applied_damage.damage = modifier.damage.apply(applied_damage.damage)
	target.damage(applied_damage)
	if pierce <= 0:
		hit = true
		node.queue_free()
	if attack_on_hit != null:
		attack_on_hit.attack(node, target, modifier)
	elif not modifier_attack_used:
		modifier.attack_on_hit.attack(node, target, modifier, true)

func _on_expire():
	if attack_on_expire != null:
		attack_on_expire.attack(node, null, modifier, true)
	#modifier.attack_on_expire.attack(node, null, modifier)

func tooltip():
	var text = ""
	text += RichTextBuilder.property_text(tr("PIERCE"), RichTextBuilder.color_text(str(pierce), Palette.green))
	if damage != null:
		text += damage.tooltip()
	if attack_on_hit != null:
		text += RichTextBuilder.subproperty(tr("ON_HIT"), attack_on_hit.tooltip())
	if attack_on_expire != null:
		text += RichTextBuilder.subproperty(tr("ON_EXPIRE"), attack_on_expire.tooltip())
	return text
