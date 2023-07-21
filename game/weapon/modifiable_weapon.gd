extends Behaviour
class_name ModifiableWeapon

@export var weapon : Weapon
@export var ammunition_slot_count : int
@export var accessory_slot_count : int
const item_slot = preload("res://game/item/slot/item_slot.tscn")

func setup_items():
	for i in range(ammunition_slot_count + accessory_slot_count):
		modifier_item_stacks.append(ItemStack.new())

func set_weapon_slots():
	var container = Global.get_tree().get_first_node_in_group("turret_item_slot_container")
	modifier_item_slots = []
	for i in range(len(modifier_item_stacks)):
		var item_type : Item.Type
		if i < ammunition_slot_count:
			item_type = Item.Type.AMMUNITION
		else:
			item_type = Item.Type.ACCESSORY
		var slot = _add_slot(container, modifier_item_stacks[i], item_type)
		modifier_item_slots.append(slot)

func _add_slot(container, item_stack = null, item_type = Item.Type.NONE) -> ItemSlot:
	var instantiated = item_slot.instantiate()
	instantiated.accept_type = item_type
	container.add_child(instantiated)
	instantiated.item_stack = item_stack
	instantiated.changed.connect(slot_to_stack)
	return instantiated

# The another target function that needs to be called whenever the item slots change
func slot_to_stack():
	var stack_change_effective = false
	for i in range(len(modifier_item_slots)):
		if modifier_item_slots[i].item_stack.empty():
			if modifier_item_stacks[i] != null and not modifier_item_stacks[i].empty():
				stack_change_effective = true
			modifier_item_stacks[i] = null
		else:
			if modifier_item_stacks[i] == null or modifier_item_stacks[i].empty():
				stack_change_effective = true
			elif modifier_item_slots[i].item_stack.item != modifier_item_stacks[i].item:
				stack_change_effective = true
			modifier_item_stacks[i] = modifier_item_slots[i].item_stack
	if stack_change_effective:
		update_modified_weapon()

func get_modifier():
	var modifier = Modifier.new()
	for i in _list_modifiers():
		if i != null:
			modifier.add(i)
	return modifier


func _list_modifiers():
	var modifiers = []
	for i in modifier_item_stacks:
		if i != null and not i.empty():
			modifiers.append(i.item.modifier)
	return modifiers



func tooltip():
	var build = ""
	build += RichTextBuilder.property_text("AMMUNITION_SLOT_COUNT", str(ammunition_slot_count))
	build += RichTextBuilder.property_text("ACCESSORY_SLOT_COUNT", str(accessory_slot_count))
	if weapon != null:
		build += weapon.tooltip()
	return build

func _update():
	super._update()
	update_modified_weapon()

func use_ammo():
	for i in modifier_item_stacks:
		if i != null and i.item is StackableItem:
			i.count -= 1
			return
