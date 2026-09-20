extends Bullet
class_name SteadyAim

@export var damage: float = 2
@export var slow_scale: float = 0.001

var slow_effect = preload("res://props/status_effects/slow_gauge/slow_gauge_scene.tscn")

func fire(at: Entity) -> void:
	at.receive_damage(damage)

func manual_fire(at: Entity) -> void:
	if at.vulnerable:
		at.reset_gauge()
	else:
		at.rewind_gauge(at.gauge_filled - (at.gauge_filled * 0.3))
	var slow: StatusEffect = slow_effect.instantiate()
	slow.potency = 0.3
	slow.add_duration(2.0)
	at.receive_status(slow)
