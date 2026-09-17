extends LingeringBullet
class_name DamageBullet

func fire(at: Entity) -> void:
	at.receive_damage(potency)

func manual_fire(at: Entity) -> void:
	at.add_child(status_effect())
