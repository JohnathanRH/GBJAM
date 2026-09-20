extends Intent
class_name BlockIntent

@export var shielded_duration: float
var shielded_status = preload("res://props/status_effects/shielded/shielded_status_regular.tscn")

func Enter() -> void:
	var shielded: ShieldedStatus = shielded_status.instantiate()
	shielded.add_duration(shielded_duration)
	enemy.receive_status(shielded)
