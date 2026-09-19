extends Bullet
class_name DesperadoBullet

@export var damage: float = 2
@export var heal: float = 1

func fire(at: Entity) -> void:
	var hp_ratio: float = player.hp / player.max_hp
	var clean_damage: float
	if hp_ratio <= 0.5:
		clean_damage = damage + 1
	
	at.receive_damage(clean_damage)

func manual_fire(at: Entity) -> void:
	player.hp += heal
