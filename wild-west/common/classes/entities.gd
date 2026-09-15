@abstract
extends AnimatedSprite2D
class_name Entity

@export var entity_resource: EntityResource
var hp: float
var gauge_duration: float = 5.0
var max_gauge: float = 5.0
var bullets: Array[BulletResource]
var selected_bullet: BulletResource

var gauge_filled: float = 0.0
var gauge_tween: Tween
var under_influence: Dictionary[String, LingeringBullet]
var vulnerable: bool = false

func _init() -> void:
	add_to_group("entities")

func _ready() -> void:
	mirror_entity_resource()
	fill_gauge()
	play()

func _physics_process(delta: float) -> void:
	var gauge_filled_ratio = gauge_filled / max_gauge
	if gauge_filled_ratio <= 0.7:
		vulnerable = false
	else:
		vulnerable = true

func fill_gauge() -> void:
	gauge_tween = create_tween()
	gauge_tween.finished.connect(reset_gauge)
	gauge_tween.finished.connect(fire_bullet)
	gauge_tween.tween_property(self, "gauge_filled", max_gauge, gauge_duration)
	gauge_tween.set_trans(Tween.TRANS_LINEAR)
	gauge_tween.play()

@abstract func fire_bullet() -> void

func reset_gauge() -> void:
	if gauge_tween:
		gauge_tween.kill()
	gauge_filled = 0.0
	fill_gauge()

func mirror_entity_resource() -> void:
	hp = entity_resource.hp
	gauge_duration = entity_resource.gauge_duration
	bullets = entity_resource.bullets
	max_gauge = entity_resource.max_gauge
