extends TweenAnimation
class_name FloatUpAnimation

@export var distance: float = 15
@export var duration: float = 0.6
@export var finish_signal_delay = 1.4

func _ready() -> void:
	tween.finished.connect(_on_animation_finished)
	super._ready()

func play() -> void:
	var end_y = node.position.y - distance
	tween.tween_property(node, "position:y", end_y, duration)
	tween.play()

func _on_animation_finished() -> void:
	if finish_signal_delay:
		$FinishDelay.wait_time = finish_signal_delay
		$FinishDelay.start()
	else:
		animation_finished.emit()

func _on_finish_delay_timeout() -> void:
	animation_finished.emit()
