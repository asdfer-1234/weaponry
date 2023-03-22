extends Node

var paused = false:
	set(value):
		paused = value
		$PauseEnable.visible = paused
		if paused:
			var tooltip = get_tree().get_first_node_in_group("tooltip")
			if tooltip != null:
				tooltip.clear()
			Engine.time_scale = 0
		else:
			Engine.time_scale = 1


func _input(event):
	if event.is_action_pressed("pause") and ($"../Game/%Builder" == null or $"../Game/%Builder".hold == null):
		paused = not paused

func pause():
	paused = true
	
func unpause():
	paused = false


