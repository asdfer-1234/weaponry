extends Area2D

onready var map = $"../../.."

export var speed: int;
export var health: int;
var progress = 0 setget set_progress


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

func _physics_process(_delta):
	movement_process()

func movement_process():
	set_progress(progress + speed)

func damage(amount : int):
	health -= amount
	if health <= 0:
		die()	

func die():
	queue_free()
	call_deferred("on_die")

func on_die():
	pass

func spawn_stone(stone : PackedScene, amount : int = 1, spacing : float = 5):
	var offset = -(amount * spacing / 2.0)
	for i in range(amount):
		var instantiated : Node = stone.instance()
		instantiated.progress = progress + offset + spacing * i
		get_parent().add_child(instantiated)
		pass
