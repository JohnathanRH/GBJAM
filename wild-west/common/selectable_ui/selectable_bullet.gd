extends TextureRect
class_name SelectableBullet

@export var select_texture: CompressedTexture2D
var original_texture: CompressedTexture2D
var is_selected: bool
var bullet_scn: PackedScene:
	set = set_bullet_scene
var bullet: Bullet

signal pressed
signal bullet_scene_set(scene: PackedScene)

func _ready() -> void:
	bullet_scene_set.connect(_on_bullet_scene_set)
	bullet = bullet_scn.instantiate()
	original_texture = texture
	$Icon.texture = bullet.icon

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("A") and is_selected:
		pressed.emit()

func selected() -> void:
	texture = select_texture
	is_selected = true

func unselected() -> void:
	texture = original_texture
	is_selected = false

func _on_bullet_scene_set(scene: PackedScene) -> void:
	var new_bullet = bullet_scn.instantiate()
	bullet = new_bullet
	$Icon.texture = bullet.icon

func set_bullet_scene(scene: PackedScene) -> void:
	#if bullet:
		#bullet.queue_free()
	bullet_scn = scene
	bullet_scene_set.emit(self.bullet_scn)
