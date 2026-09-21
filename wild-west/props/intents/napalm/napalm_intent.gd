extends Intent
class_name NapalmIntent

var doc_scn = preload("res://props/status_effects/damage_over_cycle/doc_regular.tscn")
@export var cycles: int = 2

func Enter() -> void:
	if player.vulnerable:
		var doc: DamageOverCycle = doc_scn.instantiate()
		doc.cycle = cycles
		doc.damage = 1.0
		player.receive_status(doc)
