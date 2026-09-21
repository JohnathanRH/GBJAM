extends Bullet
class_name ShortFuseBullet

var damage_over_cycle = preload("res://props/status_effects/damage_over_cycle/doc_regular.tscn")
var heal_over_cycle = preload("res://props/status_effects/heal_over_cycle/hoc_regular.tscn")

func fire(at: Entity) -> void:
	if at.vulnerable:
		var doc = damage_over_cycle.instantiate() as DamageOverCycle
		at.receive_status(doc)

func manual_fire(at: Entity) -> void:
	var hoc = heal_over_cycle.instantiate()
	at.receive_status(hoc)
