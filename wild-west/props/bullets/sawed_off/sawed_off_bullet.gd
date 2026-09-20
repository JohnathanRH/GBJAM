extends Bullet
class_name SawedOffBullet

@export var damage: float

func fire(at: Entity) -> void:
	if at.vulnerable:
		damage += 1
	at.receive_damage(damage)

func manual_fire(at: Entity) -> void:
	player.bullet_container.draw_hand()
