extends Area2D
class_name Stone

# Basic Stats
@export var speed : float = 100
@export var health : int = 10
@export var damage_multipliers : DamageMultipliers
@export var health_damage : int = 1
@export var gold_reward : int = 1

# Onready Plug-like stuff
@onready var damage_effect_canvas = $"../../DamageEffectCanvas"
@onready var map = $"../../Map"
const particle = preload("res://graphics/temporary_particle.tscn")
const damage_effect = preload("res://game/damage_effect/damage_effect.tscn")
const death_audio = preload("res://game/stone/death.wav")
var path : Path2D

# How much the stone has traveled - a property
var progress: float = 0:
	set(value):
		progress = value
		_set_position_from_progress()

# The parent's and self's id
var inherited_id : Array[int] = []

# Is the stone disappearing
var expired : bool = false

signal death # On death
signal goal # When reaching the end
signal expire # When death or goal is emitted this emits too

func _set_position_from_progress():
	global_position = path.get_position_from_progress(progress)
	if progress >= path.max_progress:
		goal_reach()

func _ready():
	add_to_group("stone")
	inherited_id.append(IdGiver.get_id())
	_set_position_from_progress()
	_connect_expire()

func _connect_expire():
	death.connect(_emit_expire)
	goal.connect(_emit_expire)

func _physics_process(delta):
	movement_process(delta)

func movement_process(delta):
	progress += speed * delta

func recieve_damage(amount : Damage):
	var new_damage = amount
	if damage_multipliers != null:
		new_damage = damage_multipliers.multiply(amount)
	var effect_damage : Damage = Damage.new()
	effect_damage.damage = max(new_damage.damage, 1)
	effect_damage.type = amount.type
	health -= effect_damage.damage
	_instantiate_damage_effect(effect_damage)
	if health <= 0:
		die()

func knockback(distance):
	progress -= distance

func _instantiate_damage_effect(damage : Damage):
	var instantiated = damage_effect.instantiate()
	instantiated.set_damage(damage)
	instantiated.global_position = global_position
	damage_effect_canvas.add_child(instantiated)

func die():
	if not expired:
		Audio.play_audio(death_audio)
		spawn_particle()
		$"../%Gold".gold += gold_reward
		expired = true
		_emit_death.call_deferred()
		queue_free()

func _emit_death():
	death.emit()

func spawn_stone(stone : PackedScene, amount : int = 1, spacing : float = 5):
	var offset = -(amount * spacing / 2.0)
	for i in range(amount):
		var instantiated = map.spawn_stone(stone, path, progress + offset + spacing * i, inherited_id)

func spawn_particle():
	var instantiated = particle.instantiate()
	instantiated.global_position = global_position
	damage_effect_canvas.add_child(instantiated)

func get_nearby_stones_by_distance(distance):
	var result = []
	for i in get_parent().get_children():
		if position.distance_to(i.position) <= distance:
			result.append(i)
	return result

func get_nearby_stones_by_progress(backward_range, forward_range):
	var result = []
	for i in get_parent().get_children():
		if (i.path == path and
				i.progress <= progress + forward_range and
				i.progress >= progress - backward_range):
			result.append(i)
	return result

func goal_reach():
	queue_free()
	$"../%Health".health -= health_damage
	expired = true
	goal.emit()

func add_effect(effect):
	var effect_path = NodePath(effect.get_state().get_node_name(0))
	if has_node(effect_path):
		get_node(effect_path).reload()
	else:
		add_child(effect.instantiate())

func _emit_expire():
	expire.emit()

func has_common_id(array : Array[int]):
	for i in array:
		if inherited_id.has(array[i]):
			return true
	return false
