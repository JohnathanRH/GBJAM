extends Sprite2D
class_name GaugeIcon

var duration: float
var start_position: Vector2
var end_position: Vector2
var entity: Entity
var filled_ratio: float
var safe_segment: float

@onready var x_difference = end_position.x - start_position.x

func _ready() -> void:
	entity.dead.connect(_on_entity_death)
	if !entity.entity_resource.gauge_icon:
		print("WARNING: No gauge icon detected in "+ entity.name +" resource")
	texture = entity.entity_resource.gauge_icon
	position = start_position
	
	if entity is Enemy:
		entity.targeted.connect(_on_entity_targeted)

func _process(delta: float) -> void:
	filled_ratio = entity.gauge_filled / entity.max_gauge
	var current_position = Vector2(start_position.x + (x_difference * filled_ratio), start_position.y)
	position = current_position

func reset() -> void:
	position = start_position

func _on_entity_targeted(status: bool) -> void:
	#print(status)
	if status:
		scale += Vector2(0.25, 0.25)
	else:
		scale -= Vector2(0.25, 0.25)

func _on_entity_death(entity: Entity):
	queue_free()
