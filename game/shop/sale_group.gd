extends Sellable
class_name SaleGroup


@export var sales : Array[Sellable]

func pick(progress):
	var total_weight = 0
	for i in sales:
		total_weight += i.weight(progress)
	var random = randf_range(0, total_weight)
	var current_total = 0
	for i in sales:
		current_total += i.weight(progress)
		if random <= current_total:
			return i.pick(progress)
	print("WHAAAAAAAAAAAT?? IMPOSSIBLE!!!!!!!!!!")
	return sales[0].pick(progress)
