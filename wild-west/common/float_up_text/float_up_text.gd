extends Label
class_name FloatUpText

func _ready() -> void:
	position = position - (size/2)
	$FloatUpAnimation.animation_finished.connect(queue_free)
