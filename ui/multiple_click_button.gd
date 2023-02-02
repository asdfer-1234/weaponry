extends Button
class_name MultipleClickButton

signal left_pressed
signal right_pressed


func _ready():
	gui_input.connect(_on_gui_input)

func _on_gui_input(event):
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				left_pressed.emit()
			MOUSE_BUTTON_RIGHT:
				right_pressed.emit()
