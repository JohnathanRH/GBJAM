extends StatusEffect
class_name ShieldedStatus

func _ready() -> void:
	super._ready()
	entity.has_shield = true

func reverse_effect() -> void:
	entity.has_shield = false
