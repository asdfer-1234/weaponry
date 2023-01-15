#tool
extends Node2D

export(Resource) var weapon_resource setget set_weapon, get_weapon_resource
const default_weapon : Weapon = preload("res://game/turret/weapon/default_weapon/default_weapon.tres")
var weapon : Weapon setget set_weapon
var building : bool = false
var mouse_over = false

signal mouse_enter
signal mouse_exit
signal select

func set_weapon(set):
	weapon = set
	weapon_resource = set
	get_active_weapon().update(self)

func get_weapon_resource():
	return weapon

func get_active_weapon():
	if weapon == null:
		return default_weapon
	return weapon

func _ready():
	set_weapon(weapon_resource)
	var turret_selection = get_tree().get_nodes_in_group("turret_selection")[0]
	if not Engine.editor_hint:
		connect("mouse_enter", turret_selection, "mouse_enter", [self])
		connect("mouse_exit", turret_selection, "mouse_exit", [self])
		connect("select", turret_selection, "select", [self])

func _process(_delta):
	if not Engine.editor_hint and mouse_over and Input.is_action_pressed("select_turret"):
		emit_signal("select")

func _physics_process(delta : float):
	if not Engine.editor_hint and not building:
		turret_process(delta)

func turret_process(delta : float):
	get_active_weapon().process(self, delta)




func _mouse_enter():
	print("_mouse_enter")
	mouse_over = true
	emit_signal("mouse_enter")

func _mouse_exit():
	print("_mouse_exit")
	mouse_over = false
	emit_signal("mouse_exit")

