extends TextureRect
class_name BulletButton

@export var normal_texture: CompressedTexture2D
@export var selected_texture: CompressedTexture2D

@export var select_scale: Vector2 = Vector2(1.1, 1.1)
@export var normal_scale: Vector2 = Vector2(1.0, 1.0)
@export var animation_time: float = 0.15

var bullet: Bullet
var tween: Tween

func selected() -> void:
	texture = selected_texture
	_animate_scale(select_scale)

func unselected() -> void:
	texture = normal_texture
	_animate_scale(normal_scale)

func set_icon(texture: CompressedTexture2D) -> void:
	$Icon.texture = texture

func _animate_scale(target_scale: Vector2) -> void:
	if tween and tween.is_running():
		tween.kill()
		
	tween = create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_QUAD)
	
	tween.tween_property(self, "scale", target_scale, animation_time)
