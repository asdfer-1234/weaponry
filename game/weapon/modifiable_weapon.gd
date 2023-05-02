extends Resource
class_name ModifiableWeapon

@export var weapon : Weapon
@export var ammunition_slot_count : int
@export var accessory_slot_count : int
const item_slot = preload("res://game/item/slot/item_slot.tscn")
var ammunition : Array[ItemStack] = []
var accessory : Array[ItemStack] = []
var modified_weapon

func _update():
	for i in range(ammunition_slot_count):
		ammunition.append(ItemStack.new())
	for i in range(accessory_slot_count):
		accessory.append(ItemStack.new())

func set_weapon_slots():
	var container = Global.get_tree().get_first_node_in_group("turret_item_slot_container")
	for i in ammunition:
		var slot = _add_slot(container, Item.Type.AMMUNITION)
		slot.item_stack = i
	for i in accessory:
		var slot = _add_slot(container, Item.Type.ACCESSORY)
		slot.item_stack = i

func _add_slot(container, item_type = Item.Type.NONE) -> ItemSlot:
	var instantiated = item_slot.instantiate()
	instantiated.item_type = Item.Type.AMMUNITION
	container.add_child(instantiated)
	return instantiated

func get_modifier():
	var modifier = Modifier.new()
	for i in ammunition:
		modifier.add(i.item.modifier)
	for i in accessory:
		modifier.add(i.item.modifier)
	return modifier

func update_modified_weapon():
	var base = weapon.duplicate()
	base.apply(get_modifier())
	modified_weapon = base
