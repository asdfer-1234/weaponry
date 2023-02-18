extends Resource
class_name Boost

@export var multiplier : float = 1
@export var adder : float = 0

func additive_multiplier():
	return multiplier - 1

func minimal_tooltip():
	return multiplier_tooltip() + adder_tooltip()

func multiplier_tooltip():
	if multiplier == 1:
		return ""
	
	
	if multiplier > 1:
		return RichTextBuilder.color_text(percent_multiplier(), Palette.green)
	if multiplier < 1:
		return RichTextBuilder.color_text(percent_multiplier(), Palette.red)

func adder_tooltip():
	if adder == 0:
		return ""
	
	if adder > 0:
		return RichTextBuilder.color_text(signed_numeric(adder), Palette.green)
	if adder < 0:
		return RichTextBuilder.color_text(signed_numeric(adder), Palette.red)

func percent_multiplier():
	return signed_numeric(additive_multiplier() * 100) + "%"

func signed_numeric(value):
	if value > 0:
		return "+" + str(value)
	return str(value)

func add_other(other):
	adder += other.adder
	multiplier += other.multiplier - 1

func apply(value):
	return value * multiplier + adder


func __init(multiplier = 1, adder = 0):
	self.multiplier = multiplier
	self.adder = adder
	
