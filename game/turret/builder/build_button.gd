extends Button

func tooltip():
	return %Gold.price_tooltip(%Builder.price())


func _on_mouse_entered():
	%Tooltip.enter_tooltip(self)


func _on_mouse_exited():
	%Tooltip.exit_tooltip(self)
