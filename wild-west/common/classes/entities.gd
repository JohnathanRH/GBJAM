@abstract
extends AnimatedSprite2D
class_name Entity

var float_text_scn = preload("res://common/float_up_text/float_up_text.tscn")

@export var entity_resource: EntityResource
var max_hp: float
var hp: float:
	set = set_hp
var gauge_duration: float = 5.0
var max_gauge: float = 5.0
var has_shield: bool

var gauge_filled: float = 0.0
var under_influence: Dictionary[String, LingeringBullet]
var vulnerable: bool = false
var tweener: GaugeTween
var status_container: StatusContainer
var tween: Tween

signal set_fill_speed(scale)
signal damage_received
signal dead(entity: Entity)
signal hp_set(value: float)

func _init() -> void:
	tweener = GaugeTween.new()
	status_container = StatusContainer.new()
	add_child(tweener)
	add_child(status_container)
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
	if vulnerable and !has_shield:
		hp -= dam
		damage_received.emit()
		spawn_text(str(dam))
		receive_damage_motion()

func receive_piercing_damage(dam: float) -> void:
	if vulnerable:
		hp -= dam
		damage_received.emit()
		spawn_text(str(dam))
		receive_damage_motion()

func set_hp(value: float) -> void:
	if value >= max_hp:
		hp = max_hp
	else:
		hp = value
		hp_set.emit(hp)
		if hp <= 0:
			dead.emit(self)
			death()

func rewind_gauge(gauge_value: float)  -> void:
	tweener.rewind_gauge(gauge_value)

func reset_gauge() -> void:
	tweener.reset_gauge()

func receive_status(status: StatusEffect) -> void:
	status_container.add_child(status)

func spawn_text(str: String) -> void:
	var label: FloatUpText = float_text_scn.instantiate()
	label.text = str
	add_child(label)
	
func receive_damage_motion() -> void:
	if tween and tween.is_running():
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(self, "skew", -0.2, 0.1)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "skew", 0.4, 0.08)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(self, "scale:x", 1.3, 0.08)
	tween.tween_property(self, "skew", 0.0, 0.15)\
		.set_trans(Tween.TRANS_BACK)\
		.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale:x", 1.0, 0.15)


func attack_motion(dir: bool) -> void:
	if tween and tween.is_running():
		tween.kill()
	
	var attack_dir: float = -1.0 if dir else 1.0
	
	var lunge_distance: float = 10.0 * attack_dir
	var max_skew: float = -0.4 * attack_dir 
	var original_position := self.position
	
	var tween = create_tween()
	
	tween.tween_property(self, "position:x", position.x + lunge_distance, 0.15)\
		.set_trans(Tween.TRANS_CUBIC)\
		.set_ease(Tween.EASE_OUT)
		
	tween.tween_property(self, "skew", max_skew, 0.10)\
		.set_trans(Tween.TRANS_QUAD)\
		.set_ease(Tween.EASE_OUT)
		
	tween.chain().set_parallel(true)
	
	tween.tween_property(self, "skew", 0.0, 0.15)\
		.set_trans(Tween.TRANS_ELASTIC)\
		.set_ease(Tween.EASE_OUT)
		
	tween.tween_property(self, "position:x", position.x + (lunge_distance * 0.8), 0.2)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
		
	tween.tween_property(self, "position:x", original_position.x, 0.2)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
