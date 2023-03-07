extends InventorySlot
class_name TrashSlot


func primary(other):
	trash_all(other)

func secondary(other):
	trash_one(other)


func trash_all(other):
	other.item_stack.count = 0

func trash_one(other):
	other.item_stack.count -= 1

func tooltip():
	return RichTextBuilder.color_text(tr("TRASH_SLOT"), Palette.red) + "\n" + RichTextBuilder.color_text(tr("TRASH_SLOT_DESCRIPTION"), Palette.secondary)
