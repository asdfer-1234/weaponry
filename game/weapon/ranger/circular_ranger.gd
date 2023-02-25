extends Ranger
class_name CircularRanger

@export var min_range : float = 0
@export var max_range : float = 50

const range_time = 0.5

func extent():
	return max_range

func get_targets(node, group = "stone"):
	var targets : Array = []
	for i in node.get_tree().get_nodes_in_group("stone"):
		var distance : float= node.position.distance_to(i.position)
		if distance >= min_range and distance <= max_range:
			targets.append(i)
	return targets

func _draw(node):
	if(min_range > 0):
		_draw_range_slowly(node, min_range, Palette.red)
	_draw_range_slowly(node, max_range, Palette.foreground)

func tooltip():
	if(min_range <= 0):
		return RichTextBuilder.property_text(tr("RANGE"), 
				RichTextBuilder.color_text(str(max_range), Palette.yellow))
	else:
		return RichTextBuilder.property_text(tr("RANGE"),
				RichTextBuilder.color_text(str(min_range), Palette.red) + "-" + 
				RichTextBuilder.color_text(str(max_range), Palette.green))

func _draw_range_slowly(node, radius, color):
	var time = node.time_since_draw_weapon_details
	node.draw_arc(Vector2.ZERO, ease(time / range_time, 0.2) * radius, 0, TAU, 36, color, 1)
	
func apply_boost(boost):
	max_range = boost.apply(max_range)
	min_range = boost.apply(min_range)
