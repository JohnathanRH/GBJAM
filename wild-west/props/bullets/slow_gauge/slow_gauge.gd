extends LingeringBullet
class_name SlowGauge

var gauge_tween: Tween

func fire(at: Entity) -> void:
	remembered_entity = at
	at.register_influence(self)
	gauge_tween = at.gauge_tween
	gauge_tween.set_speed_scale(potency)

func reset_effect() -> void:
	print("Effect reset function triggered")
	if remembered_entity.gauge_tween == gauge_tween:
		print("Effect reset")
		gauge_tween.set_speed_scale(1.0)
