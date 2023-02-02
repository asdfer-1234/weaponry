extends Ranger
class_name CircularRanger

@export var min_range : float = 0
@export var max_range : float = 50

func get_targets(node):
	var targets : Array = []
	for i in node.get_tree().get_nodes_in_group("stone"):
		var distance : float= node.position.distance_to(i.position)
		if distance >= min_range and distance <= max_range:
			targets.append(i)
	return targets

func _draw(node):
	if(min_range > 0):
		node.draw_arc(Vector2.ZERO, min_range, 0, TAU, 36, Palette.foreground, 1)
	node.draw_arc(Vector2.ZERO, max_range, 0, TAU, 36, Palette.foreground, 1)

func tooltip():
	if(min_range <= 0):
		return "RANGE:" + RichTextBuilder.color_text(max_range, Palette.green) + "\n"
	else:
		return "RANGE:" + RichTextBuilder.color_text(min_range, Palette.red) + "-"+ RichTextBuilder.color_text(max_range, Palette.green) + "\n"
