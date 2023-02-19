extends Button

signal changed

func _ready():
	%Gold.changed.connect(_emit_changed)

func _emit_changed():
	changed.emit()

func tooltip():
	return %Gold.price_tooltip(%Builder.price())


func _on_mouse_entered():
	%Tooltip.enter_tooltip(self)


func _on_mouse_exited():
	%Tooltip.exit_tooltip(self)
