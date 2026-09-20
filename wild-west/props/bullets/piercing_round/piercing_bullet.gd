extends Bullet
class_name PiercingRound

@export var damage: float

func fire(at: Entity) -> void:
	at.receive_piercing_damage(damage)

func manual_fire(at: Entity) -> void:
	for status in at.status_container.get_children():
		if status is ShieldedStatus:
			status.queue_free()
			break
