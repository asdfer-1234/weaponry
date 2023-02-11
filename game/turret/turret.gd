extends Node2D
class_name Turret
var default_weapon = preload("res://game/turret/weapon/default_weapon/default_weapon.tres")
var building : bool = false

var highlighted = false:
	set(value):
		highlighted = value
		update_mouse()
var selected = false:
	set(value):
		selected = value
		update_mouse()

var draw_weapon_details = false:
	set(value):
		if value != draw_weapon_details:
			time_since_draw_weapon_details = 0
		draw_weapon_details = value
		queue_redraw()

var time_since_draw_weapon_details : float = 0

var weapon_slot : ItemSlot
var weapon_stack : ItemStack:
	get:
		return m_weapon_stack
	set(value):
		m_weapon_stack = value
		if m_weapon_stack == null:
			default_weapon.update(self)
			
		elif m_weapon_stack.item is WeaponItem:
			m_weapon_stack.item.weapon = m_weapon_stack.item.weapon.duplicate()
			m_weapon_stack.item.weapon.update(self)
		queue_redraw()
		get_tree().get_first_node_in_group("turret_selection").update_slot_container()
		
		
var m_weapon_stack : ItemStack

const normal_outline = preload("res://graphics/background_outline.tres")
const highlight_outline = preload("res://graphics/red_outline.tres")
const select_outline = preload("res://graphics/green_outline.tres")
const inventory_slot = preload("res://game/item/slot/item_slot.tscn")

signal mouse_enter(turret)
signal mouse_exit(turret)
signal button_press(turret)

# Getting the Weapons

func get_active_weapon() -> Weapon:
	if weapon_stack == null or weapon_stack.item == null or weapon_stack.item.weapon == null:
		return default_weapon
	return weapon_stack.item.weapon

func duplicate_default_weapon():
	default_weapon = default_weapon.duplicate()
	default_weapon.update(self)

# processing the weapons

func _ready():
	duplicate_default_weapon()
	_connect_turret_selection()

func set_weapon_slot():
	weapon_slot = inventory_slot.instantiate()
	get_tree().get_first_node_in_group("turret_item_slot_container").add_child(weapon_slot)
	
	weapon_slot.accept_type = Item.Type.WEAPON
	weapon_slot.item_stack = weapon_stack
	get_active_weapon().set_weapon_slot()
	weapon_slot.changed.connect(set_weapon_stack_from_inventory_slot)
	

func set_weapon_stack_from_inventory_slot():
	if weapon_slot.item_stack.item is WeaponItem:
		weapon_stack = weapon_slot.item_stack
	else:
		weapon_stack = null

func _process(delta):
	time_since_draw_weapon_details += delta
	if draw_weapon_details:
		queue_redraw()

func _physics_process(delta):
	if not Engine.is_editor_hint() and not building:
		_turret_process(delta)

func _turret_process(delta):
	get_active_weapon()._process(delta)

# Mouse Signal Conveying
func _mouse_enter():
	if not building:
		mouse_enter.emit(self)

func _mouse_exit():
	if not building:
		mouse_exit.emit(self)

func _button_press():
	if not building:
		button_press.emit(self)

# Mouse Signal Receiving

func update_mouse():
	if selected:
		draw_weapon_details = true
		$Sprite.material = select_outline
	elif highlighted:
		draw_weapon_details = true
		$Sprite.material = highlight_outline
	else:
		draw_weapon_details = false
		$Sprite.material = normal_outline

func _connect_turret_selection():
	var turret_selection = get_tree().get_nodes_in_group("turret_selection")[0]
	mouse_enter.connect(turret_selection.mouse_enter)
	mouse_exit.connect(turret_selection.mouse_exit)
	button_press.connect(turret_selection.button_press)

# information drawing

func _draw():
	if draw_weapon_details:
		get_active_weapon()._draw()

func tooltip():
	return get_active_weapon().tooltip()
