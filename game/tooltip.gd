extends Control



@onready var label : RichTextLabel = $MarginContainer/RichTextLabel

const topleft_position = Vector2(-3, -3)
const topright_position = Vector2(3, -3)
const bottomleft_position = Vector2(-3, 3)
const bottomright_position = Vector2(19, 3)

var text:
	set(value):
		text = value
		label.text = text
		label.queue_redraw()
		update_tooltip_size()

var hold = null


func _ready():
	visible = false

func enter_tooltip(node):
	hold = node
	reload_tooltip()
	visible = true
	hold.changed.connect(reload_tooltip)

func exit_tooltip(node):
	if hold.changed.is_connected(reload_tooltip):
		hold.changed.disconnect(reload_tooltip)
	if hold == node:
		visible = false
		hold = null
	

func reload_tooltip():
	text = hold.tooltip()

func _process(_delta):
	update_tooltip_size()
	var end_position = get_parent().global_position + size
	var viewport_size = get_viewport_rect().size
	var x_overflow = end_position.x > viewport_size.x
	var y_overflow = end_position.y > viewport_size.y
	if x_overflow:
		position.x = -size.x
	else:
		position.x = 0
	if y_overflow:
		position.y = -size.y
	else:
		position.y = 0
	
	if x_overflow:
		if y_overflow:
			position += topleft_position
		else:
			position += bottomleft_position
	else:
		if y_overflow:
			position += topright_position
		else:
			position += bottomright_position

func update_tooltip_size():
	if label != null and label.text != "":
		var text_size = label.get_theme_font("normal_font").get_multiline_string_size(label.get_parsed_text(), 0, 100000, label.get_theme_font_size("normal_font_size"))
		var line_separation = label.theme.get_constant("line_separation", "RichTextLabel")
		text_size.y += (label.get_visible_line_count() - 1) * line_separation
		size = text_size + Vector2.ONE * 6
