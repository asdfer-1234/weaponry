extends Node2D

const placable_color = Palette.green
const placable_material = preload("res://graphics/green_outline.tres")
const blocked_color = Palette.red
const blocked_material = preload("res://graphics/red_outline.tres")
const turret = preload("res://game/turret/turret.tscn")
var hold : Turret

signal enter_build
signal end_build

func _process(_delta):
	if hold != null:
		if placable():
			modulate = placable_color
			hold.get_node("Sprite").material = placable_material
			hold.draw_weapon_details = true
			if Input.is_action_pressed("place_turret") and hold != null:
				place_build()
			
		else:
			modulate = blocked_color
			hold.get_node("Sprite").material = blocked_material
func start_build():
	var instantiated : Node2D = turret.instantiate()
	hold = instantiated
	print(hold.get_parent())
	hold.building = true
	add_child(instantiated)
	enter_build.emit()
	get_tree().get_first_node_in_group("turret_selection").deselect()

func placable():
	return hold.get_overlapping_areas().size() == 0;

func place_build():
	var new_parent = get_tree().get_nodes_in_group("turrets")[0]
	var new_position = global_position;
	remove_child(hold);
	new_parent.add_child(hold)
	hold.global_position = new_position
	hold.building = false
	hold = null
	end_build.emit()
