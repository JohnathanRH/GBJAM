extends StatusEffect

func _ready() -> void:
	super._ready()
	entity.set_fill_speed.emit(potency)

func reverse_effect() -> void:
	entity.set_fill_speed.emit(1.0)
	queue_free()
