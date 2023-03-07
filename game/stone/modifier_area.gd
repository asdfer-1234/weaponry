extends Area2D
class_name ModifierArea

@export var modifier : Modifier


func _ready():
	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_exit)

func _on_area_enter(area):
	area.add_temporary_modifier(modifier)

func _on_area_exit(area):
	area.remove_temporary_modifier(modifier)
