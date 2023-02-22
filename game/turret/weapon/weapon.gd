extends Behaviour
class_name Weapon
@export var sprite : Texture = load("res://game/turret/weapon/default_weapon/default_weapon_turret.png")
@export var flip_mode : SpriteFlipper.FlipMode = SpriteFlipper.FlipMode.NONE
@export var ammunition_slot_count : int
@export var accessory_slot_count : int
const item_slot = preload("res://game/item/slot/item_slot.tscn")
var ammunition_slots = []
var ammunition = []
var accessory_slots = []
var accessory = []


func _update():
	super._update()
	_update_sprite()
	
	for i in range(ammunition_slot_count):
		ammunition.append(ItemStack.new())
	for i in range(accessory_slot_count):
		accessory.append(ItemStack.new())

func get_first_ammunition_slot():
	for i in ammunition_slots:
		if i.item_stack.item != null and i.item_stack.item is Ammunition:
			return i

func get_first_ammunition_stack():
	for i in ammunition:
		if i.item != null:
			return i

func get_first_ammunition():
	var first_ammunition_stack = get_first_ammunition_stack()
	if first_ammunition_stack != null:
		return first_ammunition_stack.item

func get_modifier():
	return Modifier.new().merge_array(get_all_modifiers())

func get_all_modifiers():
	var modifiers = []
	var first_ammunition = get_first_ammunition()
	if first_ammunition != null:
		modifiers.append(first_ammunition.modifier)
	for i in accessory:
		if i != null and i.item != null:
			modifiers.append(i.item.modifier)
	return modifiers

func use_ammo():
	var ammunition_stack = get_first_ammunition_stack()
	if ammunition_stack != null:
		ammunition_stack.count -= 1

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
	var build = ""
	if ammunition_slot_count != 0:
		build += RichTextBuilder.property_text(tr("AMMUNITION") + " " + tr("SLOT_COUNT"),RichTextBuilder.color_text(str(ammunition_slot_count), Palette.yellow))
	if accessory_slot_count != 0:
		build += RichTextBuilder.property_text(tr("ACCESSORY") + " " + tr("SLOT_COUNT"),
				RichTextBuilder.color_text(str(accessory_slot_count), Palette.yellow))
	return build

func set_weapon_slot(weapon_slot):
	ammunition_slots = []
	set_modifier_slots(
			weapon_slot, ammunition_slot_count, Item.Type.AMMUNITION,
			ammunition, ammunition_slots, update_ammunition_slots)
	accessory_slots = []
	set_modifier_slots(
			weapon_slot, accessory_slot_count, Item.Type.ACCESSORY,
			accessory, accessory_slots, update_accessory_slots)
	

func set_modifier_slots(weapon_slot, count, accept_type, array, slot_array, update_callable):
	var container = node.get_tree().get_first_node_in_group("turret_item_slot_container")
	for i in range(count):
		var instantiated = item_slot.instantiate()
		container.add_child(instantiated)
		instantiated.accept_type = accept_type
		slot_array.append(instantiated)
		slot_array[i].item_stack = array[i]
		instantiated.changed.connect(update_callable)
		weapon_slot.dependencies.append(instantiated)

func update_ammunition_slots():
	for i in range(ammunition_slot_count):
		ammunition[i] = ammunition_slots[i].item_stack

func update_accessory_slots():
	for i in range(accessory_slot_count):
		accessory[i] = accessory_slots[i].item_stack
