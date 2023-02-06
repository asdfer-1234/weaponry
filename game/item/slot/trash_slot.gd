extends InventorySlot
class_name TrashSlot


func _primary_pressed():
	trash_all(cursor)

func _secondary_pressed():
	trash_one(cursor)


func trash_all(other):
	other.item_stack.count = 0

func trash_one(other):
	other.item_stack.count -= 1

