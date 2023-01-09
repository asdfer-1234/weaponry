extends Node2D

var mouse_hover : bool = false setget set_mouse_hover
var show_range : bool = false setget set_show_range
var show_target_indicator : bool = false setget set_show_target_indicator

func set_mouse_hover(set):
	set_show_range(set)
	set_show_target_indicator(set)

func set_show_range(set):
	show_range = set
	update()

func set_show_target_indicator(set):
	$TargetIndicator.visible = set
	$TargetIndicator.set_process(set)

func _ready():
	set_mouse_hover(false)

func _draw():
	if show_range:
		draw_empty_circle(Vector2.ZERO, $"../Range/CollisionShape2D".shape.radius, Color(1, 0.95, 0.76), 1)


func draw_empty_circle(position : Vector2, radius : float, color : Color, thickness : float = 1):
	draw_arc(position, radius, 0, TAU, 36, color, thickness)
	pass

func _on_mouse_enter():
	set_mouse_hover(true)

func _on_mouse_exit():
	set_mouse_hover(false)
