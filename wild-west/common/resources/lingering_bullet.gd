extends BulletResource
class_name LingeringBullet

@export var linger_duration: float
@export var effect_scene: PackedScene

func fire(at: Entity) -> void:
	var effect = effect_scene.instantiate() as StatusEffect
	effect.potency = potency
	
	if linger_duration:
		effect.add_duration(linger_duration)
	
	at.add_child(effect)
