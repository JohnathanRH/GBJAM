extends Node
class_name Bullet

@export var icon: CompressedTexture2D
#@export var potency: Variant
@export var target_amount: int = 1
@export var manual_target_self: bool = false

@onready var player: Player = get_tree().get_first_node_in_group("player")

func fire(at: Entity) -> void:
	pass

func manual_fire(at: Entity) -> void:
	pass
