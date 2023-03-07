extends Stone

@export var reward : Sellable


func on_die():
	super.on_die()
	$"../%Inventory".give(reward.pick(0).item_stack)
