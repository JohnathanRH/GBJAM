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

func _init() -> void:
	add_to_group("entities")

func _ready() -> void:
	mirror_entity_resource()
	fill_gauge()
	play()

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

func register_influence(bullet: LingeringBullet) -> void:
	var timer = LingerTimer.new()
	timer.wait_time = bullet.linger_duration
	timer.timeout.connect(bullet.reset_effect)
	timer.timeout.connect(checkout_influence)
	add_child(timer)
	
	#under_influence[bullet.resource_name] = bullet
	

func checkout_influence() -> void:
	print("Checked out")
	pass
	#under_influence
	#under_influence.front
	#under_influence.pop_front()

func mirror_entity_resource() -> void:
	hp = entity_resource.hp
	gauge_duration = entity_resource.gauge_duration
	bullets = entity_resource.bullets
	max_gauge = entity_resource.max_gauge
