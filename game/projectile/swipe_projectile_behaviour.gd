extends ProjectileBehaviour
class_name SwipeProjectileBehaviour
@export var arc : float = 100.0
const swipe_projectile = preload("res://game/projectile/swipe_projectile.tscn")

func get_default_projectile():
	return swipe_projectile



func _update():
	super._update()
	node.rotate(-deg_to_rad(arc) / 2)
	var tween = node.get_tree().create_tween()
	tween.tween_property(node, "rotation", node.rotation + deg_to_rad(arc), lifetime)

func tooltip():
	return RichTextBuilder.property_text(tr("ARC"), RichTextBuilder.color_text(str(arc), Palette.yellow)) + super.tooltip()
