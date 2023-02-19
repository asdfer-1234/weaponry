extends InventorySlot
class_name SaleSlot

@export var price : int:
	set(value):
		price = value
		call_deferred("update_price_text")
var sold = false

func _ready():
	super._ready()
	price = price

func update_price_text():
	$PriceLabel.text = %Gold.minimal_price_tooltip(price)

func primary(other):
	if not sold and other.item_stack.empty and %Gold.gold >= price:
		buy()

func buy():
	%Gold.gold -= price
	cursor.item_stack = item_stack
	sold = true
	item_stack = null

func tooltip():
	if item_stack == null or item_stack.item == null:
		return ""
	return item_stack.item.tooltip()
