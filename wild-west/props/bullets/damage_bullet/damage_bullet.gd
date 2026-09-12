extends BulletResource
class_name DamageBullet

func fire(at: Entity) -> void:
	at.hp -= potency
