extends GameGlobalVariable

var wave : int:
	get:
		return value
	set(set_value):
		value = set_value
@export var waves : Waves


func _update_text():
	text = RichTextBuilder.right(minimal_tooltip())

func minimal_tooltip():
	return super.minimal_tooltip() + RichTextBuilder.color_text("/" + str(len(waves.waves)), Palette.yellow)

func current_wave():
	return waves.waves[wave]

func progress():
	return wave / len(waves.waves)
