extends InventorySlot
class_name SaleSlot

@export var price : int:
	set(value):
		price = value
		update_price_text()

func _ready():
	super._ready()
	%Gold.changed.connect(update_price_text)
	price = price

func update_price_text():
	if item_stack.empty:
		$PriceLabel.text = RichTextBuilder.color_text(tr("SOLD_OUT"), Palette.secondary)
	else:
		$PriceLabel.text = %Gold.numeric_minimal_price_tooltip(price)

func primary(other):
	if not item_stack.empty and other.item_stack.empty and %Gold.gold >= price:
		buy()

func buy():
	%Gold.gold -= price
	cursor.item_stack = item_stack
	item_stack = null
	update_price_text()

func tooltip():
	if item_stack == null or item_stack.item == null:
		return ""
	return item_stack.item.tooltip()

func set_sale(sale : Sale):
	item_stack = sale.item_stack.duplicate()
	if not(item_stack.item is StackableItem):
		item_stack.item = sale.item_stack.item.duplicate()
	price = sale.price
