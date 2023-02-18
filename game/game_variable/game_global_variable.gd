extends RichTextLabel
class_name GameGlobalVariable

@export var value : int:
	set(set_value):
		value = set_value
		_update_text()
		changed.emit()
@export var icon : Texture
@export var color : Color

signal changed

func _ready():
	value = value

func _update_text():
	text = minimal_tooltip()

func minimal_tooltip():
	return minimal_value_tooltip(value)

func minimal_value_tooltip(custom_value, custom_color = null):
	var build = ""
	if icon != null:
		build += RichTextBuilder.image(icon.resource_path)
	var apply_color = color
	if custom_color != null:
		apply_color = custom_color
	build += RichTextBuilder.color_text(str(custom_value), apply_color)
	return build
