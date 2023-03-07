extends Node
class_name Effect

@export var duration : float = 1
var timer

func _ready():
	timer = get_tree().create_timer(duration, true, true)
	timer.timeout.connect(expire)

func reload():
	timer.time_left = duration

func expire():
	queue_free()

func tooltip():
	return duration_tooltip() + "\n"

func duration_tooltip():
	return tr("FOR_DURATION").format({"duration" : RichTextBuilder.color_text(str(duration), Palette.red)})
