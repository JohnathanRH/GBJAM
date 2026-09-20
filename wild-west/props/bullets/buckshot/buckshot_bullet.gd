extends Bullet
class_name BuckshotBullet

@export var damage: float = 1.0
var slow_effect = preload("res://props/status_effects/slow_gauge/slow_gauge_scene.tscn")

func fire(at: Entity) -> void:
	at.receive_damage(1)

func manual_fire(at: Entity) -> void:
	var slow: StatusEffect = slow_effect.instantiate()
	slow.potency = 0.6
	slow.add_duration(4.0)
	at.receive_status(slow)
