extends Intent
class_name DamageIntent

@export var damage: float

func Enter() -> void:
	player.receive_damage(damage)
