extends ProjectileBehaviour
class_name Explosion

const explosion_time = 0.1
const default_explosion_projectile = preload("res://game/explosion/explosion.tscn")
const explosion_audio = preload("res://game/explosion/noise_explosion.wav")

var timer


func get_default_projectile():
	return default_explosion_projectile


func _update():
	node.get_node("AnimationPlayer").animation_finished.connect(_on_animation_finish)
	timer = node.get_tree().create_timer(explosion_time)
	timer.timeout.connect(_end_explosion)
	Audio.play_audio(explosion_audio)
	node.queue_redraw()
	node.rotate(randf_range(0, TAU))

func _process(delta):
	super._process(delta)
	node.queue_redraw()

func _end_explosion():
	hit = true

func _on_animation_finish(_string):
	_finish_explosion()

func _finish_explosion():
	node.queue_free()

func _draw():
	draw_empty_circle(Vector2.ZERO, 16 * ease(animation_progress(), 0.4), Palette.foreground, 1 / size)
	
func draw_empty_circle(position : Vector2, radius : float, color : Color, thickness : float = 1):
	node.draw_arc(position, radius, 0, TAU, 36, color, thickness)

func animation_progress():
	var animation_player = node.get_node("AnimationPlayer")
	return animation_player.current_animation_position / animation_player.current_animation_length

func tooltip():
	var text = super.tooltip()
	text += RichTextBuilder.property_text("RADIUS", size)
	return text
