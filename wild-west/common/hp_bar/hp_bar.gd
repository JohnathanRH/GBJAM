extends TextureProgressBar

@onready var entity: Entity = get_parent()

func _ready() -> void:
	entity.ready.connect(_on_entity_ready)

func _on_entity_ready() -> void:
	entity.hp_set.connect(_on_entity_hp_set)
	max_value = entity.max_hp
	value = entity.hp

func _on_entity_hp_set(value: float) -> void:
	self.value = value
	print(self.value)
