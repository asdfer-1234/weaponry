extends Control


func set_damage(damage : Damage):
	$RichTextLabel.text = "\n" + RichTextBuilder.right(damage.minimal_tooltip())


func _on_animation_finished(_anim_name):
	queue_free()
