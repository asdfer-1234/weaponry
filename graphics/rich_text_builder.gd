extends Node


func color_text(original, color):
	return _color_tag(color) + str(original) + _end_tag("color")

func property_text(property, value):
	if value == "":
		return ""
	return property + ":" + value + "\n"

func indent(value):
	return _surround_tag("indent") + value + _end_tag("indent")

func right(value):
	return _surround_tag("right") + str(value) + _end_tag("right")

func image(path):
	return _surround_tag("img") + path + _end_tag("img")

func subproperty(head, value):
	return head + "\n" + indent(value)

func _color_tag(color):
	return _property_tag("color", color.to_html(false))

func _surround_tag(original):
	return "[" + original + "]"

func _property_tag(property, value):
	return _surround_tag(property + "=" + value)

func _end_tag(property):
	return _surround_tag("/" + property)

func multiplier(value):
	return str(value * 100) + "%"

func multiplier_text(value):
	if value == 0:
		return ""
	var text = multiplier(value)
	if value > 0:
		text = color_text(text, Palette.green)
	else:
		text = color_text(text, Palette.red)
	return text

