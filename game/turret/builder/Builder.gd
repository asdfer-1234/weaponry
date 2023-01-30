extends Node2D

const placable_color = Palette.green
const blocked_color = Palette.red
const turret = preload("res://game/turret/turret.tscn")
var hold : Node

signal start_build
signal end_build

func _process(_delta):
	if hold != null:
		if placable():
			modulate = placable_color
			if Input.is_action_pressed("place_turret") and hold != null:
				place_build()
		else:
			modulate = blocked_color

func _start_build():
	var instantiated : Node2D = turret.instance()
	instantiated.set_process(false)
	instantiated.set_physics_process(false)
	hold = instantiated
	hold.building = true
	add_child(instantiated)
	start_build.emit()

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
