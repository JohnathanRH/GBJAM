extends Bullet
class_name WarningShotBulet

@export var damage: float = 1
@export var shielded_duration: float = 3.0
var shielded_status = preload("res://props/status_effects/shielded/shielded_status_regular.tscn")

func fire(at: Entity) -> void:
	if at.vulnerable:
		at.reset_gauge()
	at.receive_damage(damage)

func manual_fire(at: Entity) -> void:
	var shielded: ShieldedStatus = shielded_status.instantiate()
	shielded.add_duration(shielded_duration)
	player.receive_status(shielded)
