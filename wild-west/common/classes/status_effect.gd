extends Node
class_name StatusEffect

@onready var entity: Entity = get_parent()
var potency: Variant

func _ready() -> void:
	if entity is not Entity:
		print("WARNING: Status effect parent is not of type Entity. Freeing...")
		queue_free()

func reverse_effect() -> void:
	pass

func add_duration(duration: float) -> void:
	var timer = LingerTimer.new(duration)
	timer.timeout.connect(reverse_effect)
	add_child(timer)
