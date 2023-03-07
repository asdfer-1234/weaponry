extends Control

const min_fall = 5
const max_fall = 20
const direction = 30

func _ready():
	_animate_fall()

func _animate_fall():
	var tween = get_tree().create_tween()
	var target_position = \
			Vector2($RichTextLabel.position.x + randf_range(-direction, direction),
			$RichTextLabel.position.y + randf_range(min_fall, max_fall))
	
	tween.tween_property($RichTextLabel, "position:y", target_position.y, 0.5)\
			.set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.parallel()\
			.tween_property($RichTextLabel, "position:x", target_position.x, 0.5)\
			.set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)


func set_damage(damage : Damage):
	$RichTextLabel.text = "\n" + RichTextBuilder.center(damage.minimal_tooltip())
