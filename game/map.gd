extends Node

@onready var wave = %WaveCount

@onready var stones = $"../StoneCanvas"
@onready var next_wave_button = $"../UICanvas/MarginContainer/VBoxContainer2/NextWaveButton"
@onready var wave_description = $"../UICanvas/FrameControl/WaveDescription"


signal wave_cleared

var spawn_finished = false
var generatable = true:
	set(value):
		generatable = value
		next_wave_button.visible = value
var hostile_path_index : int = 0

func next_wave():
	if generatable:
		generate()

func _ready():
	wave_cleared.connect(ready_for_next_wave)
	update_wave_description()

func ready_for_next_wave():
	spawn_finished = false
	generatable = true
	%Shop.reroll()
	wave.wave += 1
	update_wave_description()

func generate():
	clear_wave_description()
	generatable = false
	wave.current_wave().spawn(self)
	wave.current_wave().spawn_finish.connect(on_spawn_finish)

func on_spawn_finish():
	spawn_finished = true

func get_hostile_path():
	var returner = $"../MapUnique/HostilePaths".get_child(hostile_path_index)
	hostile_path_index += 1
	if hostile_path_index >= $"../MapUnique/HostilePaths".get_child_count():
		hostile_path_index = 0
	return returner

func spawn_stone_begin(stone : PackedScene):
	spawn_stone(stone, get_hostile_path())

func spawn_stone(stone : PackedScene, hostile_path : Path2D, progress = 0) -> Stone:
	var instantiated : Stone = stone.instantiate()
	instantiated.path = hostile_path
	instantiated.progress = progress
	instantiated.global_position = instantiated.path.get_node("PathFollow2D").global_position
	stones.add_child(instantiated)
	instantiated.disappear.connect(check_stone_clear)
	return instantiated

func check_stone_clear():
	if spawn_finished:
		for i in stones.get_children():
			if not i.disappeared:
				return
		wave_cleared.emit()

func end():
	wave_cleared.disconnect(ready_for_next_wave)
func update_wave_description():
	if wave.wave < len(wave.waves.waves):
		var translation_key = "TUTORIAL_" + str(wave.wave)
		var translated = tr(translation_key)
		if translation_key != translated:
			wave_description.text = translated
func clear_wave_description():
	wave_description.text = ""

