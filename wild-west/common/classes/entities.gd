@abstract
extends AnimatedSprite2D
class_name Entity

var float_text_scn = preload("res://common/float_up_text/float_up_text.tscn")

@export var entity_resource: EntityResource
var max_hp: float
var hp: float
var gauge_duration: float = 5.0
var max_gauge: float = 5.0

var gauge_filled: float = 0.0
var under_influence: Dictionary[String, LingeringBullet]
var vulnerable: bool = false

signal set_fill_speed(scale)
signal damage_received
signal dead(entity: Entity)

func _init() -> void:
	var tweener: GaugeTween = GaugeTween.new()
	add_child(tweener)
	add_to_group("entities")

func _ready() -> void:
	mirror_entity_resource()
	play()

func _physics_process(delta: float) -> void:
	var gauge_filled_ratio = gauge_filled / max_gauge
	if gauge_filled_ratio <= entity_resource.safe_segment:
		vulnerable = false
	else:
		vulnerable = true

@abstract func fire_bullet() -> void
@abstract func death() -> void

func mirror_entity_resource() -> void:
	max_hp = entity_resource.max_hp
	hp = entity_resource.max_hp
	gauge_duration = entity_resource.gauge_duration
	max_gauge = entity_resource.max_gauge

func receive_damage(dam: float) -> void:
	#print(dam)
	if vulnerable:
		#print(dam)
		hp -= dam
		damage_received.emit()
		var label: FloatUpText =  float_text_scn.instantiate()
		label.text = str(dam)
		add_child(label)
	if hp <= 0:
		dead.emit(self)
		death()
