extends Intent
class_name SlowIntent

@export var speed_scale: float
@export var duration: float
var slow_scn = preload("res://props/bullets/slow_gauge/slow_gauge_scene.tscn")

func Enter() -> void:
	var slow_effect: StatusEffect = slow_scn.instantiate()
	slow_effect.potency = speed_scale
	slow_effect.add_duration(duration)
	player.add_child(slow_effect)
