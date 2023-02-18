extends Node
class_name Effect

@export var duration : float = 1

func _ready():
	get_tree().create_timer(duration, true, true).timeout.connect(expire)

func expire():
	queue_free()

func tooltip():
	return duration_tooltip() + "\n"

func duration_tooltip():
	return tr("FOR_DURATION").format({"duration" : RichTextBuilder.color_text(str(duration), Palette.red)})
