extends Node

@export var sales : SaleGroup
const reroll_price = 10


func _ready():
	reroll()

func reroll():
	for i in get_children():
		i.set_sale(sales.pick(%WaveCount.progress()))

func reroll_with_price():
	if %Gold.gold >= reroll_price:
		%Gold.gold -= reroll_price
		reroll()

