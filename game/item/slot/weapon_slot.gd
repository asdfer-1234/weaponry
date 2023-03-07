extends ItemSlot
class_name WeaponSlot

@export var dependencies = []


func item_acceptable(other):
	return super.item_acceptable(other) and dependencies_clear()

func dependencies_clear():
	for i in dependencies:
		if not i.item_stack.empty:
			return false
	return true

func tooltip():
	if not dependencies_clear():
		return RichTextBuilder.color_text(
			tr("WEAPON_SLOT_DEPENDENCIES_NOT_CLEAR"), Palette.red) + \
			"\n" + \
			super.tooltip()
	return super.tooltip()
