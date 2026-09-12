@abstract
extends Resource
class_name BulletResource

@export var icon: CompressedTexture2D
@export var potency: Variant

@abstract func fire(at: Entity) -> void
