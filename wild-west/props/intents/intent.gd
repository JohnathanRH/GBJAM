@abstract
extends Behaviour
class_name Intent

@export var icon: CompressedTexture2D
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var enemy: Enemy = $"../../"
