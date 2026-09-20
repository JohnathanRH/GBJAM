extends StatusEffect
class_name HealOverCycle

@export var damage: float = 1.0
@export var duration_in_cycle: int = 2
var cycle: int = 0

func _ready() -> void:
	entity.tweener.cycle_finished.connect(_on_cycle_finished)

func _on_cycle_finished() -> void:
	entity.hp += 1
	if cycle >= duration_in_cycle:
		queue_free()
	else:
		cycle += 1
