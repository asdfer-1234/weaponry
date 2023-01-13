tool
extends Node2D

export(Resource) var default_weapon_resource : Resource setget set_default_weapon
export(Resource) var weapon_resource : Resource setget set_weapon
var default_weapon : Weapon
var weapon : Weapon setget set_weapon, get_weapon
const attack_angle : float = 2.0
var building : bool = false
var mouse_over = false


signal mouse_enter
signal mouse_exit
signal select

func set_default_weapon(set):
	default_weapon = set
	default_weapon_resource = set
	get_weapon().update(self)

func set_weapon(set):
	weapon = set
	weapon_resource = set
	get_weapon().update(self)

func get_weapon():
	if weapon == null:
		return default_weapon
	return weapon

func _ready():
	set_default_weapon(default_weapon_resource)
	set_weapon(weapon_resource)
	var turret_selection = get_tree().get_nodes_in_group("turret_selection")[0]
	connect("mouse_enter", turret_selection, "mouse_enter", [self])
	connect("mouse_exit", turret_selection, "mouse_exit", [self])
	connect("select", turret_selection, "select", [self])


func a():
	print("a")
func b():
	print("b")
func c():
	print("c")

func _process(_delta):
	if not Engine.editor_hint and mouse_over and Input.is_action_pressed("select_turret"):
		emit_signal("select")

func _physics_process(delta : float):
	if not Engine.editor_hint and not building:
		turret_process(delta)

func turret_process(delta : float):
	var target = get_target()
	if target != null:
		swivel(target, delta)
		if shootable(target) && $ShootTimer.is_stopped():
			shoot(target)

func get_target():
	var enemies = get_tree().get_nodes_in_group("stone")
	
	if enemies.empty():
		return
	
	var max_progressed = null
	
	for i in enemies:
		if max_progressed == null or i.progress > max_progressed.progress:
			if $Range.overlaps_area(i):
				max_progressed = i
	if max_progressed != null:
		return max_progressed.position


func swivel(target : Vector2, delta : float):
	var target_rotation = (target - global_position).angle()
	var relative_swivel = angle_difference(global_rotation, target_rotation)
	var swivel_limit = deg2rad(get_weapon().swivel_speed) * delta
	if relative_swivel > 0:
		rotate(min(relative_swivel, swivel_limit))
	else:
		rotate(max(relative_swivel, -swivel_limit))

func shootable(target : Vector2):
	var target_rotation = (target - global_position).angle()
	return abs(angle_difference(target_rotation, global_rotation)) <= deg2rad(attack_angle)


func shoot(_target):
	$ShootTimer.start()
	instantiate_projectile()

func instantiate_projectile():
	var projectile = get_weapon().projectile
	var instantiated = projectile.instance()
	instantiated.global_position = global_position
	instantiated.global_rotation = global_rotation
	instantiated.speed = get_weapon().projectile_speed
	
	instantiated.damage = get_weapon().projectile_damage
	print(get_weapon().projectile_damage)
	print(instantiated.damage)
	instantiated.pierce = get_weapon().projectile_pierce
	get_parent().add_child(instantiated)	

func angle_difference(from : float, to : float):
	var ans = fposmod(to - from, TAU)
	if ans > PI:
		ans -= TAU
	return ans

func _mouse_enter():
	print("_mouse_enter")
	mouse_over = true
	emit_signal("mouse_enter")

func _mouse_exit():
	print("_mouse_exit")
	mouse_over = false
	emit_signal("mouse_exit")

