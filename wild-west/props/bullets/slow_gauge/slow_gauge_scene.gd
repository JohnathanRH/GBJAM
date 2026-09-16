extends StatusEffect

var tween: Tween

func _ready() -> void:
	super._ready()
	entity.set_fill_speed.emit(potency)

func reverse_effect() -> void:
	#if tween == entity.gauge_tween:
	entity.set_fill_speed.emit(1.0)
	queue_free()
