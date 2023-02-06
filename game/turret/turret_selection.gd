extends Control

var show = false
var mouse_turret : Turret:
	set(value):
		if mouse_turret != null:
			mouse_turret.highlighted = false
		mouse_turret = value
		if mouse_turret != null:
			mouse_turret.highlighted = true
var select_turret : Turret:
	set(value):
		if select_turret != null:
			select_turret.selected = false
		select_turret = value
		if select_turret != null:
			select_turret.selected = true
		
		
		var container = get_tree().get_first_node_in_group("turret_item_slot_container")
		for i in container.get_children():
			i.queue_free()
		if select_turret != null:
			select_turret.set_weapon_slot()
		
		
var building = false
@onready var builder = $"../../CursorCanvas/CursorFollower/Builder"

func mouse_enter(turret):
	mouse_turret = turret
	update_selection()

func mouse_exit(turret):
	if turret == mouse_turret:
		mouse_turret = null

func button_press(turret):
	select_turret = turret

func update_selection():
	if building:
		select_turret = builder.hold
		follow_turret()
	queue_redraw()


func follow_turret():
	global_position = select_turret.global_position

func start_build():
	select_turret = builder.hold
	building = true

func end_build():
	select_turret = null
	building = false

func _input(event):
	if event.is_action_pressed("deselect_turret"):
		select_turret = null
