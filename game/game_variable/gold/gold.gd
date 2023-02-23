extends GameGlobalVariable

var gold:
	get:
		return value
	set(set_value):
		value = set_value


func price_tooltip(value):
	return RichTextBuilder.property_text(tr("PRICE"), minimal_price_tooltip(value))

func minimal_price_tooltip(value):
	if value == 0:
		return RichTextBuilder.color_text(tr("FREE"), Palette.green)
	return colored_minimal_value_tooltip(value)

func numeric_minimal_price_tooltip(value):
	if value == 0:
		return RichTextBuilder.color_text(tr("NUMERIC_FREE"), Palette.green)
	return colored_minimal_value_tooltip(value)

func colored_minimal_value_tooltip(value):
	var color = Palette.green
	if value > gold:
		color = Palette.red
	return minimal_value_tooltip(value, color)
