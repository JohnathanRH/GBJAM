extends Node
class_name GaugeTween

@onready var entity: Entity = get_parent()
var gauge_tween: Tween

func _ready() -> void:
	entity.damage_received.connect(reset_gauge)
	entity.set_fill_speed.connect(set_fill_speed)
	fill_gauge()

func fill_gauge() -> void:
	var max_gauge: float = entity.max_gauge
	var duration: float = entity.entity_resource.gauge_duration
	gauge_tween = create_tween()
	gauge_tween.finished.connect(reset_gauge)
	gauge_tween.finished.connect(entity.fire_bullet)
	gauge_tween.tween_property(entity, "gauge_filled", max_gauge, duration)
	gauge_tween.set_trans(Tween.TRANS_LINEAR)
	gauge_tween.play()

func reset_gauge() -> void:
	if gauge_tween:
		gauge_tween.kill()
	entity.gauge_filled = 0.0
	fill_gauge()

func set_fill_speed(scale: float):
	if gauge_tween.is_valid():
		gauge_tween.set_speed_scale(scale)
