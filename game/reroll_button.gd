extends Button


func tooltip():
	return tr("REROLL_TOOLTIP") + " " + %Gold.price_tooltip(%Shop.reroll_price)


func _on_mouse_entered():
	%Tooltip.enter_tooltip(self)

func _on_mouse_exited():
	%Tooltip.exit_tooltip(self)
