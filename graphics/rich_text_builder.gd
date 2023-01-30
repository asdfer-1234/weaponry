extends Node


func color_text(original, color):
	return _color_tag(color) + original + _end_tag("color")

func _color_tag(color):
	return _property_tag("color", color.to_html(false))

func _surround_tag(original):
	return "[" + original + "]"

func _property_tag(property, value):
	return _surround_tag(property + "=" + value)

func _end_tag(property):
	return _surround_tag("/" + property)
