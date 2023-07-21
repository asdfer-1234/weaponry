extends Node2D
class_name Turret

# Default weapon
const default_weapon := preload("res://game/weapon/default_weapon/default_weapon.tres")

# Player building and selection
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

# Items
var weapon_item : WeaponItem
var accessory_item : AccessoryItem
var ammunition_item : AmmunitionItem


var weapon_slot : ItemSlot:
	set(value):
		weapon_slot = value

var weapon_stack : ItemStack:
	set(value):
		weapon_stack = value
		if weapon_stack == null:
			default_weapon.update(self)
		get_tree().get_first_node_in_group("turret_selection").update_slot_container()
		update_modified_weapon()

var modifier_stack : Array[ItemStack]
var temporary_modifiers : Array[Modifier]

var product_weapon : Weapon

const normal_outline = preload("res://graphics/background_outline.tres")
const highlight_outline = preload("res://graphics/red_outline.tres")
const select_outline = preload("res://graphics/green_outline.tres")
const inventory_slot = preload("res://game/item/slot/weapon_slot.tscn")

const sell_price = 5

signal mouse_enter(turret)
signal mouse_exit(turret)
signal button_press(turret)

# modifying the weapons

## The target function that needs to be called every change at the items

func update_modified_weapon():
	product_weapon = weapon.applied(get_modifier())
	modified_weapon.update(node)

func set_turret_slots():
	weapon_slot = inventory_slot.instantiate()
	
	var container = get_tree().get_first_node_in_group("turret_item_slot_container")
	for i in container.get_children():
		i.queue_free()
	
	container.add_child(weapon_slot)
	
	weapon_slot.accept_type = Item.Type.WEAPON
	weapon_slot.item_stack = weapon_stack
	weapon_slot.changed.connect(update_weapon_stack)
	if weapon_stack != null and weapon_stack.item != null:
		weapon_stack.item.weapon.set_weapon_slots()

func update_weapon_stack():
	if weapon_slot.item_stack.item is WeaponItem:
		weapon_stack = weapon_slot.item_stack
	else:
		weapon_stack = null
	get_modifiable_weapon()

# make the weapons work here

func _ready():
	_connect_turret_mouse_selection()
	update_modified_weapon()

func _process(delta):
	time_since_draw_weapon_details += delta
	if draw_weapon_details:
		queue_redraw()

func _physics_process(delta):
	if not Engine.is_editor_hint() and not building:
		get_modified_weapon()._process(delta)

# mouse
func _mouse_enter():
	if not building:
		mouse_enter.emit(self)

func _mouse_exit():
	if not building:
		mouse_exit.emit(self)

func _button_press():
	if not building:
		button_press.emit(self)

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

func _connect_turret_mouse_selection():
	var turret_selection = get_tree().get_nodes_in_group("turret_selection")[0]
	mouse_enter.connect(turret_selection.mouse_enter)
	mouse_exit.connect(turret_selection.mouse_exit)
	button_press.connect(turret_selection.button_press)

# information drawing

func _draw():
	if get_modified_weapon().node != null && draw_weapon_details:
		get_modified_weapon()._draw()

func tooltip():
	return get_modified_weapon().tooltip()

func add_temporary_modifier(modifier):
	temporary_modifiers.append(modifier)

func remove_temporary_modifier(modifier):
	temporary_modifiers.erase(modifier)

# selling

func sell():
	$"../%Builder".placed_turret -= 1
	$"../%Gold".gold += $"../%Builder".placed_turret * sell_price
	queue_free()
