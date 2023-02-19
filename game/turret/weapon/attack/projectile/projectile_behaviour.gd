extends Behaviour
class_name ProjectileBehaviour


const default_projectile = preload("res://game/turret/weapon/attack/projectile/projectile.tscn")

@export var pierce = 1
@export var size : float = 1
@export var damage : Damage
@export var lifetime : float = 2
@export var attack_on_hit : Attack

var hit = false

func get_default_projectile():
	return default_projectile


func projectile(node):
	var instantiated = get_default_projectile().instantiate()
	_set_defaults(node, instantiated)
	node.get_node("../%ProjectileCanvas").call_deferred("add_child", instantiated)
	return instantiated

func _set_defaults(node, instantiated):
	instantiated.projectile_behaviour = self.duplicate()
	instantiated.projectile_behaviour.damage = instantiated.projectile_behaviour.damage.duplicate()
	instantiated.scale = size * Vector2.ONE
	instantiated.position = node.position
	instantiated.global_rotation = node.global_rotation

func _update():
	super._update()
	node.get_tree().create_timer(lifetime).timeout.connect(expire)

func expire():
	node.queue_free()

func _on_hit(target):
	if target.died:
		return
	pierce -= 1
	
	var applied_damage = damage.duplicate()
	applied_damage.damage = node.damage_multiplier.apply(applied_damage.damage)
	target.damage(applied_damage)
	
	if pierce <= 0:
		hit = true
		node.queue_free()
	if attack_on_hit != null:
		attack_on_hit.attack(node, target, node.damage_multiplier)

func tooltip():
	var text = ""
	text += RichTextBuilder.property_text(tr("PIERCE"), RichTextBuilder.color_text(str(pierce), Palette.green))
	text += damage.tooltip()
	if attack_on_hit != null:
		text += RichTextBuilder.subproperty(tr("ON_HIT"), attack_on_hit.tooltip())
	return text
