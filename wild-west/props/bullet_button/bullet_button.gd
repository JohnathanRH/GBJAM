extends TextureRect
class_name BulletButton

@export var normal_texture: CompressedTexture2D
@export var selected_texture: CompressedTexture2D


var bullet: Bullet

func selected() -> void:
	texture = selected_texture

func unselected() -> void:
	texture = normal_texture

func set_icon(texture: CompressedTexture2D) -> void:
	$Icon.texture = texture
