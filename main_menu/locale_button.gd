extends TextureButton

@export var locale : String

const outline = preload("res://graphics/foreground_outline.tres")

func _ready():
	if TranslationServer.get_locale() == locale:
		material = outline 

func _on_pressed():
	TranslationServer.set_locale(locale)
	get_tree().get_first_node_in_group("scene_manager").reload_scene()
