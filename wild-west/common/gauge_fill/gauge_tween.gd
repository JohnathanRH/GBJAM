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
	
	gauge_tween = create_gauge_tweener(duration)
	gauge_tween.play()

func rewind_gauge(value: float) -> void:
	var duration: float = entity.entity_resource.gauge_duration
	var remaining_time: float = duration - gauge_tween.get_total_elapsed_time()
	if entity is Enemy:
		print(remaining_time)
	if gauge_tween:
		gauge_tween.kill()
	
	entity.gauge_filled = value
	gauge_tween = create_gauge_tweener(remaining_time)
	gauge_tween.play()

func reset_gauge() -> void:
	if gauge_tween:
		gauge_tween.kill()
	entity.gauge_filled = 0.0
	fill_gauge()

func set_fill_speed(scale: float):
	if gauge_tween.is_valid():
		gauge_tween.set_speed_scale(scale)

func create_gauge_tweener(duration: float) -> Tween:
	var max_gauge = entity.max_gauge
	var tween = create_tween()
	tween.finished.connect(reset_gauge)
	tween.finished.connect(entity.fire_bullet)
	tween.tween_property(entity, "gauge_filled", max_gauge, duration)
	tween.set_trans(Tween.TRANS_LINEAR)
	return tween
