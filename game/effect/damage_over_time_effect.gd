extends Effect

@export var interval : float = 0.1
@export var damage : Damage

func _ready():
	super._ready()
	$DamageTimer.wait_time = interval
	$DamageTimer.start()

func damage_stone():
	print("adsf")
	$"..".damage(damage)
