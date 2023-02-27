extends Node

const defeat_title = "DEFEAT_TITLE"
const victory_title = "VICTORY_TITLE"
var game_over = false

func defeat():
	%Title.text = tr(defeat_title)
	%Title.add_theme_color_override("font_color", Palette.red)
	enable()

func victory():
	%Title.text = tr(victory_title)
	%Title.add_theme_color_override("font_color", Palette.green)
	enable()

func enable():
	game_over = true
	$GameEndEnable.visible = true
	set_text()
	$"../%Map".end()

func set_text():
	%Wave.text = $"../%WaveCount".minimal_tooltip()
	%Health.text = $"../%Health".minimal_tooltip()
