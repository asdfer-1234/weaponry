extends Node

@onready var wave = %WaveCount
@onready var hostile_path = $HostilePaths/HostilePath/PathFollow2D
@onready var stones = $Stones
@onready var next_wave_button = $"../UICanvas/MarginContainer/VBoxContainer2/NextWaveButton"

signal wave_cleared

var spawn_finished = false
var generatable = true:
	set(value):
		generatable = value
		next_wave_button.visible = value


func next_wave():
	if generatable:
		generate()

func _ready():
	wave_cleared.connect(ready_for_next_wave)

func ready_for_next_wave():
	spawn_finished = false
	generatable = true
	%Shop.reroll()
	wave.wave += 1

func generate():
	generatable = false
	wave.current_wave().spawn(self)
	wave.current_wave().spawn_finish.connect(on_spawn_finish)

func on_spawn_finish():
	spawn_finished = true

func spawn_stone(stone : PackedScene, progress = 0):
	
	var instantiated = stone.instantiate()
	hostile_path.progress = progress
	instantiated.global_position = hostile_path.global_position
	instantiated.progress = progress
	stones.add_child(instantiated)
	instantiated.disappear.connect(check_stone_clear)
	return instantiated

func check_stone_clear():
	if spawn_finished:
		for i in stones.get_children():
			if not i.disappeared:
				return
		wave_cleared.emit()
