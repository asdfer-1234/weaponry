extends Effect

@export var interval : float = 0.1
@export var damage : Damage

func _ready():
	super._ready()
	$DamageTimer.wait_time = interval
	$DamageTimer.start()

func damage_stone():
	$"..".damage(damage)

func tooltip():
	return tr("DAMAGE_OVER_TIME_EFFECT").format({"damage" : damage.minimal_tooltip(), "interval" : RichTextBuilder.color_text(str(interval), Palette.yellow)}) + " " + duration_tooltip() + "\n"
