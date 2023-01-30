extends Node2D

var default_weapon = preload("res://game/turret/weapon/default_weapon/default_weapon.tres")
@export var weapon : Weapon : set = set_weapon
var building : bool = false
var mouse_over = false

signal mouse_enter
signal mouse_exit
signal select

func set_weapon(set):
	if set != null:
		weapon = set.duplicate()
	else:
		weapon = null
	get_active_weapon().update(self)

func get_active_weapon():
	if weapon == null:
		return default_weapon
	return weapon

func _ready():
	set_weapon(weapon)
	if not Engine.is_editor_hint():
		_connect_turret_selection()

func _connect_turret_selection():
	var turret_selection = get_tree().get_nodes_in_group("turret_selection")[0]
	mouse_enter.connect(turret_selection.mouse_enter)
	mouse_enter.connect(turret_selection.mouse_enter)
	mouse_exit.connect(turret_selection.mouse_exit)
	select.connect(turret_selection.select)

func _process(_delta):
	if not Engine.is_editor_hint() and mouse_over and Input.is_action_pressed("select_turret"):
		emit_signal("select", self)

func _physics_process(delta):
	if not Engine.is_editor_hint() and not building:
		_turret_process(delta)

func _turret_process(delta):
	get_active_weapon()._process(delta)

func _mouse_enter():
	mouse_over = true
	emit_signal("mouse_enter", self)

func _mouse_exit():
	mouse_over = false
	emit_signal("mouse_exit", self)
