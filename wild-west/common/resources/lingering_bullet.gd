@abstract
extends BulletResource
class_name LingeringBullet

@export var linger_duration: float
@export var effect_potency: float
@export var effect_scene: PackedScene

func status_effect() -> StatusEffect:
	var effect = effect_scene.instantiate() as StatusEffect
	effect.potency = effect_potency
	
	if linger_duration:
		effect.add_duration(linger_duration)
	return effect
