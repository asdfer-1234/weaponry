extends Area2D

onready var map = $"../../.."

export var speed : float = 10;
export var health : int;
export(Resource) var damage_multipliers_resource : Resource = DamageMultipliers.new([])
var damage_multipliers : DamageMultipliers
var progress = 0 setget set_progress
var died : bool = false
var excluded_projectiles : Array = []
const particle = preload("res://graphics/TemporaryParticle.tscn")

func set_progress(set):
	progress = set
	if has_node("../../HostilePaths/HostilePath/PathFollow2D"):
		var path_follow = $"../../HostilePaths/HostilePath/PathFollow2D"
		path_follow.offset = progress
		position = path_follow.global_position
		path_follow.unit_offset = 1
		
		if progress > path_follow.offset:
			get_parent().remove_child(self)

func _ready():
	set_progress(progress)
	add_to_group("stone")
	damage_multipliers = damage_multipliers_resource

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
		var instantiated : Node = stone.instance()
		instantiated.progress = progress + offset + spacing * i
		instantiated.excluded_projectiles = excluded_projectiles.duplicate()
		get_parent().add_child(instantiated)

func spawn_particle():
	var instantiated = particle.instance()
	instantiated.global_position = global_position
	get_parent().add_child(instantiated)
