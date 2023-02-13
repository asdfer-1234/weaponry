extends ProjectileBehaviour
class_name MovingProjectileBehaviour

@export var sprite : Texture
@export var speed : float = 200

func _update():
	node.get_node("Sprite2D").texture = sprite


func _process(delta):
	node.translate(Vector2(speed, 0).rotated(node.rotation) * delta)
	pass

func tooltip():
	return super.tooltip() + \
			RichTextBuilder.property_text(tr("PROJECTILE_SPEED"), 
					RichTextBuilder.color_text(str(speed), 
							Palette.green))
