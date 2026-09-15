extends StatusEffect

var tween: Tween

func _ready() -> void:
	super._ready()
	tween = entity.gauge_tween
	tween.set_speed_scale(potency)

func reverse_effect() -> void:
	if tween == entity.gauge_tween:
		tween.set_speed_scale(1.0)
	queue_free()
