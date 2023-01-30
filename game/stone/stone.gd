extends Area2D
class_name Stone
@onready var map = $"../../.."

@export var speed : float = 10;
@export var health : int = 10;
@export var damage_multipliers = DamageMultipliers.new([])
var progress = 0 : set = set_progress
var died : bool = false
var excluded_projectiles : Array = []
const particle = preload("res://graphics/temporary_particle.tscn")

func set_progress(value):
	progress = value
	if has_node("../../HostilePaths/HostilePath/PathFollow2D"):
		var path_follow = $"../../HostilePaths/HostilePath/PathFollow2D"
		path_follow.progress = progress
		position = path_follow.global_position
		path_follow.progress_ratio = 1
		
		if progress > path_follow.progress:
			queue_free()

func _ready():
	set_progress(progress)
	add_to_group("stone")

func _physics_process(delta):
	movement_process(delta)

func movement_process(delta):
	set_progress(progress + speed * delta)

func damage(amount : Damage):
	health -= damage_multipliers.multiply(amount).damage
	if health <= 0:
		die()

func die():
	if not died:
		died = true
		queue_free()
		call_deferred("on_die")
		spawn_particle()

func on_die():
	pass

func spawn_stone(stone : PackedScene, amount : int = 1, spacing : float = 5):
	var offset = -(amount * spacing / 2.0)
	for i in range(amount):
		var instantiated : Node = stone.instantiate()
		instantiated.progress = progress + offset + spacing * i
		instantiated.excluded_projectiles = excluded_projectiles.duplicate()
		get_parent().add_child(instantiated)

func spawn_particle():
	var instantiated = particle.instantiate()
	instantiated.global_position = global_position
	get_parent().add_child(instantiated)
