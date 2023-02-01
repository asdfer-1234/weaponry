extends Control

var show = false
var mouse_turret : Node
var turret : Node
var building = false
@onready var builder = $"../../CursorFollower/Builder"

func mouse_enter(turret):
	mouse_turret = turret
	update_selection()
	follow_turret()

func mouse_exit(turret):
	if mouse_turret == turret:
		mouse_turret = null

func select(_turret):
	print("select")

func _process(_delta):
	#update_selection()
	pass

func update_selection():
	if building:
		turret = builder.hold
		follow_turret()
	else:
		turret = mouse_turret
	queue_redraw()

func follow_turret():
	global_position = turret.global_position

func _draw():
	if turret != null:
		draw_range()

func draw_range():
	#draw_empty_circle(Vector2.ZERO, turret.get_node("Range/CollisionShape2D").shape.radius, Color(1, 0.95, 0.76))
	pass

func draw_empty_circle(center : Vector2, radius : float, color : Color, thickness : float = 1):
	draw_arc(center, radius, 0, TAU, 36, color, thickness)


func start_build():
	turret = builder.hold
	building = true


func end_build():
	turret = null
	building = false
