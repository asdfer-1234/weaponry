extends Control


@onready var turret_selection = $"../../../../TurretSelection"

func tooltip():
	if turret_selection.sellable():
		return ""
	return RichTextBuilder.color_text(tr("TURRET_SELL_DEPENDENCIES_NOT_CLEAR"), Palette.red)


func _on_mouse_entered():
	%Tooltip.enter_tooltip(self)


func _on_mouse_exited():
	%Tooltip.exit_tooltip(self)
