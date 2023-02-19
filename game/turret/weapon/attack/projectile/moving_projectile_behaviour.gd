extends ProjectileBehaviour
class_name MovingProjectileBehaviour

@export var shader : ShaderMaterial
@export var sprite : Texture
@export var speed : float = 500
@export var acceleration : float = 0
@export var randomly_rotate : bool = false

func _update():
	super._update()
	node.get_node("Sprite2D").texture = sprite
	node.get_node("Sprite2D").material = shader
	if randomly_rotate:
		node.get_node("Sprite2D").rotation = randf_range(0, TAU)


func _process(delta):
	node.translate(Vector2(speed, 0).rotated(node.rotation) * delta)
	speed += acceleration * delta
	if speed < 0:
		speed = 0

func tooltip():
	return super.tooltip() + \
			RichTextBuilder.property_text(tr("PROJECTILE_SPEED"), 
			RichTextBuilder.color_text(str(speed), 
			Palette.green))
