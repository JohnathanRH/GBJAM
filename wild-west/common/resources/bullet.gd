@abstract
extends Resource
class_name BulletResource

@export var icon: CompressedTexture2D
@export var potency: Variant
@export var target_amount: int = 1
@export var manual_target_self: bool = false

@abstract func fire(at: Entity) -> void
@abstract func manual_fire(at: Entity) -> void
