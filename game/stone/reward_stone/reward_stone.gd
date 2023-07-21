extends Stone

@export var reward : Sellable

func _ready():
	super._ready()
	death.connect(on_die)

func on_die():
	$"../%Inventory".give(reward.pick(0).item_stack)
