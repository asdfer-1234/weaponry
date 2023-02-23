extends Node

@export var sales : SaleGroup

func _ready():
	reroll()

func reroll():
	for i in get_children():
		i.set_sale(sales.pick(0))
