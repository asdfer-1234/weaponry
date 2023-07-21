extends Behaviour
class_name ProjectileBehaviour


const default_projectile = preload("res://game/projectile/projectile.tscn")

@export var pierce = 1
@export var size : float = 1
@export var damage : Damage
@export var lifetime : float = 2
@export var attack_on_hit : Attack
@export var attack_on_expire : Attack
var expired : bool = false

func get_default_projectile():
	return default_projectile


func projectile(node):
	var instantiated = get_default_projectile().instantiate()
	_set_defaults(node, instantiated)
	node.get_node("../%ProjectileCanvas").add_child.call_deferred(instantiated)
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

func _on_hit(target : Stone):
	pierce -= 1
	if damage != null:
		target.recieve_damage(damage)
	
	var push_excluded : bool = false
	if pierce <= 0:
		expired = true
		node.queue_free()
	else:
		push_excluded = true
	
	if attack_on_hit != null:
		print("eeeeeeeeeeeeoooooooo")
		attack_on_hit.attack(node, target)
		push_excluded = true

func _on_expire():
	if attack_on_expire != null:
		attack_on_expire.attack(node, null)

func tooltip():
	var text = ""
	text += RichTextBuilder.property_text(tr("PIERCE"), RichTextBuilder.color_text(str(pierce), Palette.green))
	if size != 1:
		text += RichTextBuilder.property_text(tr("SIZE"), RichTextBuilder.color_text(str(size), Palette.green))
	if damage != null:
		text += damage.tooltip()
	if attack_on_hit != null:
		text += RichTextBuilder.subproperty(tr("ON_HIT"), attack_on_hit.tooltip())
	if attack_on_expire != null:
		text += RichTextBuilder.subproperty(tr("ON_EXPIRE"), attack_on_expire.tooltip())
	return text

func apply(modifier : Modifier):
	if damage != null:
		damage = damage.applied(modifier)
	pierce = modifier.pierce.applied(pierce)

	attack_on_hit = _add_attack(attack_on_hit, modifier.attack_on_hit)
	attack_on_expire = _add_attack(attack_on_expire, modifier.attack_on_expire)

func _add_attack(a : Attack, b : Attack):
	if a == null:
		return b
	return a.added(b)

func applied(modifier : Modifier):
	var build = duplicate(true)
	build.apply(modifier)
	return build
