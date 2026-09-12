@abstract
extends BulletResource
class_name LingeringBullet

@export var linger_duration: float
var remembered_entity: Entity

@abstract func reset_effect() -> void
