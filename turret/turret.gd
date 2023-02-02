extends Node2D

var default_weapon = preload("res://game/turret/weapon/default_weapon/default_weapon.tres")
@export var weapon : Weapon : set = set_weapon
var building : bool = false
var mouse_over = false

signal mouse_enter
signal mouse_exit
signal select

# Getting the Weapons

func set_weapon(value):
	if value != null:
		weapon = value.duplicate()
	else:
		weapon = null
	get_active_weapon().update(self)

func get_active_weapon():
	if weapon == null:
		return default_weapon
	return weapon

func duplicate_default_weapon():
	default_weapon = default_weapon.duplicate()

# processing the weapons

func _ready():
	duplicate_default_weapon()
	set_weapon(weapon)
	if not Engine.is_editor_hint():
		_connect_turret_selection()

func _physics_process(delta):
	if not Engine.is_editor_hint() and not building:
		_turret_process(delta)

func _turret_process(delta):
	get_active_weapon()._process(delta)

# Mouse Selection

func _mouse_enter():
	mouse_over = true
	emit_signal("mouse_enter", self)
	get_tree().get_nodes_in_group("tooltip")[0].text = tooltip()
	queue_redraw()

func _mouse_exit():
	mouse_over = false
	emit_signal("mouse_exit", self)
	queue_redraw()

func _connect_turret_selection():
	var turret_selection = get_tree().get_nodes_in_group("turret_selection")[0]
	mouse_enter.connect(turret_selection.mouse_enter)
	mouse_enter.connect(turret_selection.mouse_enter)
	mouse_exit.connect(turret_selection.mouse_exit)
	select.connect(turret_selection.select)

# information drawing

func _draw():
	if mouse_over:
		get_active_weapon()._draw()

func tooltip():
	return get_active_weapon().tooltip()
