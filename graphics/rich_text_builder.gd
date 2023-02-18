extends Node


func color_text(value, color):
	if value == "":
		return ""
	return _color_tag(color) + value + _end_tag("color")

func property_text(property : String, value : String):
	if value == "":
		return ""
	return property + ":" + value + "\n"

func indent(value):
	if value == "":
		return ""
	return _surround_tag(value, "indent")

func right(value):
	if value == "":
		return ""
	return _surround_tag(value, "right")

func center(value):
	if value == "":
		return ""
	return _surround_tag(value, "center")

func image(path):
	return _surround_tag(path, "img")

func subproperty(head, value):
	return head + "\n" + indent(value)

func _color_tag(color):
	return _property_tag("color", color.to_html(false))

func _surround_tag(original, tag):
	return _surround_bracket(tag) + original + _end_tag(tag)

func _surround_bracket(original):
	return "[" + original + "]"

func _property_tag(property, value):
	return _surround_bracket(property + "=" + value)

func _end_tag(property):
	return _surround_bracket("/" + property)

func multiplier(value):
	if value == 1:
		return ""
	return str(value * 100) + "%"

func multiplier_text(value):
	if value == 0:
		return ""
	var text = multiplier(value)
	if value > 1:
		text = color_text(text, Palette.green)
	else:
		text = color_text(text, Palette.red)
	return text
