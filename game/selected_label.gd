extends Label

@onready var container = $"../HBoxContainer2/SlotContainer"
var container_child_count = 0


func _ready():
	check_toggle()

func check_toggle():
	visible = container_child_count != 0

func _on_slot_container_child_entered_tree(_node):
	container_child_count += 1
	check_toggle()

func _on_slot_container_child_exiting_tree(_node):
	container_child_count -= 1
	check_toggle()
