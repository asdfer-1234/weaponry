extends Ranger
class_name CircularRanger

@export var min_range : float = 0
@export var max_range : float = 50

const range_time = 0.5


func get_targets(node):
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
		return "RANGE:" + RichTextBuilder.color_text(max_range, Palette.green) + "\n"
	else:
		return "RANGE:" + RichTextBuilder.color_text(min_range, Palette.red) + "-"+ RichTextBuilder.color_text(max_range, Palette.green) + "\n"

func _draw_range_slowly(node, range, color):
	var time = node.time_since_draw_weapon_details
	node.draw_arc(Vector2.ZERO, ease(time / range_time, 0.2) * range, 0, TAU, 36, color, 1)
	