# tool

extends Resource
class_name Weapon
export(float) var attack_range : float = 50
export(float) var attack_speed : float = 2
export(Resource) var projectile_damage_resource = Damage.new(Damage.Type.PHYSICAL, 10)
var projectile_damage : Damage setget , get_projectile_damage
export(float) var projectile_speed : float = 350
export(int) var projectile_pierce : int = 1
export(float) var swivel_speed : float = 360
export(Texture) var sprite : Texture = load("res://game/turret/weapon/default_weapon/triangle.png")
export(PackedScene) var projectile : PackedScene = load("res://game/turret/weapon/Projectile.tscn")
export(int) var slotCount = 0

func get_projectile_damage() -> Damage:
	return projectile_damage_resource

func _ready():
	projectile_damage = projectile_damage_resource

func update_attack_range(node : Node):
	if node.has_node("Range/CollisionShape2D"):
		node.get_node("Range/CollisionShape2D").shape.radius = attack_range

func update_attack_speed(node : Node):
	if node.has_node("ShootTimer"):
		node.get_node("ShootTimer").wait_time = 1.0 / attack_speed

func update_sprite(node : Node):
	if node.has_node("Sprite"):
		node.get_node("Sprite").texture = sprite

func update(node : Node):
	update_attack_range(node)
	update_attack_speed(node)
	update_sprite(node)
	
