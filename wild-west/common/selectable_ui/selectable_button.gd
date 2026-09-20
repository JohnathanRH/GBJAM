extends NinePatchRect
class_name SelectableButton

@export var select_texture: CompressedTexture2D
var original_texture: CompressedTexture2D
var is_selected: bool

signal pressed

func _ready() -> void:
	original_texture = texture

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("A") and is_selected:
		pressed.emit()

func selected() -> void:
	texture = select_texture
	is_selected = true

func unselected() -> void:
	texture = original_texture
	is_selected = false
