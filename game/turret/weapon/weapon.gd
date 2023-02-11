extends Behaviour
class_name Weapon
@export var sprite : Texture = load("res://game/turret/weapon/default_weapon/default_weapon_turret.png")
@export var slotCount = 0
@export var flip_mode : SpriteFlipper.FlipMode = SpriteFlipper.FlipMode.NONE
@export var ammunition_slot_count : int
const item_slot = preload("res://game/item/slot/item_slot.tscn")
var ammunition_slots = []
var ammunition = []


func _update():
	super._update()
	_update_sprite()
	
	for i in range(ammunition_slot_count):
		ammunition.append(ItemStack.new())

func get_first_ammunition_slot():
	for i in ammunition_slots:
		if i.item_stack.item != null and i.item_stack.item is Ammunition:
			return i

func get_first_ammunition():
	var slot = get_first_ammunition_slot()
	if slot == null:
		return
	return slot.item_stack.item

func get_damage_multiplier():
	var first_ammunition = get_first_ammunition()
	if first_ammunition != null:
		return first_ammunition.damage_multiplier
	return 1

func use_ammo():
	var slot = get_first_ammunition_slot()
	if slot != null:
		slot.item_stack.count -= 1

func _update_sprite():
	if node.has_node("Sprite"):
		node.get_node("Sprite").texture = sprite
		node.get_node("Sprite").flip_mode = flip_mode

func _select():
	pass

func _mouse_enter():
	pass

func _mouse_exit():
	pass

func tooltip():
	pass

func set_weapon_slot():
	var container = node.get_tree().get_first_node_in_group("turret_item_slot_container")
	ammunition_slots = []
	for i in range(ammunition_slot_count):
		var instantiated = item_slot.instantiate()
		instantiated.accept_type = Item.Type.AMMUNITION
		container.add_child(instantiated)
		ammunition_slots.append(instantiated)
		instantiated.item_stack = ammunition[i]
	for i in ammunition_slots:
		i.changed.connect(update_ammunition_slots)

func update_ammunition_slots():
	for i in range(ammunition_slot_count):
		ammunition[i] = ammunition_slots[i].item_stack
