@abstract
extends Node
class_name TweenAnimation

@export var auto_play: bool
@export var node: Node = get_parent()

var tween: Tween
signal animation_finished

func _init() -> void:
	tween = create_tween()
	tween.finished.connect(_on_animation_finished)

func _ready() -> void:
	if auto_play:
		play()

@abstract func play() -> void
@abstract func _on_animation_finished() -> void
